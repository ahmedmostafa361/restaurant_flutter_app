import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/app_exceptions.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/dio_interceptors.dart';

// Captures whatever DioException gets passed to handler.next(...)
// so we can assert on the rebuilt exception's .error field.
class _CapturingErrorInterceptorHandler extends ErrorInterceptorHandler {
  DioException? captured;

  @override
  void next(DioException err) {
    captured = err;
  }
}

void main() {
  late DioInterceptors interceptor;

  setUp(() {
    interceptor = DioInterceptors();
  });

  DioException buildDioException({
    required DioExceptionType type,
    int? statusCode,
    dynamic responseData,
  }) {
    return DioException(
      requestOptions: RequestOptions(path: '/test'),
      type: type,
      response: statusCode != null
          ? Response(
              requestOptions: RequestOptions(path: '/test'),
              statusCode: statusCode,
              data: responseData,
            )
          : null,
    );
  }

  group('DioInterceptors — connection errors', () {
    test(
      'connectionError produces NetworkErrorException with a fixed message',
      () {
        final err = buildDioException(type: DioExceptionType.connectionError);
        final handler = _CapturingErrorInterceptorHandler();

        interceptor.onError(err, handler);

        expect(handler.captured?.error, isA<NetworkErrorException>());
        expect(
          (handler.captured?.error as NetworkErrorException).errorMessage,
          'No internet connection',
        );
      },
    );

    test('connectionTimeout also produces NetworkErrorException', () {
      final err = buildDioException(type: DioExceptionType.connectionTimeout);
      final handler = _CapturingErrorInterceptorHandler();

      interceptor.onError(err, handler);

      expect(handler.captured?.error, isA<NetworkErrorException>());
    });
  });

  group('DioInterceptors — server errors with a status code', () {
    test('extracts message from error.message shape', () {
      final err = buildDioException(
        type: DioExceptionType.badResponse,
        statusCode: 400,
        responseData: {
          'error': {'message': 'Invalid request'},
        },
      );
      final handler = _CapturingErrorInterceptorHandler();

      interceptor.onError(err, handler);

      final exception = handler.captured?.error as ServerErrorException;
      expect(exception.errorMessage, 'Invalid request');
      expect(exception.statusCode, 400);
    });

    test('extracts message from errors.msg shape', () {
      final err = buildDioException(
        type: DioExceptionType.badResponse,
        statusCode: 422,
        responseData: {
          'errors': {'msg': 'Validation failed'},
        },
      );
      final handler = _CapturingErrorInterceptorHandler();

      interceptor.onError(err, handler);

      final exception = handler.captured?.error as ServerErrorException;
      expect(exception.errorMessage, 'Validation failed');
      expect(exception.statusCode, 422);
    });

    test('extracts message from top-level message shape', () {
      final err = buildDioException(
        type: DioExceptionType.badResponse,
        statusCode: 500,
        responseData: {'message': 'Internal server error'},
      );
      final handler = _CapturingErrorInterceptorHandler();

      interceptor.onError(err, handler);

      final exception = handler.captured?.error as ServerErrorException;
      expect(exception.errorMessage, 'Internal server error');
      expect(exception.statusCode, 500);
    });

    test(
      'falls back to default message when response data has no known message field',
      () {
        final err = buildDioException(
          type: DioExceptionType.badResponse,
          statusCode: 503,
          responseData: {'unrelated_field': 'nothing useful'},
        );
        final handler = _CapturingErrorInterceptorHandler();

        interceptor.onError(err, handler);

        final exception = handler.captured?.error as ServerErrorException;
        expect(exception.errorMessage, 'Something went wrong');
      },
    );

    test(
      'falls back to default message when response data is not a Map (e.g. a String or null)',
      () {
        final err = buildDioException(
          type: DioExceptionType.badResponse,
          statusCode: 500,
          responseData: null,
        );
        final handler = _CapturingErrorInterceptorHandler();

        interceptor.onError(err, handler);

        final exception = handler.captured?.error as ServerErrorException;
        expect(exception.errorMessage, 'Something went wrong');
      },
    );
  });

  group('DioInterceptors — unexpected errors', () {
    test(
      'produces UnExpectedErrorException when there is no status code and not a connection error',
      () {
        final err = buildDioException(
          type: DioExceptionType.unknown,
        ); // no statusCode passed
        final handler = _CapturingErrorInterceptorHandler();

        interceptor.onError(err, handler);

        expect(handler.captured?.error, isA<UnExpectedErrorException>());
      },
    );
  });
}
