import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature_product/location/location_model.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({super.key, required this.location});
  final Locations location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name ?? ''),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${location.type}'),
            Text('Dimension: ${location.dimension}'),
            Text('Residents: ${location.residents?.length}'),
          ],
        ),
      ),
    );
  }
}
