class AuthResponse {
  final String accessToken;
  final String refreshToken;

  AuthResponse({required this.accessToken, required this.refreshToken});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    //serve a cercare parole diverse da access_token
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
      //serve a cercare parole diverse da refresh_token
      return (m['refreshToken'] ??
          m['refresh_token'] ??
          m['refresh'] ??
          m['refreshTokenValue'] ??
          '')
          .toString();
    }

    return AuthResponse(
      accessToken: extractAccess(json),
      refreshToken: extractRefresh(json),
    );
  }
}
