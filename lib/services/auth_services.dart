import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl =
      "https://ynrlazotnpftjyziovky.supabase.co"; // your Supabase project URL
  final String anonKey =
      "sb_publishable_m4emukdfkUxoFHBhi36yPg__1DYqmWb"; // replace with your real anon key

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
}
