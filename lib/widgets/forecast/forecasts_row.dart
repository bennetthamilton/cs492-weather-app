import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/providers/forecast_provider.dart';
import 'forecast_tile.dart';

class ForecastsRowWidget extends StatelessWidget {
  const ForecastsRowWidget({
    super.key,
    required this.isLandscape,
  });

  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    final forecastProvider = context.watch<ForecastProvider>();

    if (isLandscape) {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        scrollDirection: Axis.vertical,
        itemCount: forecastProvider.forecasts.length,
        separatorBuilder: (_, __) => const SizedBox(height: 6),
        itemBuilder: (context, index) => SizedBox(
          height: 160,
          child: ForecastTileWidget(
            forecast: forecastProvider.forecasts[index],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      scrollDirection: Axis.horizontal,
      itemCount: forecastProvider.forecasts.length,
      separatorBuilder: (_, __) => const SizedBox(width: 4),
      itemBuilder: (context, index) => ForecastTileWidget(
        forecast: forecastProvider.forecasts[index],
      ),
    );
  }
}