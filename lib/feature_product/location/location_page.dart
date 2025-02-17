import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature_product/location/location_details.dart';
import 'package:rick_and_morty_app/feature_product/location/location_model.dart';
import 'package:rick_and_morty_app/feature_product/service/service.dart';
import 'package:rick_and_morty_app/feature_product/utility/loading_mixin.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage>
    with LoadingMixin<LocationPage> {
  List<Locations>? _locations;
  final Service _service = Service();

  @override
  void initState() {
    super.initState();
    _getLocations();
  }

  Future<void> _getLocations() async {
    changeLoading();
    _locations = await _service.getLocations();
    changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text("Locations Page"),
        backgroundColor: Colors.blueAccent,
        actions: [
          isLoading ? CircularProgressIndicator.adaptive() : SizedBox.shrink()
        ],
      ),
      body: ListView.builder(
        itemCount: _locations?.length ?? 0,
        itemBuilder: (context, index) {
          final location = _locations?[index];
          return ListTile(
            title: Text(location?.name ?? ''),
            onTap: () {
              if (location != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LocationDetails(location: location)));
              }
            },
          );
        },
      ),
    );
  }
}
