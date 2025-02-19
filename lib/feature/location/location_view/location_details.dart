import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/character_view/character_details.dart';
import 'package:rick_and_morty_app/feature/character/character_model/character_model.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/feature/location/location_model/location_model.dart';
import 'package:rick_and_morty_app/feature/service/service.dart';
import 'package:rick_and_morty_app/product/contains/static_texts.dart';

class LocationDetails extends StatelessWidget {
  LocationDetails({super.key, required this.location});
  final Locations location;
  final Service _service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColors().locationDetailsGeneralBGColor,
      appBar: AppBar(
        title: Text(
          location.name ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: StaticColors().locationDetailsBGColor,
        foregroundColor: StaticColors().locationDetailsFGColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _infoCard(Icons.public, StaticTexts().type, location.type),
            _infoCard(
                Icons.location_on, StaticTexts().dimension, location.dimension),
            const SizedBox(height: 16),
            Text(
              StaticTexts().residents,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: StaticColors().residentsColor,
              ),
            ),
            const SizedBox(height: 10),
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
      color: StaticColors().locationDetailsInfoCardBGColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: StaticColors().locationDetailsIconColor),
        title: Text(
          title,
          style: TextStyle(
              color: StaticColors().locationDetailsTitleColor, fontSize: 14),
        ),
        subtitle: Text(
          value ?? StaticTexts().unknown,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: StaticColors().locationDetailsSubtitleColor),
        ),
      ),
    );
  }

  Widget _characterCard(BuildContext context, CharacterModel character) {
    return Card(
      color: StaticColors().locationDetailsCharacterCardColor,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(character.image ?? ''),
        ),
        title: Text(
          character.name ?? '',
          style: TextStyle(
              color: StaticColors().locationDetailsCharacterNameColor,
              fontSize: 18),
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.circle,
              size: 12,
              color: (character.status == 'Alive')
                  ? StaticColors().characterAliveColor
                  : (character.status == 'Dead')
                      ? StaticColors().characterDeadColor
                      : StaticColors().characterUnknownColor,
            ),
            const SizedBox(width: 6),
            Text(
              '${character.status} - ${character.species}',
              style: TextStyle(
                  color: StaticColors().locationDetailsCharacterSubtitleColor,
                  fontSize: 14),
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
      color: StaticColors().loadingCardColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Image.asset('assets/gif/portal_loading.gif'),
        title: Text(
          StaticTexts().loading,
          style: TextStyle(color: StaticColors().loadingTextColor),
        ),
      ),
    );
  }

  Widget _noResidentsCard() {
    return Card(
      color: StaticColors().noResidentsCardColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          StaticTexts().noResidentsAvailable,
          style: TextStyle(color: StaticColors().noResidentsAvailableColor),
        ),
      ),
    );
  }
}
