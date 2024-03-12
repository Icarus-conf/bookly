import 'package:dio/dio.dart';

abstract class Failure {
  final String errMsg;
  const Failure(this.errMsg);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMsg);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection time out');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send time out');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive time out');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);

      case DioExceptionType.cancel:
        return ServerFailure('Request has been canceled');

      case DioExceptionType.badCertificate:
        return ServerFailure('BadCertificate Error, please try again later!');
      case DioExceptionType.connectionError:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure('No Internet connection');
        }
      case DioExceptionType.unknown:
        return ServerFailure('Unexpected Error, please try again later!');

      default:
        return ServerFailure(
            'Opps there was an error, please try again later!');
    }

    return ServerFailure('Unexpected Error, please try again later!');
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, please try again later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server failure, please try again later!');
    } else {
      return ServerFailure('Opps there was an error, please try again later!');
    }
  }
}
