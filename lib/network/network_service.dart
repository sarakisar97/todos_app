import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../utils/app_constants.dart';

abstract class NetworkService<T>{
  Future<T> get(String url);
}

class DioNetworkService implements NetworkService<Response>{
  Dio get _dio {
    var dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveTimeout: AppConstants.dioTimeout,
      connectTimeout: AppConstants.dioTimeout,
      sendTimeout: AppConstants.dioTimeout,
    ));

    dio.interceptors.addAll({
      DioAppInterceptors(),
    });
    if(kDebugMode){
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }
    return dio;
  }

  @override
  Future<Response> get(String endpoint) => _dio.get(endpoint);
}

class DioAppInterceptors extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if(err.response?.statusCode == 500){
      log(err.response.toString());
    }
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 403:
            throw AccessForbiddenException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Bad Request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Some Thing Went Wrong, Try Againً';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict Connection';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unauthorized';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Not Found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No Internet';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Deadline Exceeded';
  }
}

class AccessForbiddenException extends DioError {
  AccessForbiddenException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access Forbidden';
  }
}