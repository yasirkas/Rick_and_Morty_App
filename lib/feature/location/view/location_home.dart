import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/product/costants/static_colors.dart';
import 'package:rick_and_morty_app/feature/location/view/location_details.dart';
import 'package:rick_and_morty_app/feature/location/model/location_model.dart';
import 'package:rick_and_morty_app/product/service/service.dart';
import 'package:rick_and_morty_app/product/costants/static_font_style.dart';
import 'package:rick_and_morty_app/product/costants/static_margins.dart';
import 'package:rick_and_morty_app/product/costants/static_paddings.dart';
import 'package:rick_and_morty_app/product/costants/static_paths.dart';
import 'package:rick_and_morty_app/product/utility/loading_mixin.dart';
import 'package:rick_and_morty_app/product/costants/static_texts.dart';

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
        foregroundColor: StaticColors.locationPageFGColor,
        title: Text(StaticTexts.locationsPageTitle),
        backgroundColor: StaticColors.locationPageBGColor,
      ),
      body: isLoading
          ? Center(child: Image.asset(StaticPaths.loadingBarPath))
          : _locations == null
              ? Center(child: Text(StaticTexts.noLocationsFound))
              : ListView.builder(
                  padding: StaticPaddings.locationListViewBuilderPadding,
                  itemCount: _locations?.length ?? StaticFontStyle.errorLength,
                  itemBuilder: (context, index) {
                    final location = _locations?[index];
                    return Card(
                      elevation: StaticFontStyle.locationPageCardElevation,
                      margin: StaticMargins.locationPageMargin,
                      child: ListTile(
                        contentPadding:
                            StaticPaddings.locationPageContendtPadding,
                        leading: Icon(
                          Icons.location_on,
                          size: StaticFontStyle.locationPageCardIconSize,
                          color: StaticColors.locationPageIconColor,
                        ),
                        title: Text(
                          location?.name ?? StaticTexts.noDataError,
                          style: TextStyle(
                            color: StaticColors.locationPageNameColor,
                            fontWeight:
                                StaticFontStyle.locationPageCardTitleFontWeight,
                            fontSize: StaticFontStyle.locationPageCardTitleSize,
                          ),
                        ),
                        subtitle: Text(
                          location?.type ?? StaticTexts.noTypeAvailable,
                          style: TextStyle(
                              color: StaticColors.locationPageSubtitleColor),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: StaticFontStyle.locationPageCardArrowSize,
                          color: StaticColors.locationPageArrowColor,
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
