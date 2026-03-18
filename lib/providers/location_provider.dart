import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/models/location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/location_database.dart';

class LocationProvider extends ChangeNotifier {
  Location? location;

  List<Location> savedLocations = [];

  LocationDatabase? _db;

  Future<void> openDatabase() async {
    _db = await LocationDatabase.open();
    await loadSavedLocations();
    await loadSharedZip();
  }

  Future<void> initializeLocationOnLaunch() async {
    await openDatabase();

    if (location == null) {
      await setLocationFromGps();
    }
  }

  Future<void> loadSharedZip() async {
    if (location == null && savedLocations.isNotEmpty) {
      final prefs = SharedPreferencesAsync();
      String? savedZip = await prefs.getString("savedZip");

      for (int i = 0; i < savedLocations.length; i++) {
        if (savedLocations[i].zip == savedZip) {
          location = savedLocations[i];
          notifyListeners();
        }
      }
    }
  }

  Future<void> loadSavedLocations() async {
    if (_db != null) {
      savedLocations = (await _db?.getLocations())!;
    }

    notifyListeners();
  }

  void deleteLocation(Location loc) async {
    if (_db != null) {
      await _db?.deleteLocation(loc);
      loadSavedLocations();
    }
  }

  Future<void> storeSavedLocation(Location loc) async {
    if (_db != null) {
      await _db?.insertLocation(loc);
      loadSavedLocations();
    }
  }

  Future<void> setLocationFromString(String? locationString) async {
    if (locationString != null && locationString.trim().isNotEmpty) {
      location = await getLocationFromString(locationString);
    } else {
      location = null;
    }

    if (location != null) {
      await storeSavedLocation(location!);
    }

    notifyListeners();
    await saveZipToPrefs();
  }

  Future<void> setLocationFromGps() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return;
    }

    location = await getLocationFromGps();

    if (location != null) {
      await storeSavedLocation(location!);
    }

    notifyListeners();
    await saveZipToPrefs();
  }

  Future<void> setLocation(Location loc) async {
    location = loc;
    notifyListeners();
    saveZipToPrefs();
  }

  Future<void> saveZipToPrefs() async {
    final prefs = SharedPreferencesAsync();
    if (location != null) {
      await prefs.setString("savedZip", location!.zip);
    } else {
      await prefs.remove("savedZip");
    }
  }
}
