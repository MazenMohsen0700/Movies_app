import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiService {
   Dio dio = Dio(
    BaseOptions(baseUrl: "https://movies-api.accel.li/api/v2/")
  );
}