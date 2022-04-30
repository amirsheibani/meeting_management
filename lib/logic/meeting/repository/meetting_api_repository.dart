import 'dart:convert';

import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/logic/meeting/model/Invitees_model.dart';
import 'package:meeting_management/logic/meeting/model/meeting_history.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/logic/meeting/model/online_meeting_software.dart';
import 'package:meeting_management/utility/network/interceptor.dart';

class MeetingApiRepository{
  Future<bool> add(MeetingModel meetingModel) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      // debugPrint('${json.encode(meetingModel.toJsonForAdd())}');
      final response = await dio.post('/Meeting/Save',data: meetingModel.toJsonForAdd());
      // debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<bool> update(MeetingModel meetingModel) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      final response = await dio.post('/Meeting/Save',data: meetingModel.toJson());
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<bool> delete(int id) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        'id':id
      };
      final response = await dio.post('/Meeting/Delete');
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<bool> cancel(int id) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        'id':id
      };
      final response = await dio.post('/Meeting/Cancel');
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<bool> resume(int id) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        'id':id
      };
      final response = await dio.post('/Meeting/Resume');
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<bool> start(int id) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        'id':id
      };
      final response = await dio.post('/Meeting/Start');
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<bool> complete(int id) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        'id':id
      };
      final response = await dio.post('/Meeting/Complete');
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<List<MeetingModel>> retrieve() async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      final response = await dio.get('/Meeting/Retrieve');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => MeetingModel.fromJson(element)).toList();
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<List<MeetingModel>> retrieveDaily(DateTime from,{DateTime? to,dynamic searchText}) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        'fromDate':DateFormat('yyyy/MM/dd').format(from),
        if(to != null)
        'toDate':DateFormat('yyyy/MM/dd').format(to),
        if(searchText != null)
          'searchText':searchText as String
      };
      final response = await dio.get('/Meeting/Dailly');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => MeetingModel.fromJson(element)).toList();
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<List<MeetingModel>> retrievePending(DateTime from,DateTime to,{dynamic searchText}) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      String fromDate = DateFormat('yyyy/MM/dd').format(from);
      String toDate = DateFormat('yyyy/MM/dd').format(to);
      dio.options.queryParameters = {
        'fromDate':fromDate,
        'toDate':toDate,
        if(searchText != null)
          'searchText':searchText as String
      };
      final response = await dio.get('/Meeting/Pending');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => MeetingModel.fromJson(element)).toList();
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<List<MeetingModel>> retrieveReject(DateTime from,DateTime to,{dynamic searchText}) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      String fromDate = DateFormat('yyyy/MM/dd').format(from);
      String toDate = DateFormat('yyyy/MM/dd').format(to);
      dio.options.queryParameters = {
        'fromDate':fromDate,
        'toDate':toDate,
        if(searchText != null)
          'searchText':searchText as String
      };
      final response = await dio.get('/Meeting/Reject');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => MeetingModel.fromJson(element)).toList();
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<InviteesModel>> invitees(int id) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters ={
        'id': id,
        'lang':LanguageState.language == Language.en ? 'en':'fa',
      };
      final response = await dio.get('/Meeting/Invitees');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => InviteesModel.fromJson(element)).toList();
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }


  Future<List<MeetingModel>> pending({DateTime? from, DateTime? to}) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        if(from != null)
          'fromDate':DateFormat('yyyy/MM/dd').format(from),
        if(to != null)
          'toDate':DateFormat('yyyy/MM/dd').format(to),
      };
      final response = await dio.get('/Meeting/Pending');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => MeetingModel.fromJson(element)).toList();
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OnlineMeetingSoftware>> getOnlineMeetingSoftwareList() async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        'id':43
      };
      final response = await dio.post('/ParameterValues/QuerySubItems');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => OnlineMeetingSoftware.fromJson(element)).toList();
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<List<MeetingHistory>> getChangeHistoryList(int id) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        'id':id
      };
      final response = await dio.post('/Meeting/ChangeHistory');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => MeetingHistory.fromJson(element)).toList();
      }
      throw Exception(response.data);
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }

}
