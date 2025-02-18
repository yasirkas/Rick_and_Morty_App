import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature_product/character/character_model.dart';
import 'package:rick_and_morty_app/feature_product/character/character_details.dart';
import 'package:rick_and_morty_app/feature_product/contains/static_colors.dart';
import 'package:rick_and_morty_app/feature_product/service/service.dart';
import 'package:rick_and_morty_app/feature_product/contains/static_texts.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  List<CharacterModel>? _characters;
  final Service _service = Service();

  @override
  void initState() {
    super.initState();
    _getCharacters();
  }

  Future<void> _getCharacters() async {
    _characters = await _service.getCharacters();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(StaticTexts().charactersPageTitle),
        backgroundColor: StaticColors().characterPageBGColor,
        foregroundColor: StaticColors().characterPageFGColor,
      ),
      body: _characters == null
          ? Center(child: Image.asset('assets/gif/portal_loading.gif'))
          : ListView.builder(
              itemCount: _characters?.length ?? 0,
              itemBuilder: (context, index) {
                final character = _characters?[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(character?.image ?? ''),
                    ),
                    title: Text(
                      character?.name ?? '',
                      style: TextStyle(
                        color: StaticColors().characterNameColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 12,
                          color: (character?.status == 'Alive')
                              ? StaticColors().characterAliveColor
                              : (character?.status == 'Dead')
                                  ? StaticColors().characterDeadColor
                                  : StaticColors().characterUnknownColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${character?.status} - ${character?.species}',
                          style: TextStyle(
                              color: StaticColors().characterSubtitleColor),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              CharacterDetails(character: character!),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
