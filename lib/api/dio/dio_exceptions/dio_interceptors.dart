import 'package:dio/dio.dart';
import 'app_exceptions.dart';

class DioInterceptors extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppException exception;
    final responseData = err.response?.data;
    String message = 'Something went wrong';

    if (responseData is Map) {
      message = (responseData['error']?['message'] as String?) ??
          (responseData['errors']?['msg'] as String?) ??
          (responseData['message'] as String?) ??
          message;
    }

    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
      exception = NetworkErrorException(errorMessage: 'No internet connection');
    } else if (err.response?.statusCode != null) {
      exception = ServerErrorException(
        errorMessage: message,
        statusCode: err.response?.statusCode,
      );
    } else {
      exception = UnExpectedErrorException(errorMessage: message);
    }

    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
      ),
    );
  }
}