import 'package:jwt_decode/jwt_decode.dart';

class AuthResponse {
  final String accessToken;
  final String refreshToken;

  // dati utente estratti dal JWT
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    // 🔹 estrazione token
    String extractAccess(Map<String, dynamic> m) {
      return (m['accessToken'] ??
          m['access_token'] ??
          m['token'] ??
          m['jwt'] ??
          m['access'] ??
          '')
          .toString();
    }

    String extractRefresh(Map<String, dynamic> m) {
      return (m['refreshToken'] ??
          m['refresh_token'] ??
          m['refresh'] ??
          m['refreshTokenValue'] ??
          '')
          .toString();
    }

    final accessToken = extractAccess(json);
    final refreshToken = extractRefresh(json);

    // 🔹 decode JWT solo se esiste
    final Map<String, dynamic> payload =
    accessToken.isNotEmpty ? Jwt.parseJwt(accessToken) : {};

    return AuthResponse(
      accessToken: accessToken,
      refreshToken: refreshToken,
      username: payload['preferred_username'] as String?,
      firstName: payload['given_name'] as String?,
      lastName: payload['family_name'] as String?,
      email: payload['email'] as String?,
    );
  }
}
