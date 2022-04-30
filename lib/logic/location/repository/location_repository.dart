import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/logic/location/model/location_model.dart';
import 'package:meeting_management/utility/network/interceptor.dart';

class LocationRepository{
  Future<bool> addLocation(LocationModel locationModel) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      final response = await dio.post('/Location/Save',data: locationModel.toJson());
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<bool> updateLocation(LocationModel locationModel) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      final response = await dio.post('/Location/Save',data: locationModel.toJson());
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<bool> deleteLocation(int id) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.queryParameters = {
        'id':id
      };
      final response = await dio.post('/Location/delete');
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<LocationModel>> retrieveLocation(int? id,{String? searchText}) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        if(id != null)
          'id':id,
        if(searchText != null)
          'searchText':searchText,
      };
      final response = await dio.get('/Location/Retrieve');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => LocationModel.fromJson(element)).toList();
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }

}