import 'package:dio/dio.dart';

abstract class Failure {
  final String error;
  const Failure(this.error);
}

final class DioFailure extends Failure {
  const DioFailure._(super.error);

  factory DioFailure(DioException dioexp) {
    // print(dioexp);
    switch (dioexp.type) {
      case DioExceptionType.connectionTimeout:
        return const DioFailure._('Connection timeout');
      case DioExceptionType.sendTimeout:
        return const DioFailure._('Send timeout');
      case DioExceptionType.receiveTimeout:
        return const DioFailure._('Receive timeout');
      case DioExceptionType.badResponse:
        return DioFailure.fromResponse(
          dioexp.response?.statusCode,
          dioexp.response?.data,
        );
      case DioExceptionType.cancel:
        return const DioFailure._('Request was canceled');
      case DioExceptionType.unknown:
        if (dioexp.message == ('SocketException')) {
          return const DioFailure._('Check your internet connection');
        } else {
          return const DioFailure._('Unknown error, please try later');
        }
      default:
        return const DioFailure._(
            'Oops... Something went wrong, please try later!');
    }
  }

  factory DioFailure.fromResponse(int? code, dynamic data) {
    // print(code);
    if (code == 400 || code == 401 || code == 403) {
      return const DioFailure._('Unauthorized request');
    } else if (code == 404) {
      return const DioFailure._('Request not found');
    } else if (code == 500 || code == 502) {
      return const DioFailure._('Internal server error');
    }
    return const DioFailure._('Unexpected response error');
  }
}
