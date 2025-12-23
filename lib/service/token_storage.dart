import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _kAccess = 'access_token';
  static const _kRefresh = 'refresh_token';

  Future<void> saveAccessToken(String token) => _storage.write(key: _kAccess, value: token);
  Future<void> saveRefreshToken(String token) => _storage.write(key: _kRefresh, value: token);
  Future<String?> getAccessToken() => _storage.read(key: _kAccess);
  Future<String?> getRefreshToken() => _storage.read(key: _kRefresh);
  Future<void> clear() => _storage.deleteAll();

  int? _getExpFromJwt(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      final payload = parts[1];
      String normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final map = jsonDecode(decoded) as Map<String, dynamic>;
      final exp = map['exp'];
      if (exp is int) return exp;
      if (exp is String) return int.tryParse(exp);
    } catch (_) {}
    return null;
  }

  Future<bool> isAccessTokenValid({int marginSeconds = 30}) async {
    final token = await getAccessToken();
    if (token == null || token.isEmpty) return false;
    final exp = _getExpFromJwt(token);
    if (exp == null) return true;
    final nowSec = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    return exp > (nowSec + marginSeconds);
  }
}
