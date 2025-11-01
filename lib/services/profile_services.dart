import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Create or update user profile
  Future<Map<String, dynamic>> createProfile({
    required String userId,
    required String username,
    required String fullName,
    required int age,
    // required String gender,
    required int height,
    required int weight,
    required String role,
    required String level,
    String? ppUrl,
    String? domisili,
    List<dynamic>? interests,
    Map<String, dynamic>? roleData,
  }) async {
    try {
      final response = await _supabase
          .from('profile')
          .insert({
            'id': userId,
            'username': username,
            'full_name': fullName,
            'age': age,
            // 'gender': gender,
            'height': height,
            'weight': weight,
            'role': roleData ?? {'primary_role': role},
            'level': level,
            'pp_url': ppUrl,
            'domisili': domisili,
            'interests': interests ?? [],
            'created_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      return {'data': response, 'error': null};
    } catch (e) {
      return {'data': null, 'error': e.toString()};
    }
  }

  // Get user profile
  Future<Map<String, dynamic>> getProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profile')
          .select()
          .eq('id', userId)
          .single();

      return {'data': response, 'error': null};
    } catch (e) {
      return {'data': null, 'error': e.toString()};
    }
  }

  // Update profile
  Future<Map<String, dynamic>> updateProfile({
    required String userId,
    String? username,
    String? fullName,
    int? age,
    // String? gender,
    int? height,
    int? weight,
    String? role,
    String? level,
    String? ppUrl,
    String? domisili,
    List<dynamic>? interests,
    Map<String, dynamic>? roleData,
  }) async {
    try {
      final updates = <String, dynamic>{};
      
      if (username != null) updates['username'] = username;
      if (fullName != null) updates['full_name'] = fullName;
      if (age != null) updates['age'] = age;
      // if (gender != null) updates['gender'] = gender;
      if (height != null) updates['height'] = height;
      if (weight != null) updates['weight'] = weight;
      if (role != null) updates['role'] = roleData ?? {'primary_role': role};
      if (level != null) updates['level'] = level;
      if (ppUrl != null) updates['pp_url'] = ppUrl;
      if (domisili != null) updates['domisili'] = domisili;
      if (interests != null) updates['interests'] = interests;

      final response = await _supabase
          .from('profile')
          .update(updates)
          .eq('id', userId)
          .select()
          .single();

      return {'data': response, 'error': null};
    } catch (e) {
      return {'data': null, 'error': e.toString()};
    }
  }

  // Check if username is available
  Future<bool> isUsernameAvailable(String username) async {
    try {
      final response = await _supabase
          .from('profile')
          .select('username')
          .eq('username', username)
          .maybeSingle();

      return response == null;
    } catch (e) {
      return false;
    }
  }

  // Calculate age from birth date
  int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || 
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}