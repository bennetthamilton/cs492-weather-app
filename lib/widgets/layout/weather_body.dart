import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/app/theme/theme_provider.dart';
import 'package:weatherapp/widgets/forecast/forecast_section.dart';
import 'package:weatherapp/widgets/location/location_search_field.dart';

class WeatherAppBody extends StatelessWidget {
  const WeatherAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ForecastWidget(),
            const SizedBox(height: 8),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Locations",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const LocationWidget(),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SwitchListTile(
                  title: Text(
                    themeProvider.darkMode ? "Dark Mode" : "Light Mode",
                    style: theme.textTheme.titleMedium,
                  ),
                  subtitle: const Text("Toggle the app theme"),
                  value: themeProvider.darkMode,
                  onChanged: themeProvider.setDarkMode,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}