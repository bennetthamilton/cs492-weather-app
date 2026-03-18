import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/providers/forecast_provider.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/app/theme/theme_provider.dart';
import 'package:weatherapp/widgets/layout/weather_bar.dart';
import 'package:weatherapp/widgets/layout/weather_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool locationSet = false;

  @override
  void initState() {
    super.initState();

    final themeProvider = context.read<ThemeProvider>();
    themeProvider.loadDarkModePrefs();

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final locationProvider = context.read<LocationProvider>();
    await locationProvider.initializeLocationOnLaunch();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final locationProvider = context.watch<LocationProvider>();
    final forecastProvider = context.read<ForecastProvider>();

    if (locationProvider.location != null) {
      locationSet = true;
      forecastProvider.getForecasts(locationProvider.location);
    } else {
      locationSet = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WeatherAppBar(title: widget.title),
      body: const WeatherAppBody(),
    );
  }
}