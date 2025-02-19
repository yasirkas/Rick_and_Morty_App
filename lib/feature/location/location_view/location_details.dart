import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/character_view/character_details.dart';
import 'package:rick_and_morty_app/feature/character/character_model/character_model.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/feature/location/location_model/location_model.dart';
import 'package:rick_and_morty_app/feature/service/service.dart';
import 'package:rick_and_morty_app/product/contains/static_font_style.dart';
import 'package:rick_and_morty_app/product/contains/static_margins.dart';
import 'package:rick_and_morty_app/product/contains/static_paddings.dart';
import 'package:rick_and_morty_app/product/contains/static_paths.dart';
import 'package:rick_and_morty_app/product/contains/static_texts.dart';

class LocationDetails extends StatelessWidget {
  LocationDetails({super.key, required this.location});
  final Locations location;
  final Service _service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColors.locationDetailsGeneralBGColor,
      appBar: AppBar(
        title: Text(
          location.name ?? StaticTexts.noDataError,
          style: TextStyle(
              fontWeight: StaticFontStyle.locationDetailsPageTitleFontWeight),
        ),
        backgroundColor: StaticColors.locationDetailsBGColor,
        foregroundColor: StaticColors.locationDetailsFGColor,
        elevation: StaticFontStyle.locationDetailsPageElevation,
      ),
      body: SingleChildScrollView(
        padding: StaticPaddings.locationDetailsBodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _infoCard(Icons.public, StaticTexts.type, location.type),
            _infoCard(
                Icons.location_on, StaticTexts.dimension, location.dimension),
            SizedBox(
                height: StaticFontStyle
                    .locationDetailsInfoCardAndTitleSpaceBetween),
            Text(
              StaticTexts.residents,
              style: TextStyle(
                fontSize: StaticFontStyle.locationDetailResidentsTitleSize,
                fontWeight:
                    StaticFontStyle.locationDetailCharactersTitleFontWeight,
                color: StaticColors.residentsColor,
              ),
            ),
            SizedBox(
                height:
                    StaticFontStyle.locationDetailTitleAndCardsSpaceBetween),
            if (location.residents == null || location.residents!.isEmpty)
              _noResidentsCard()
            else
              ...location.residents!.map((characterUrl) {
                return FutureBuilder<CharacterModel?>(
                  future: _service.getCharacter(characterUrl),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _loadingCard();
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

  Widget _infoCard(IconData icon, String title, String? value) {
    return Card(
      color: StaticColors.locationDetailsInfoCardBGColor,
      margin: StaticMargins.locationDetailsInfoCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius: StaticFontStyle.locationDetailInfoCardBorderRadius),
      child: ListTile(
        leading: Icon(icon, color: StaticColors.locationDetailsIconColor),
        title: Text(
          title,
          style: TextStyle(
              color: StaticColors.locationDetailsTitleColor,
              fontSize: StaticFontStyle.locationDetailInfoCardTitleSize),
        ),
        subtitle: Text(
          value ?? StaticTexts.unknown,
          style: TextStyle(
              fontSize: StaticFontStyle.locationDetailInfoCardSubtitleSize,
              fontWeight:
                  StaticFontStyle.locationDetailInfoCardSubtitleFontWeight,
              color: StaticColors.locationDetailsSubtitleColor),
        ),
      ),
    );
  }

  Widget _characterCard(BuildContext context, CharacterModel character) {
    return Card(
      color: StaticColors.locationDetailsCharacterCardColor,
      elevation: StaticFontStyle.locationDetailsCharacterCardElevation,
      margin: StaticMargins.locationDetailsCharacterCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius:
              StaticFontStyle.locationDetailsCharacterCardBorderRadius),
      child: ListTile(
        leading: CircleAvatar(
          radius:
              StaticFontStyle.locationDetailsCharacterCardCircleAvatarRadius,
          backgroundImage: NetworkImage(character.image ?? StaticTexts.noDataError),
        ),
        title: Text(
          character.name ?? StaticTexts.noDataError,
          style: TextStyle(
              color: StaticColors.locationDetailsCharacterNameColor,
              fontSize: StaticFontStyle.locationDetailsCharacterNameSize,
              fontWeight:
                  StaticFontStyle.locationDetailsCharacterNameFontWeight),
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.circle,
              size: StaticFontStyle.locationDetailsIconsCircleSize,
              color: (character.status == StaticTexts.alive)
                  ? StaticColors.characterAliveColor
                  : (character.status == StaticTexts.dead)
                      ? StaticColors.characterDeadColor
                      : StaticColors.characterUnknownColor,
            ),
            SizedBox(
                width: StaticFontStyle
                    .locationDetailsIconsCircleAndSubtitleSpaceBetween),
            Text(
              '${character.status} - ${character.species}',
              style: TextStyle(
                  color: StaticColors.locationDetailsCharacterSubtitleColor,
                  fontSize:
                      StaticFontStyle.locationDetailsCharacterCardSubtitleSize),
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

  Widget _loadingCard() {
    return Card(
      color: StaticColors.loadingCardColor,
      margin: StaticMargins.locationDetailsLoadingCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius: StaticFontStyle.locationDetailsLoadingCardBorderRadius),
      child: ListTile(
        leading: Image.asset(StaticPaths.loadingBarPath),
        title: Text(
          StaticTexts.loading,
          style: TextStyle(color: StaticColors.loadingTextColor),
        ),
      ),
    );
  }

  Widget _noResidentsCard() {
    return Card(
      color: StaticColors.noResidentsCardColor,
      margin: StaticMargins.locationDetailsNoResidentsCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius:
              StaticFontStyle.locationDetailsNoCharactersCardBorderRadius),
      child: ListTile(
        title: Text(
          StaticTexts.noResidentsAvailable,
          style: TextStyle(color: StaticColors.noResidentsAvailableColor),
        ),
      ),
    );
  }
}
