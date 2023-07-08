import 'package:dio/dio.dart';
import 'package:tire_tech_mobile/core/interceptor/get_refresh_token.dart';
import 'package:tire_tech_mobile/core/local_storage/local_storage.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await LocalStorage.readLocalStorage('_token');

    options.headers['Authorization'] = 'Bearer $token';

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      String refreshToken =
          await LocalStorage.readLocalStorage('_refreshToken');
      Map<String, dynamic> userResponse =
          await GetRefreshToken.refreshToken(refreshToken: refreshToken);
      LocalStorage.storeLocalStorage('_token', userResponse['accessToken']);
      LocalStorage.storeLocalStorage(
          '_refreshToken', userResponse['refreshToken']);
    }
    super.onError(err, handler);
  }
}
