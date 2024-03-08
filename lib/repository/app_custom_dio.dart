import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tarefas_getx_app/repository/app_dio_interceptor.dart';

class AppCustomDio {
  final _dio = Dio();

  // AppCustomDio();

  Dio get dio => _dio;

  AppCustomDio() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
    // _dio.options.baseUrl = "https://parseapi.back4app.com/classes";
    _dio.interceptors.add(AppDioInterceptor());
  }
}
