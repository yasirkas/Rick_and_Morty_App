import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature_product/character/character_details.dart';
import 'package:rick_and_morty_app/feature_product/character/character_model.dart';
import 'package:rick_and_morty_app/feature_product/episode/episode_model.dart';
import 'package:rick_and_morty_app/feature_product/service/service.dart';

class EpisodeDetails extends StatelessWidget {
  EpisodeDetails({super.key, required this.episode});
  final Episodes episode;
  final Service _service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200, // Açık gri arka plan
      appBar: AppBar(
        title: Text(
          episode.name ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade300, // Açık mavi ton
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoCard(Icons.calendar_today, "Air Date", episode.airDate),
            _infoCard(Icons.video_library, "Episode", episode.episode),

            const SizedBox(height: 16),
            Text(
              'Characters:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade700,
              ),
            ),
            const SizedBox(height: 10),

            // Karakter Listesi
            ...episode.characters!.map((characterUrl) {
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

  // Bilgi Kartı
  Widget _infoCard(IconData icon, String title, String? value) {
    return Card(
      color: Colors.blueGrey.shade100, // Açık mavi-gri tonları
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

  // Karakter Kartı
  Widget _characterCard(BuildContext context, CharacterModel character) {
    return Card(
      color: Colors.white, // Temiz ve modern görünüm
      elevation: 2, // Hafif gölge efekti
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

  // Yükleme Kartı
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

  // Hata Kartı
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

  // Veri Yok Kartı
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
