import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final String baseUrl =
      "https://ynrlazotnpftjyziovky.supabase.co"; // your Supabase project URL
  final String anonKey =
      "sb_publishable_m4emukdfkUxoFHBhi36yPg__1DYqmWb"; // replace with your real anon key

  // Google OAuth configuration
  final String googleWebClientId = "543691766095-macsqg4ftq74ktrb4lk9hospsjsmbbas.apps.googleusercontent.com"; // Replace with your actual Google Web Client ID
  final String androidClientId = "543691766095-7f24hkktrq14uc76hg5u0tq0eikog2ul.apps.googleusercontent.com";
  late GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  late final SupabaseClient _supabaseClient;
  final scopes= ['email', 'profile'];

  AuthService() {
    // Initialize Google Sign-In with your web client ID

    _googleSignIn.initialize(
      serverClientId: googleWebClientId,
      clientId: androidClientId,
    );

    // Initialize Supabase client
    _supabaseClient = SupabaseClient(baseUrl, anonKey);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/v1/token?grant_type=password');

    final response = await http.post(
      url,
      headers: {'apikey': anonKey, 'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/v1/signup');
    final response = await http.post(
      url,
      headers: {'apikey': anonKey, 'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Signup failed: ${response.body}');
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
}
