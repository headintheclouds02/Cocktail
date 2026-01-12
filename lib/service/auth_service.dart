import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/auth_response.dart';
import '../model/register_request.dart';
import 'token_storage.dart';

class AuthService {
  final String baseUrl;
  final TokenStorage storage;

  AuthService({required this.baseUrl, required this.storage});

  Future<AuthResponse> login(String username, String password) async {
    final uri = Uri.parse('$baseUrl/api/auth/login');
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      final auth = AuthResponse.fromJson(body);
      await storage.saveAccessToken(auth.accessToken);
      await storage.saveRefreshToken(auth.refreshToken);
      return auth;
    } else {
      throw Exception('Login failed: ${res.statusCode} ${res.body}');
    }
  }

  Future<void> register(RegisterRequest request) async {
    final uri = Uri.parse('$baseUrl/api/auth/register');
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request),
    );

    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception('Registration failed: ${res.statusCode} ${res.body}');
    }
  }

  Future<AuthResponse> refresh() async {
    final uri = Uri.parse('$baseUrl/api/auth/refresh');
    final refreshToken = await storage.getRefreshToken();
    if (refreshToken == null) throw Exception('No refresh token');

    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      final auth = AuthResponse.fromJson(body);
      await storage.saveAccessToken(auth.accessToken);

      if (auth.refreshToken.isNotEmpty) {
        await storage.saveRefreshToken(auth.refreshToken);
      }

      return auth;
    } else {
      throw Exception('Refresh failed: ${res.statusCode} ${res.body}');
    }
  }
}
