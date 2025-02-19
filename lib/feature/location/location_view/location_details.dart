import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/character_model/character_model.dart';
import 'package:rick_and_morty_app/feature/location/location_widgets/location_page_character_card.dart';
import 'package:rick_and_morty_app/feature/location/location_widgets/location_page_info_card.dart';
import 'package:rick_and_morty_app/feature/location/location_widgets/location_page_loading_card.dart';
import 'package:rick_and_morty_app/feature/location/location_widgets/location_page_no_residents_card.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/feature/location/location_model/location_model.dart';
import 'package:rick_and_morty_app/feature/service/service.dart';
import 'package:rick_and_morty_app/product/contains/static_font_style.dart';
import 'package:rick_and_morty_app/product/contains/static_paddings.dart';
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
            LocationPageInfoCard(
              icon: Icons.public,
              title: StaticTexts.type,
              value: location.type,
            ),
            LocationPageInfoCard(
              icon: Icons.location_on,
              title: StaticTexts.dimension,
              value: location.dimension,
            ),
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
              LocationPageNoResidentsCard()
            else
              ...location.residents!.map((characterUrl) {
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
              }),
          ],
        ),
      ),
    );
  }

}
