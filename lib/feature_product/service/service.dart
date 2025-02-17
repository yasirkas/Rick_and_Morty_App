import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/feature_product/character/character_model.dart';
import 'package:rick_and_morty_app/feature_product/episode/episode_model.dart';
import 'package:rick_and_morty_app/feature_product/location/location_model.dart';

class Service {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'));

  // Character Model Api Service
  Future<List<CharacterModel>?> getCharacters() async {
    try {
      final response = await _dio.get('/character');

      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;

        if (datas is Map<String, dynamic>) {
          final characterModel = datas['results'] as List<dynamic>;
          return characterModel.map((e) => CharacterModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      throw Exception("An error occurred while retrieving character data: $e");
    }
    return null;
  }

  // Location Model Api Service

  Future<List<Locations>?> getLocations() async {
    try {
      final response = await _dio.get('/location');

      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;

        if (datas is Map<String, dynamic>) {
          final locationModel = datas['results'] as List<dynamic>;
          return locationModel.map((e) => Locations.fromJson(e)).toList();
        }
      }
    } catch (e) {
      throw Exception("An error occurred while retrieving location data: $e");
    }
    return null;
  }

  // Episode Model Api Service

  Future<List<Episodes>?> getEpisodes() async {
    try {
      final response = await _dio.get('/episode');

      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;

        if (datas is Map<String, dynamic>) {
          final episodeModel = datas['results'] as List<dynamic>;

          return episodeModel.map((e) => Episodes.fromJson(e)).toList();
        }
      }
    } catch (e) {
      throw Exception("An error occurred while retrieving episode data: $e");
    }
    return null;
  }

  // Service for Character URLs in Episode or Location
  Future<CharacterModel?> getCharacter(String url) async {
    try {
      final response = await _dio.get(url);

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return CharacterModel.fromJson(data);
        }
      }
    } catch (e) {
      throw Exception("An error occurred while retrieving episode data: $e");
    }
    return null;
  }
}
