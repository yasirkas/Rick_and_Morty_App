import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature_product/contains/static_colors.dart';
import 'package:rick_and_morty_app/feature_product/location/location_details.dart';
import 'package:rick_and_morty_app/feature_product/location/location_model.dart';
import 'package:rick_and_morty_app/feature_product/service/service.dart';
import 'package:rick_and_morty_app/feature_product/utility/loading_mixin.dart';
import 'package:rick_and_morty_app/feature_product/contains/static_texts.dart';

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
        foregroundColor: StaticColors().locationPageFGColor,
        title: Text(StaticTexts().locationsPageTitle),
        backgroundColor: StaticColors().locationPageBGColor,
      ),
      body: isLoading
          ? Center(child: Image.asset('assets/gif/portal_loading.gif'))
          : _locations == null
              ? Center(child: Text(StaticTexts().noLocationsFound))
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
                          color: StaticColors().locationPageIconColor,
                        ),
                        title: Text(
                          location?.name ?? '',
                          style: TextStyle(
                            color: StaticColors().locationPageNameColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          location?.type ?? StaticTexts().noTypeAvailable,
                          style: TextStyle(
                              color: StaticColors().locationPageSubtitleColor),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: StaticColors().locationPageArrowColor,
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
