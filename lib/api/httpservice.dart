import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

class HttpService {
  static final HttpService _httpService = HttpService._internal();
  Dio _dio;
  final _baseURL = "http://192.168.1.9:3000/api";

  factory HttpService() {
    return _httpService;
  }


  HttpService._internal() {
    _dio = Dio(BaseOptions(baseUrl: _baseURL));
    _dio.interceptors.add(LoggingInterceptior());
  }  

  void addUserToken(String token){
    _dio.options.headers['access-token'] = token;
  }

  Future<Response> getRequest({String endpoint, Map<String,dynamic> params}) async {
    Response response;
    try {
      response = await _dio.get(_baseURL+endpoint,queryParameters: params);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  Future<Response> postRequest(
      {String endpoint,
      dynamic data
      }) async {
    Response response;

    try {      
      response = await _dio.post(_baseURL+endpoint, data: data);
      
    } catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }
}

class LoggingInterceptior extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    print("${options.method} : ${options.path}");
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    print("ERR RESPONSE :: "+ json.encode(err.response.data).toString());
    super.onError(err, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    print("RESPONSE :: ${response.data}");
    super.onResponse(response, handler);
  }
}
