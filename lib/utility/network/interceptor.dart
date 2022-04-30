import 'package:behpardaz_flutter_custom_utility/tools/utility/local_storage.dart';
import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/screen/authenticate/model/authenticate_data.dart';


const _connectTimeout = 3000;
const _receiveTimeout = 3000;
const _sendTimeout = 3000;

class AppInterceptors extends Interceptor {
  final Dio _dio;

  AppInterceptors(this._dio);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = await LocalStorage.instance.readString('accessToken');
    options.connectTimeout = _connectTimeout;
    options.receiveTimeout = _receiveTimeout;
    options.sendTimeout = _sendTimeout;
    options.headers['Authorization'] = 'Bearer ${accessToken['accessToken']}';
    options.validateStatus = (status){
      return status! < 500;
    };
    handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    debugPrint('dio Interceptors onError: ${err.message}');
    if (err.response?.statusCode == 401) {
      try {
        if (develop) {
          final dio = Dio();
          dio.options.baseUrl = '$path/Auth';
          dio.options.headers['Content-Type'] = 'application/json; charset=utf-8';
          dio.options.validateStatus = (status) {
            return status! < 500;
          };
          var refToken = await LocalStorage.instance.readString('refreshtoken');
          Map<String, dynamic> data = {"refreshtoken": refToken};
          final response = await dio.post('/refresh', data: data);
          debugPrint('dio Interceptors refresh token: ${response.statusCode}');
          if (response.statusCode == 201 || response.statusCode == 200) {
            AuthenticateData result = AuthenticateData.fromJson(response.data);
            refreshToken(result);
            var accessToken = await LocalStorage.instance.readString('accessToken');
            err.requestOptions.headers["Authorization"] = 'Bearer ${accessToken['accessToken']}';
            final opts = Options(method: err.requestOptions.method, headers: err.requestOptions.headers);
            final cloneReq = await _dio.request(err.requestOptions.path, options: opts, data: err.requestOptions.data, queryParameters: err.requestOptions.queryParameters);
            return handler.resolve(cloneReq);
          } else {
            return handler.reject(err);
          }
        }else{
          final dio = Dio();
          dio.options.baseUrl = '$path/Auth';
          dio.options.headers['Content-Type'] = 'application/json; charset=utf-8';
          dio.options.validateStatus = (status) {
            return status! < 500;
          };
          var refToken = await LocalStorage.instance.readString('refreshtoken');
          Map<String, dynamic> data = {"refreshtoken": refToken};
          final response = await dio.post('/refresh', data: data);
          if (response.statusCode == 201 || response.statusCode == 200) {
            AuthenticateData result = AuthenticateData.fromJson(response.data);
            refreshToken(result);
            var accessToken = await LocalStorage.instance.readString('accessToken');
            err.requestOptions.headers["Authorization"] = 'Bearer ${accessToken['accessToken']}';
            final opts = Options(method: err.requestOptions.method, headers: err.requestOptions.headers);
            final cloneReq = await _dio.request(err.requestOptions.path, options: opts, data: err.requestOptions.data, queryParameters: err.requestOptions.queryParameters);
            return handler.resolve(cloneReq);
          } else {
            handler.reject(err);
          }
        }
      } catch (e) {
        handler.reject(err);
      }
    }
    else{
      handler.next(err);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

}
