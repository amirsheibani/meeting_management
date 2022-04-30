import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/utility/network/interceptor.dart';
import 'package:meeting_management/logic/asset/model/asset_model.dart';
import 'package:meeting_management/widget/multi_min_widget/people/model/people_model.dart';

class AssetsRepository{
  Future<bool> addAsset(AssetModel assetModel) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      final response = await dio.post('/Asset/Save',data: assetModel.toJson());
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
  Future<bool> updateAsset(AssetModel assetModel) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));

      final response = await dio.post('/Asset/Save',data: assetModel.toJson());
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
  Future<bool> deleteAsset(int id) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.queryParameters = {
        'id':id
      };
      final response = await dio.post('/Asset/delete');
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

  Future<List<AssetModel>> retrieveAsset({int? id,String? searchText}) async {
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
      final response = await dio.get('/Asset/Retrieve');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => AssetModel.fromJson(element)).toList();
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<List<int>> retrieveAssetsMeeting(int id) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters ={
        'id': id,
        'lang':LanguageState.language == Language.en ? 'en':'fa',
      };
      final response = await dio.get('/Meeting/Assets');
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => (e as int)).toList();
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
}