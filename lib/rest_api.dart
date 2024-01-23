library rest_api;

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

/// Rest API Client
abstract class RestApi {
  final Dio _client = Dio();
  final String baseUrl;
  final bool setAcceptHeaderJson;
  // String baseUrl = Constants.baseUrlTest;
  String token = "";

  RestApi({
    required this.baseUrl,
    this.setAcceptHeaderJson = true,
  }) {
    _setBaseUrl();
    if (setAcceptHeaderJson) {
      setAcceptHeader('application/json');
    }
  }

  void _setBaseUrl() {
    _client.options.baseUrl = baseUrl;
  }

  void setToken(String token);

  void addHeader() {}

  void setAcceptHeader(String headerString) {
    _client.options.headers
        .putIfAbsent(HttpHeaders.acceptHeader, () => headerString);
  }

  void setDioToken() {
    _client.options.headers["Authorization"] = token;
  }

  /// Rest API post method
  Future<T> post<T extends Object>(
    String endPoint, {
    dynamic body,
  }) async {
    setDioToken();
    try {
      var resp = await _client.post(endPoint,
          data: body != null ? body.toJson() : "",
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      print(resp.data);
      return getModel<T>(resp.data);
    } catch (e) {
      print(e.toString());
      return getGeneralError<T>();
    }
  }

  /// Rest API get method
  Future<T> get<T extends Object>(
    String endPoint, {
    dynamic body,
  }) async {
    setDioToken();
    try {
      var resp = await _client.get(endPoint,
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      return getModel<T>(resp.data);
    } catch (e) {
      return getGeneralError<T>();
    }
  }

  /// Rest API put method
  Future<T> put<T extends Object>(
    String endPoint, {
    dynamic body,
  }) async {
    setDioToken();
    try {
      var resp = await _client.put(endPoint,
          data: body != null ? body.toJson() : "",
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      return getModel<T>(resp.data);
    } catch (e) {
      return getGeneralError<T>();
    }
  }

  /// Rest API delete method
  Future<T> delete<T extends Object>(
    String endPoint, {
    dynamic body,
  }) async {
    setDioToken();
    try {
      var resp = await _client.delete(endPoint,
          data: body != null ? body.toJson() : "",
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      return getModel<T>(resp.data);
    } catch (e) {
      return getGeneralError<T>();
    }
  }

  /// Method returns object of [T] class
  /// To use specific [T] class you must register constructor of
  /// this class at start of your program in [GetIt]
  T getModel<T extends Object>(Map<String, dynamic> json) {
    return GetIt.I.get<T>(param1: json);
  }

  /// Method return default error json string
  /// You must [override] this method to use it
  Map<String, String> defaultErrorJson();

  /// Method return model of [T] class with default error json from [defaultErrorJson] method
  T getGeneralError<T extends Object>() {
    return GetIt.I.get<T>(param1: defaultErrorJson());
  }

  /// Print method for long texts
  /// This method works like [print] method
  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
