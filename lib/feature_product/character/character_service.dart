import 'package:dio/dio.dart';

class CharacterService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'));
}
