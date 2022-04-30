import 'package:behpardaz_flutter_custom_utility/tools/tools.dart';
import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/screen/authenticate/model/authenticate_data.dart';
import 'package:meeting_management/utility/network/interceptor.dart';

const _connectTimeout = 3000;
const _receiveTimeout = 3000;
const _sendTimeout = 3000;

class AuthenticateApiRepository {
  Future<AuthenticateData> _login(String? username, String? password,String? fcmToken) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/Auth';
      dio.options.headers['Content-Type'] = 'application/json; charset=utf-8';
      dio.options.connectTimeout = _connectTimeout;
      dio.options.receiveTimeout = _receiveTimeout;
      dio.options.sendTimeout = _sendTimeout;
      dio.options.validateStatus = (status) {
        return status! < 500;
      };

      PlatformType platformType = PlatformInfo().getCurrentPlatformType();
      String _platformType;
      switch(platformType){
        case PlatformType.Web:
          _platformType = 'web';
          break;
        case PlatformType.iOS:
          _platformType = 'ios';
          break;
        case PlatformType.Android:
          _platformType = 'android';
          break;
        case PlatformType.MacOS:
          _platformType = 'macos';
          break;
        case PlatformType.Fuchsia:
          _platformType = 'fuchsia';
          break;
        case PlatformType.Linux:
          _platformType = 'linux';
          break;
        case PlatformType.Windows:
          _platformType = 'windows';
          break;
        case PlatformType.Unknown:
          _platformType = 'unknown';
          break;
      }
      Map<String, dynamic> data = {"username": username ?? 'info@patanjameh2.com', "password": password ?? 'Admin123',"fcmtoken":fcmToken ?? 'test',"FCMPaltform" : _platformType};

      debugPrint('data auth : $data');
      final response = await dio.post('/Login', data: data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        AuthenticateData result = AuthenticateData.fromJson(response.data);
        refreshToken(result);
        return result;
      } else {
        throw Exception([response.data, response.statusCode]);
      }
    } on DioError catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthenticateData> _loginOAM(String? fcmToken) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/Auth';
      dio.options.headers['Content-Type'] = 'application/json; charset=utf-8';
      dio.options.connectTimeout = _connectTimeout;
      dio.options.receiveTimeout = _receiveTimeout;
      dio.options.sendTimeout = _sendTimeout;
      dio.options.validateStatus = (status) {
        return status! < 500;
      };

      PlatformType platformType = PlatformInfo().getCurrentPlatformType();
      String _platformType;
      switch(platformType){
        case PlatformType.Web:
          _platformType = 'web';
          break;
        case PlatformType.iOS:
          _platformType = 'ios';
          break;
        case PlatformType.Android:
          _platformType = 'android';
          break;
        case PlatformType.MacOS:
          _platformType = 'macos';
          break;
        case PlatformType.Fuchsia:
          _platformType = 'fuchsia';
          break;
        case PlatformType.Linux:
          _platformType = 'linux';
          break;
        case PlatformType.Windows:
          _platformType = 'windows';
          break;
        case PlatformType.Unknown:
          _platformType = 'unknown';
          break;
      }
      //TODO oam fcm toke ????

      final response = await dio.post('/OAMLogin');

      if (response.statusCode == 201 || response.statusCode == 200) {
        AuthenticateData result = AuthenticateData.fromJson(response.data);
        refreshToken(result);
        return result;
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthenticateData> login({String? username, String? password,String? fcmToken}) async {
    try{
      if (develop) {
        return _login(username, password,fcmToken);
      } else {
        return _loginOAM(fcmToken);
      }
    }catch (e){
      rethrow;
    }
  }

  Future<bool> logOff() async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/Auth';

      final response = await dio.post('/dashboardlogoff');
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }
      throw Exception([response.statusCode, response.data]);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
}
