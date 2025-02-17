import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature_product/character/character_model.dart';

class CharacterDetails extends StatelessWidget {
  const CharacterDetails({super.key, required this.character});
  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50, // Açık ton arka plan
      appBar: AppBar(
        title: Text(character.name ?? ''),
        backgroundColor: Colors.lightBlue.shade200,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(character.image ?? ''),
            ),
            const SizedBox(height: 12),
            Text(
              character.name ?? '',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Bilgi Kartları
            _infoCard(Icons.person, "Species", character.species),
            _infoCard(Icons.male, "Gender", character.gender),
            _infoCard(Icons.location_on, "Location", character.location?.name),
            _infoCard(Icons.public, "Origin", character.origin?.name),
            _infoCard(
                Icons.tv, "Episodes", character.episode?.length.toString()),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String? value) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey.shade800),
        title: Text(
          title,
          style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 14),
        ),
        subtitle: Text(
          value ?? 'Unknown',
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
    );
  }
}
