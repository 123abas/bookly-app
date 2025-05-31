import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection TimeOut with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send TimeOut with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('receive TimeOut with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure('badCertificate,plz try latter');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response!.statusCode,
          dioError.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Connection cancel,plz try latter ');
      case DioExceptionType.connectionError:
        return ServerFailure('ConnectionError with ApiServer,plz try latter');
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('unexpected error,plz try latter');
      default:
        return ServerFailure('oops there was an error ,try latter ');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your requist not found ');
    } else if (statusCode == 500) {
      return ServerFailure('internal server error,plz try latter ');
    } else {
      return ServerFailure('oops there was an error ,try latter ');
    }
  }
}
