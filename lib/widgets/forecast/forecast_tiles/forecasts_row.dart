import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/providers/forecast_provider.dart';
import 'forecast_tile.dart';

class ForecastsRowWidget extends StatelessWidget {
  const ForecastsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final forecastProvider = context.watch<ForecastProvider>();

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
