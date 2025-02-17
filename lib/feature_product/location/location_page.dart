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
        title: const Text("Locations"),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? Center(child: Image.asset('assets/gif/portal_loading.gif'))
          : _locations == null
              ? const Center(child: Text('No locations found.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _locations?.length ?? 0,
                  itemBuilder: (context, index) {
                    final location = _locations?[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: Icon(
                          Icons.location_on,
                          size: 40,
                          color: Colors.greenAccent,
                        ),
                        title: Text(
                          location?.name ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(location?.type ?? 'No type available'),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.greenAccent,
                        ),
                        onTap: () {
                          if (location != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  LocationDetails(location: location),
                            ));
                          }
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
