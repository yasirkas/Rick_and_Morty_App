import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character_model.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  List<CharacterModel>? _items;
  bool _isLoading = false;

  void changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchGetItems() async {
    changeLoading();
    final response =
        await Dio().get('https://rickandmortyapi.com/api/character');

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
    return Padding(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                        'Last known location:\n${_model?.location?.name ?? ''}'),
                    SizedBox(height: 12),
                    Text('First seen in:\n${_model?.origin?.name ?? ''}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
