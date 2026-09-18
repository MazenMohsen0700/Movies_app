
import 'package:dio/dio.dart';

abstract class DataSource {
  Future<Response> getMovies( String genre );
}