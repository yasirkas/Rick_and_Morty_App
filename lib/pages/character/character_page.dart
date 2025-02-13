import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:rick_and_morty_app/pages/character/character_details.dart';
import 'package:rick_and_morty_app/statics/static_texts.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  List<CharacterModel>? _items;
  bool _isLoading = false;
  late final Dio _dio;
  final _baseUrl = 'https://rickandmortyapi.com/api';

  void changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  // characterleri getir
  Future<void> fetchGetItems() async {
    changeLoading();
    final response = await _dio.get('/character');

    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data;

      if (datas is Map<String, dynamic>) {
        final characterModel = datas['results'] as List<dynamic>;
        setState(() {
          _items =
              characterModel.map((e) => CharacterModel.fromJson(e)).toList();
        });
      }
    }
    changeLoading();
  }

  @override
  void initState() {
    super.initState();
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    fetchGetItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text("Main Page"),
        backgroundColor: Colors.blueGrey,
        actions: [
          _isLoading ? CircularProgressIndicator.adaptive() : SizedBox.shrink()
        ],
      ),
      body: ListView.builder(
        itemCount: _items?.length ?? 0,
        itemBuilder: (context, index) {
          return _CharacterCard(model: _items?[index]);
        },
      ),
    );
  }
}

class _CharacterCard extends StatelessWidget {
  const _CharacterCard({
    required CharacterModel? model,
  }) : _model = model;

  final CharacterModel? _model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_model != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CharacterDetails(character: _model),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.blueGrey,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Image.network(
                  _model?.image ?? '',
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _model?.name ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 12,
                            color: (_model?.status == 'Alive')
                                ? Colors.green
                                : (_model?.status == 'Dead')
                                    ? Colors.red
                                    : Colors.grey,
                          ),
                          Text(
                              '${_model?.status ?? ''} - ${_model?.species ?? ''}'),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                          '${StaticTexts.cardFirstSubtitle}:\n${_model?.location?.name ?? ''}'),
                      SizedBox(height: 12),
                      Text(
                          '${StaticTexts.cardSecondSubtitle}:\n${_model?.origin?.name ?? ''}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
