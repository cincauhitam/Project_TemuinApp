import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final String baseUrl =
      "https://ynrlazotnpftjyziovky.supabase.co";
  final String anonKey =
      "sb_publishable_m4emukdfkUxoFHBhi36yPg__1DYqmWb";

  // Google OAuth configuration
  final String googleWebClientId = "543691766095-macsqg4ftq74ktrb4lk9hospsjsmbbas.apps.googleusercontent.com";
  final String androidClientId = "543691766095-7f24hkktrq14uc76hg5u0tq0eikog2ul.apps.googleusercontent.com";
  late GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final scopes= ['email', 'profile'];

  // Use the initialized Supabase singleton instance
  SupabaseClient get _supabaseClient {
    if (!Supabase.instance.isInitialized) {
      throw Exception(
        'Supabase is not initialized. Please restart the app or ensure Supabase.initialize() is called in main.dart'
      );
    }
    return Supabase.instance.client;
  }

  AuthService() {
    // Initialize Google Sign-In with your web client ID
    _googleSignIn.initialize(
      serverClientId: googleWebClientId,
      clientId: androidClientId,
    );
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Use Supabase client's signInWithPassword to properly set the session
      final AuthResponse response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null && response.user != null) {
        return {
          'user': response.user!.toJson(),
          'session': {
            'access_token': response.session!.accessToken,
            'refresh_token': response.session!.refreshToken,
            'expires_in': response.session!.expiresIn,
            'user': response.user!.toJson(),
          }
        };
      } else {
        throw Exception('Login failed: No session created');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      // Use Supabase client's signUp to properly register the user
      final AuthResponse response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Check if session exists (email confirmation might be disabled)
        if (response.session != null) {
          return {
            'user': response.user!.toJson(),
            'session': {
              'access_token': response.session!.accessToken,
              'refresh_token': response.session!.refreshToken,
              'expires_in': response.session!.expiresIn,
              'user': response.user!.toJson(),
            },
            'confirmation_required': false,
          };
        } else {
          // Email confirmation is required
          return {
            'user': response.user!.toJson(),
            'session': null,
            'confirmation_required': true,
            'message': 'Please check your email to confirm your account',
          };
        }
      } else {
        throw Exception('Signup failed: No user created');
      }
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }

  /// Sign in with Google OAuth provider through Supabase
  /// Returns the authentication response from Supabase
  Future<AuthResponse> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();

      if (googleUser == null) {
        throw Exception('Google sign-in was cancelled by user');
      }

      /// Authorization is required to obtain the access token with the appropriate scopes for Supabase authentication,
      /// while also granting permission to access user information.
      final authorization = await googleUser.authorizationClient.authorizationForScopes(scopes) ?? await googleUser.authorizationClient.authorizeScopes(scopes);

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken == null) {
        throw Exception('Failed to get Google ID token');
      }

      // Sign in to Supabase using the Google ID token
      final AuthResponse response = await _supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: authorization.accessToken,
      );

      return response;
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
  }

  /// Sign out from both Google and Supabase
  Future<void> signOutGoogle() async {
    try {
      // Sign out from Supabase
      await _supabaseClient.auth.signOut();

      // Sign out from Google
      await _googleSignIn.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  /// Get current user session from Supabase
  Session? getCurrentSession() {
    return _supabaseClient.auth.currentSession;
  }

  /// Get current user from Supabase
  User? getCurrentUser() {
    return _supabaseClient.auth.currentUser;
  }

  /// Check if user is currently signed in
  bool isSignedIn() {
    return _supabaseClient.auth.currentSession != null;
  }

  /// Check if user profile is created
  Future<bool> isProfileCreated() async {
    try {
      final user = getCurrentUser();
      if (user == null) return false;

      final response = await _supabaseClient
          .from('profile')
          .select('profile_created')
          .eq('id', user.id)
          .maybeSingle();

      if (response == null) return false;

      return response['profile_created'] == true;
    } catch (e) {
      print('Error checking profile status: $e');
      return false;
    }
  }

  /// Check if username is available
  Future<bool> isUsernameAvailable(String username) async {
    try {
      final response = await _supabaseClient
          .from('profile')
          .select('username')
          .eq('username', username)
          .maybeSingle();

      // If response is null, username is available
      return response == null;
    } catch (e) {
      throw Exception('Failed to check username availability: $e');
    }
  }

  /// Validate profile data
  Map<String, String>? validateProfileData(Map<String, dynamic> profileData) {
    final errors = <String, String>{};

    // Validate username
    final username = profileData['username']?.toString().trim() ?? '';
    if (username.isEmpty) {
      errors['username'] = 'Username is required';
    } else if (username.length < 3) {
      errors['username'] = 'Username must be at least 3 characters';
    } else if (username.length > 30) {
      errors['username'] = 'Username must not exceed 30 characters';
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
      errors['username'] = 'Username can only contain letters, numbers, and underscores';
    }

    // Validate full name
    final fullName = profileData['full_name']?.toString().trim() ?? '';
    if (fullName.isEmpty) {
      errors['full_name'] = 'Full name is required';
    } else if (fullName.length < 2) {
      errors['full_name'] = 'Full name must be at least 2 characters';
    }

    // Validate age
    final age = profileData['age'];
    if (age == null) {
      errors['age'] = 'Age is required';
    } else if (age < 13) {
      errors['age'] = 'You must be at least 13 years old';
    } else if (age > 100) {
      errors['age'] = 'Please enter a valid age';
    }

    // Validate height if provided
    final height = profileData['height'];
    if (height != null && (height < 140 || height > 250)) {
      errors['height'] = 'Height must be between 140 and 250 cm';
    }

    // Validate role
    final role = profileData['role']?.toString().trim() ?? '';
    if (role.isEmpty) {
      errors['role'] = 'Role is required';
    }

    // Validate level
    final level = profileData['level']?.toString().trim() ?? '';
    if (level.isEmpty) {
      errors['level'] = 'Level is required';
    }

    return errors.isEmpty ? null : errors;
  }

  /// Create or update user profile using Supabase Edge Function
  Future<Map<String, dynamic>> createUserProfile(
    Map<String, dynamic> profileData, {
    String? profilePictureBase64,
    String? profilePictureFilename,
  }) async {
    try {
      // Get the current user's access token
      final session = getCurrentSession();
      if (session == null) {
        throw Exception('User is not authenticated');
      }

      final url = Uri.parse('$baseUrl/functions/v1/profile-update');

      // Prepare request body
      final requestBody = <String, dynamic>{
        'profile_data': profileData,
      };

      // Add profile picture if provided
      if (profilePictureBase64 != null && profilePictureFilename != null) {
        requestBody['profile_picture'] = profilePictureBase64;
        requestBody['profile_picture_filename'] = profilePictureFilename;
      }

      print('Calling profile-update API at: $url');
      print('Profile data: $profileData');

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${session.accessToken}',
          'apikey': anonKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData,
          'error': null,
        };
      } else {
        try {
          final errorData = jsonDecode(response.body);
          return {
            'success': false,
            'data': null,
            'error': errorData['error'] ?? errorData['message'] ?? 'Failed to create profile. Status: ${response.statusCode}',
          };
        } catch (e) {
          return {
            'success': false,
            'data': null,
            'error': 'Failed to create profile. Status: ${response.statusCode}, Body: ${response.body}',
          };
        }
      }
    } catch (e) {
      print('Error creating profile: $e');
      return {
        'success': false,
        'data': null,
        'error': e.toString(),
      };
    }
  }
}
