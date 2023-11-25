
// in main =>>>  DioHelper.inital();

import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void inital() {
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true));
  }
  static Future<Response> getData(
      {
        String? url,
       Map<String,dynamic>? query,
        Map<String, dynamic>? data,
        String lan ="ar",
        token,
      }) async {
   if(token != null){
      dio.options.headers ={
       "Content-Type":"application/json",
       "lang":lan,
       "Authorization":token,
     };
   }

    return await dio.get(url!, queryParameters: query,data: data);
  }

  static Future<Response> postData(
      {
        String? url,
        Map<String,
        dynamic>? data,
        String lan ="ar",
        String? token,
      }) async {
    dio.options.headers= {
          "lang":lan,
          "Authorization":token,
        };

    return await dio.post(url!, data: data);
  }

  static Future<Response> putData(
      {
        String? url,
        Map<String,
            dynamic>? data,
        String lan ="ar",
        String? token,
      }) async {
    dio.options.headers= {
      "lang":lan,
      "Authorization":token,
    };

    return await dio.put(url!, data: data);
  }
}
