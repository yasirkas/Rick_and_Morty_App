import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/model/character_model.dart';
import 'package:rick_and_morty_app/feature/location/widgets/character_card.dart';
import 'package:rick_and_morty_app/feature/location/widgets/info_card.dart';
import 'package:rick_and_morty_app/feature/location/widgets/loading_card.dart';
import 'package:rick_and_morty_app/feature/location/widgets/no_residents_card.dart';
import 'package:rick_and_morty_app/product/constants/static_colors.dart';
import 'package:rick_and_morty_app/feature/location/model/location_model.dart';
import 'package:rick_and_morty_app/product/service/service.dart';
import 'package:rick_and_morty_app/product/constants/static_font_style.dart';
import 'package:rick_and_morty_app/product/constants/static_paddings.dart';
import 'package:rick_and_morty_app/product/constants/static_texts.dart';

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
      body: ListView.builder(
        padding: StaticPaddings.locationDetailsBodyPadding,
        itemCount: (location.residents == null || location.residents!.isEmpty)
            ? 4 // Info cards + Title + No Residents Card
            : (location.residents!.length +
                3), // Info cards + Title + Residents
        itemBuilder: (context, index) {
          if (index == 0) {
            return LocationPageInfoCard(
              icon: Icons.public,
              title: StaticTexts.type,
              value: location.type,
            );
          } else if (index == 1) {
            return LocationPageInfoCard(
              icon: Icons.location_on,
              title: StaticTexts.dimension,
              value: location.dimension,
            );
          } else if (index == 2) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                    height: StaticFontStyle
                        .locationDetailTitleAndCardsSpaceBetween),
              ],
            );
          } else if (location.residents == null ||
              location.residents!.isEmpty) {
            return LocationPageNoResidentsCard();
          } else {
            final characterUrl = location.residents![index - 3];
            return FutureBuilder<CharacterModel?>(
              future: _service.getCharacter(characterUrl),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LocationPageLoadingCard();
                } else {
                  final character = snapshot.data!;
                  return LocationPageCharacterCard(
                    character: character,
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
