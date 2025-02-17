import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature_product/character/character_details.dart';
import 'package:rick_and_morty_app/feature_product/character/character_model.dart';
import 'package:rick_and_morty_app/feature_product/location/location_model.dart';
import 'package:rick_and_morty_app/feature_product/service/service.dart';

class LocationDetails extends StatelessWidget {
  LocationDetails({super.key, required this.location});
  final Locations location;
  final Service _service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          location.name ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade400,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _infoCard(Icons.public, "Type", location.type),
            _infoCard(Icons.location_on, "Dimension", location.dimension),
            const SizedBox(height: 16),
            Text(
              'Residents',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade700,
              ),
            ),
            const SizedBox(height: 10),
            ...location.residents!.map((characterUrl) {
              return FutureBuilder<CharacterModel?>(
                future: _service.getCharacter(characterUrl),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _loadingCard();
                  } else if (snapshot.hasError) {
                    return _errorCard();
                  } else if (!snapshot.hasData) {
                    return _noDataCard();
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
      color: Colors.blueGrey.shade100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey.shade700),
        title: Text(
          title,
          style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 14),
        ),
        subtitle: Text(
          value ?? 'Unknown',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _characterCard(BuildContext context, CharacterModel character) {
    return Card(
      color: Colors.white,
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
          style: const TextStyle(color: Colors.black87, fontSize: 18),
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.circle,
              size: 12,
              color: (character.status == 'Alive')
                  ? Colors.green
                  : (character.status == 'Dead')
                      ? Colors.red
                      : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              '${character.status} - ${character.species}',
              style: const TextStyle(color: Colors.black54, fontSize: 14),
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
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const ListTile(
        leading: CircularProgressIndicator(),
        title: Text(
          'Loading...',
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }

  Widget _errorCard() {
    return Card(
      color: Colors.red.shade100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const ListTile(
        title: Text(
          'Error loading character',
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }

  Widget _noDataCard() {
    return Card(
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const ListTile(
        title: Text(
          'No data available',
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
