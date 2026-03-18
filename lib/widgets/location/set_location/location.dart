import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/widgets/location/set_location/location_buttons.dart';
import 'package:weatherapp/widgets/location/saved_locations/saved_locations.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final TextEditingController _locationController = TextEditingController();
  bool _showError = false;

  late LocationProvider _locationActions;

  @override
  void initState() {
    super.initState();
    _locationController.addListener(() {
      if (_locationController.text.isNotEmpty) {
        setState(() {
          _showError = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locationActions = context.read<LocationProvider>();
  }

  void _setLocation() {
    if (_locationController.text.isEmpty) {
      setState(() {
        _showError = true;
      });
    } else {
      _locationActions.setLocationFromString(_locationController.text);
    }
  }

  void _clearLocation() {
    _locationActions.setLocationFromString(null);
    _locationController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();
    final currentLocation = locationProvider.location;
    final locationText = currentLocation != null
        ? "${currentLocation.city}, ${currentLocation.state} ${currentLocation.zip}"
        : "No location selected";

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: "Enter Location",
                errorText: _showError ? "Error: Must Type Location" : null,
                border: const OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _setLocation(),
            ),
            LocationButtons(
              setLocation: _setLocation,
              setLocationFromGps: _locationActions.setLocationFromGps,
              clearLocation: _clearLocation,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                locationText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Expanded(child: SavedLocations()),
          ],
        ),
      ),
    );
  }
}
