import 'package:dio/dio.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/utility/network/interceptor.dart';
import 'package:meeting_management/widget/multi_min_widget/todo/model/todo_model.dart';

class TodoRepository{
  Future<bool> addTodo(TodoModel todoModel) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      final response = await dio.post('/todolist/Save',data: todoModel.toJson());
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
  Future<bool> completeTodo(int id,bool done) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.queryParameters ={
        'id':id,
        'done':done,
      };
      final response = await dio.post('/todolist/complete');
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
  Future<bool> updateTodo(TodoModel todoModel) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));

      final response = await dio.post('/todolist/Save',data: todoModel.toJson());
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
  Future<bool> deleteTodo(int id) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.queryParameters = {
        'id':id
      };
      final response = await dio.post('/todolist/delete');
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
  Future<List<TodoModel>> retrieveTodo({int? id}) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      dio.options.queryParameters = {
        if(id != null)
        'id':id
      };
      final response = await dio.get('/todolist/Retrieve');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => TodoModel.fromJson(element)).toList();
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<List<TodoModel>> dailyTodo(DateTime dateTime,{String? searchText}) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.queryParameters = {
        if(searchText != null)
        'searchText':searchText,
        'date':'${dateTime.year}/${dateTime.month}/${dateTime.day}',
      };
      final response = await dio.get('/todolist/Dailly');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => TodoModel.fromJson(element)).toList();
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<List<TodoModel>> queryCountTodo(String searchText) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = '$path/api';
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.queryParameters = {
        'searchText':searchText,
      };
      final response = await dio.get('/todolist/QueryCount');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => TodoModel.fromJson(element)).toList();
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
  Future<List<TodoModel>> queryTodo(String pageNumber,String count,{String? searchText}) async {
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
      final response = await dio.get('/todolist/Query');
      if (response.statusCode == 200) {
        return (response.data as List).map((element) => TodoModel.fromJson(element)).toList();
      }
      throw Exception('statusCode ${response.statusCode} , ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }
}