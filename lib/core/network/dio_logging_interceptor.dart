import 'dart:developer';
import 'package:dio/dio.dart';

class DioLoggingInterceptor extends Interceptor {
  static const divider = '=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=';
  static const logName = 'NETWORK';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('''
$divider
➡️ REQUEST
METHOD: ${options.method}
URI: ${options.uri}
HEADERS: ${options.headers}
QUERY: ${options.queryParameters}
BODY: ${options.data}
$divider
''', name: logName);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('''
✅ RESPONSE
STATUS CODE: ${response.statusCode}
URI: ${response.requestOptions.uri}
DATA: ${response.data}
$divider
''', name: logName);

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('''
❌ RESPONSE
STATUS CODE: ${err.response?.statusCode}
URI: ${err.requestOptions.uri}
MESSAGE: ${err.message}
DATA: ${err.response?.data}
$divider
''', name: logName);

    super.onError(err, handler);
  }
}
