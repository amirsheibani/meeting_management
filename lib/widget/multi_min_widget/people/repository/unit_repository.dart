import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/utility/network/interceptor.dart';
import 'package:meeting_management/widget/multi_min_widget/people/model/unit_model.dart';

class UnitRepository{
  Future<UnitModel> addUnit(UnitModel unitModel) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/meeting/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      final response = await dio.post('/PartyUnit/Save',data: unitModel.toJson());
      if (response.statusCode == 200) {
        return UnitModel.fromJson(response.data);
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<bool> updateUnit(UnitModel unitModel) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/meeting/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));

      final response = await dio.post('/PartyUnit/Save',data: unitModel.toJson());
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
  Future<bool> deleteUnit(int id) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/meeting/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.queryParameters = {
        'id':id
      };
      final response = await dio.post('/PartyUnit/delete');
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

  Future<List<UnitModel>> retrieveUnit({int? id,String? searchText}) async {
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
      final response = await dio.get('/PartyUnit/Retrieve');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => UnitModel.fromJson(element)).toList();
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<List<UnitModel>> personCountUnit({int? id,String? searchText}) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        if(id != null)
          'id':id,
        if(id != null)
          'searchText':searchText
      };
      final response = await dio.get('/PartyUnit/PersonsCount');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => UnitModel.fromJson(element)).toList();
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<List<UnitModel>> personsUnit({int? id,String? searchText}) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        if(id != null)
          'id':id,
        if(id != null)
          'searchText':searchText
      };
      final response = await dio.get('/PartyUnit/Persons');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => UnitModel.fromJson(element)).toList();
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<List<UnitModel>> queryCountUnit(String searchText) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.queryParameters = {
        'searchText':searchText,
      };
      final response = await dio.get('/PartyUnit/QueryCount');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => UnitModel.fromJson(element)).toList();
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<List<UnitModel>> queryUnit(String pageNumber,String count,{String? searchText}) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.queryParameters = {
        if(searchText != null)
          'searchText':searchText,
        'pageNumber':pageNumber,
        'count':count
      };
      final response = await dio.get('/PartyUnit/Query');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => UnitModel.fromJson(element)).toList();
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
}