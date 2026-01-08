import 'package:dio/dio.dart';
import 'auth_service.dart';
import 'token_storage.dart';

class ApiClient {
  final Dio dio;
  final AuthService authService;
  final TokenStorage storage;
  final void Function()? onLogout;

  bool _isRefreshing = false;

  ApiClient({
    required String baseUrl,
    required this.authService,
    required this.storage,
    this.onLogout,
  }) : dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           headers: {'Content-Type': 'application/json'},
         ),
       ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.getAccessToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },

        onError: (error, handler) async {
          final status = error.response?.statusCode;
          if (status == 401) {

            if (_isRefreshing) {
              while (_isRefreshing) {
                await Future.delayed(const Duration(milliseconds: 100));
              }
              final token = await storage.getAccessToken();
              if (token != null && token.isNotEmpty) {
                error.requestOptions.headers['Authorization'] = 'Bearer $token';
              }
              try {
                final opts = Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers,
                );
                final retryResp = await dio.request(
                  error.requestOptions.path,
                  options: opts,
                  data: error.requestOptions.data,
                  queryParameters: error.requestOptions.queryParameters,
                );
                return handler.resolve(retryResp);
              } catch (_) {
                return handler.next(error);
              }
            }

            _isRefreshing = true;
            try {
              final newAuth = await authService.refresh();

              // salva SEMPRE l'access token
              final newToken = newAuth.accessToken;
              if (newToken.isNotEmpty) {
                await storage.saveAccessToken(newToken);
                dio.options.headers['Authorization'] = 'Bearer $newToken';
                error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
              }

              // salva il refresh token SOLO se non è vuoto
              if (newAuth.refreshToken.isNotEmpty) {
                await storage.saveRefreshToken(newAuth.refreshToken);
              }

              final opts = Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
              );

              final retryResp = await dio.request(
                error.requestOptions.path,
                options: opts,
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );

              return handler.resolve(retryResp);
            } catch (e) {
              _isRefreshing = false;

              // logout SOLO se il refresh token è davvero invalido
              if (error.requestOptions.path.contains('/auth/refresh')) {
                await storage.clear();
                onLogout?.call();
              }

              return handler.next(error);
            } finally {
              _isRefreshing = false;
            }
          }

          return handler.next(error);
        },
      ),
    );
  }
}
