
import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:dio/dio.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/utility/network/interceptor.dart';

class PersonApiRepository {
  Future<Person> personInfo() async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      final response = await dio.get('/person/getinfo');
      if (response.statusCode == 200) {
        return Person.fromJson(response.data);
      }
      throw Exception('code: ${response.statusCode} ${response.data}');
    } on DioError catch (e) {
      throw Exception('${e.message} \n${e.stackTrace.toString()}');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> personInfoUpdate(Person person) async {
    try {
      final dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(AppInterceptors(dio));
      dio.options.baseUrl = '$path/api';
      final response = await dio.post('/Person/update', data: person.toJsonForUpdate());
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



}
