import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/character_view/character_details.dart';
import 'package:rick_and_morty_app/feature/character/character_model/character_model.dart';
import 'package:rick_and_morty_app/feature/episode/episode_widgets/episode_page_info_card.dart';
import 'package:rick_and_morty_app/feature/episode/episode_widgets/episode_page_loading_card.dart';
import 'package:rick_and_morty_app/feature/episode/episode_widgets/episode_page_no_characters_card.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/feature/episode/episode_model/episode_model.dart';
import 'package:rick_and_morty_app/feature/service/service.dart';
import 'package:rick_and_morty_app/product/contains/static_font_style.dart';
import 'package:rick_and_morty_app/product/contains/static_margins.dart';
import 'package:rick_and_morty_app/product/contains/static_paddings.dart';
import 'package:rick_and_morty_app/product/contains/static_texts.dart';

class EpisodeDetails extends StatelessWidget {
  EpisodeDetails({super.key, required this.episode});
  final Episodes episode;
  final Service _service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColors.episodeDetailsGeneralBGColor,
      appBar: AppBar(
        title: Text(
          episode.name ?? StaticTexts.noDataError,
          style: TextStyle(
              fontWeight: StaticFontStyle.episodeDetailsPageTitleFontWeight),
        ),
        backgroundColor: StaticColors.episodeDetailsBGColor,
        foregroundColor: StaticColors.episodeDetailsFGColor,
        elevation: StaticFontStyle.episodeDetailsPageElevation,
      ),
      body: SingleChildScrollView(
        padding: StaticPaddings.episodeDetailsBodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EpisodePageInfoCard(
              icon: Icons.calendar_today,
              title: StaticTexts.airDate,
              value: episode.airDate,
            ),
            EpisodePageInfoCard(
              icon: Icons.video_library,
              title: StaticTexts.episode,
              value: episode.episode,
            ),
            SizedBox(
                height:
                    StaticFontStyle.episodeDetailsInfoCardAndTitleSpaceBetween),
            Text(
              StaticTexts.characters,
              style: TextStyle(
                fontSize: StaticFontStyle.episodeDetailCharactersTitleSize,
                fontWeight:
                    StaticFontStyle.episodeDetailCharactersTitleFontWeight,
                color: StaticColors.charactersColor,
              ),
            ),
            SizedBox(
                height: StaticFontStyle.episodeDetailTitleAndCardsSpaceBetween),
            if (episode.characters == null || episode.characters!.isEmpty)
              EpisodePageNoCharactersCard()
            else
              ...episode.characters!.map((characterUrl) {
                return FutureBuilder<CharacterModel?>(
                  future: _service.getCharacter(characterUrl),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return EpisodePageLoadingCard();
                    } else {
                      final character = snapshot.data!;
                      return _characterCard(context, character);
                    }
                  },
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _characterCard(BuildContext context, CharacterModel character) {
    return Card(
      color: StaticColors.episodeDetailsCharacterCardColor,
      elevation: StaticFontStyle.episodeDetailsCharacterCardElevation,
      margin: StaticMargins.episodeDetailsCharacterCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius:
              StaticFontStyle.episodeDetailsCharacterCardBorderRadius),
      child: ListTile(
        leading: CircleAvatar(
          radius: StaticFontStyle.episodeDetailsCharacterCardCircleAvatarRadius,
          backgroundImage:
              NetworkImage(character.image ?? StaticTexts.noDataError),
        ),
        title: Text(
          character.name ?? StaticTexts.noDataError,
          style: TextStyle(
              color: StaticColors.episodeDetailsCharacterNameColor,
              fontSize: StaticFontStyle.episodeDetailsCharacterNameSize,
              fontWeight:
                  StaticFontStyle.episodeDetailsCharacterNameFontWeight),
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.circle,
              size: StaticFontStyle.episodeDetailsIconsCircleSize,
              color: (character.status == StaticTexts.alive)
                  ? StaticColors.characterAliveColor
                  : (character.status == StaticTexts.dead)
                      ? StaticColors.characterDeadColor
                      : StaticColors.characterUnknownColor,
            ),
            SizedBox(
                width: StaticFontStyle
                    .episodeDetailsIconsCircleAndSubtitleSpaceBetween),
            Text(
              '${character.status} - ${character.species}',
              style: TextStyle(
                  color: StaticColors.episodeDetailsCharacterSubtitleColor,
                  fontSize:
                      StaticFontStyle.episodeDetailsCharacterCardSubtitleSize),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CharacterDetails(character: character),
            ),
          );
        },
      ),
    );
  }
}
