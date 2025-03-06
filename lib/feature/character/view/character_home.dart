import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/model/character_model.dart';
import 'package:rick_and_morty_app/feature/character/view/character_details.dart';
import 'package:rick_and_morty_app/product/costants/static_colors.dart';
import 'package:rick_and_morty_app/product/service/service.dart';
import 'package:rick_and_morty_app/product/costants/static_font_style.dart';
import 'package:rick_and_morty_app/product/costants/static_margins.dart';
import 'package:rick_and_morty_app/product/costants/static_paths.dart';
import 'package:rick_and_morty_app/product/costants/static_texts.dart';

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
        title: Text(StaticTexts.charactersPageTitle),
        backgroundColor: StaticColors.characterPageBGColor,
        foregroundColor: StaticColors.characterPageFGColor,
      ),
      body: _characters == null
          ? Center(child: Image.asset(StaticPaths.loadingBarPath))
          : ListView.builder(
              itemCount:
                  _characters?.length ?? StaticFontStyle.errorLength,
              itemBuilder: (context, index) {
                final character = _characters?[index];
                return Card(
                  margin: StaticMargins.characterPageMargin,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(character?.image ?? StaticTexts.noDataError),
                    ),
                    title: Text(
                      character?.name ?? StaticTexts.noDataError,
                      style: TextStyle(
                        color: StaticColors.characterNameColor,
                        fontSize: StaticFontStyle.characterPageTitleFontSize,
                        fontWeight:
                            StaticFontStyle.characterPageTitleFontWeight,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: StaticFontStyle.characterPageCircleIconSize,
                          color: (character?.status == StaticTexts.alive)
                              ? StaticColors.characterAliveColor
                              : (character?.status == StaticTexts.dead)
                                  ? StaticColors.characterDeadColor
                                  : StaticColors.characterUnknownColor,
                        ),
                        SizedBox(
                            width: StaticFontStyle.characterPageSizedBoxSize),
                        Text(
                          '${character?.status} - ${character?.species}',
                          style: TextStyle(
                              color: StaticColors.characterSubtitleColor),
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
