import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature_product/episode/episode_details.dart';
import 'package:rick_and_morty_app/feature_product/episode/episode_model.dart';
import 'package:rick_and_morty_app/feature_product/utility/loading_mixin.dart';

class EpisodePage extends StatefulWidget {
  const EpisodePage({super.key});

  @override
  State<EpisodePage> createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> with LoadingMixin<EpisodePage> {
  List<Episodes>? _episodes;

  late final Dio _dio;
  final _baseUrl = 'https://rickandmortyapi.com/api';


  Future<void> getEpisodes() async {
    changeLoading();
    final response = await _dio.get('/episode');

    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data;

      if (datas is Map<String, dynamic>) {
        final episodeModel = datas['results'] as List<dynamic>;
        setState(() {
          _episodes = episodeModel.map((e) => Episodes.fromJson(e)).toList();
        });
      }
    }
    changeLoading();
  }

  @override
  void initState() {
    super.initState();
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    getEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text("Episodes Page"),
        backgroundColor: Colors.blueAccent,
        actions: [
          isLoading ? CircularProgressIndicator.adaptive() : SizedBox.shrink()
        ],
      ),
      body: ListView.builder(
        itemCount: _episodes?.length ?? 0,
        itemBuilder: (context, index) {
          final episode = _episodes?[index];
          return ListTile(
            title: Text(episode?.name ?? ''),
            onTap: () {
              if (episode != null) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EpisodeDetails(episode: episode),
                ));
              }
            },
          );
        },
      ),
    );
  }
}
