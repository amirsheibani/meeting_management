import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/utility/network/interceptor.dart';
import 'package:meeting_management/widget/multi_min_widget/people/model/people_model.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/model/group_type_model.dart';
import 'package:meeting_management/logic/member/model/member_model.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/model/people_group_model.dart';

class PeopleGroupRepository{
  Future<bool> addPeopleGroup(PeopleGroupModel peopleGroupModel) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      final response = await dio.post('/InviteeGroup/Save',data: peopleGroupModel.toJson());
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
  Future<bool> updatePeopleGroup(PeopleGroupModel peopleGroupModel) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));

      final response = await dio.post('/InviteeGroup/Save',data: peopleGroupModel.toJson());
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
  Future<bool> deletePeopleGroup(int id) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.queryParameters = {
        'id':id
      };
      final response = await dio.post('/InviteeGroup/delete');
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
  Future<List<PeopleGroupModel>> retrievePeopleGroup({int? id,String? searchText}) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        if(id != null)
          'id':id,
        if(id != null)
          'searchText':searchText,
      };
      final response = await dio.get('/InviteeGroup/Retrieve');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => PeopleGroupModel.fromJson(element)).toList();
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<GroupTypeModel>> retrievePeopleGroupType({int? id}) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        if(id != null)
          'applicationInternalId':id,
      };
      final response = await dio.get('/ParameterValues/QuerySubItems');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => GroupTypeModel.fromJson(element)).toList();
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }

}