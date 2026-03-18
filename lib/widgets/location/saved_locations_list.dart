import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/widgets/location/saved_location_card.dart';

class SavedLocations extends StatelessWidget {
  const SavedLocations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();

    if (locationProvider.savedLocations.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text("No saved locations yet."),
      );
    }

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: locationProvider.savedLocations
          .map((location) => SavedLocation(location: location))
          .toList(),
    );
  }
}