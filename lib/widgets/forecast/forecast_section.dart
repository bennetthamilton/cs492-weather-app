import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/forecast_provider.dart';
import 'package:weatherapp/widgets/forecast/detailed_forecast.dart';
import 'package:weatherapp/widgets/forecast/forecasts_list.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final forecastProvider = context.watch<ForecastProvider>();
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (forecastProvider.forecasts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Text(
            'Set a location to view the forecast.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (isLandscape) {
      return SizedBox(
        height: 420,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Expanded(
              flex: 8,
              child: DetailedForecast(),
            ),
            SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: ForecastsRowWidget(
                isLandscape: true,
              ),
            ),
          ],
        ),
      );
    }

    return const Column(
      children: [
        SizedBox(
          height: 320,
          child: DetailedForecast(),
        ),
        SizedBox(
          height: 210,
          child: ForecastsRowWidget(
            isLandscape: false,
          ),
        ),
      ],
    );
  }
}