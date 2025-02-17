import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature_product/character/character_model.dart';
import 'package:rick_and_morty_app/feature_product/character/character_details.dart';
import 'package:rick_and_morty_app/feature_product/service/service.dart';
import 'package:rick_and_morty_app/feature_product/utility/loading_mixin.dart';
import 'package:rick_and_morty_app/feature_product/utility/static_texts.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage>
    with LoadingMixin<CharacterPage> {
  List<CharacterModel>? _characters;
  final Service _service = Service();

  @override
  void initState() {
    super.initState();
    _getCharacters();
  }

  Future<void> _getCharacters() async {
    changeLoading();
    _characters = await _service.getCharacters();
    changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text("Characters Page"),
        backgroundColor: Colors.blueAccent,
        actions: [
          isLoading ? CircularProgressIndicator.adaptive() : SizedBox.shrink()
        ],
      ),
      body: ListView.builder(
        itemCount: _characters?.length ?? 0,
        itemBuilder: (context, index) {
          return _CharacterCard(model: _characters?[index]);
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
