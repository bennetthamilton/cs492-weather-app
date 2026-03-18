import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/forecast_provider.dart';
import 'package:weatherapp/widgets/forecast/detailed_forecast.dart';
import 'package:weatherapp/widgets/forecast/forecasts_row.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final forecastProvider = context.watch<ForecastProvider>();
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (forecastProvider.forecasts.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Set a location to view the forecast.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (isLandscape) {
      return Row(
        children: const [
          Expanded(
            flex: 3,
            child: DetailedForecast(),
          ),
          Expanded(
            flex: 2,
            child: ForecastsRowWidget(
              isLandscape: true,
            ),
          ),
        ],
      );
    }

    return const Column(
      children: [
        Expanded(
          flex: 2,
          child: DetailedForecast(),
        ),
        Expanded(
          child: ForecastsRowWidget(
            isLandscape: false,
          ),
        ),
      ],
    );
  }
}