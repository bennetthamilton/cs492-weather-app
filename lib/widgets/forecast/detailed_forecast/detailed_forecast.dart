import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/forecast.dart';
import 'package:weatherapp/models/pexels_image.dart';
import 'package:weatherapp/providers/forecast_provider.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/providers/theme_provider.dart';
import 'package:weatherapp/widgets/forecast/detailed_forecast/detailed_forecast_text.dart';

class DetailedForecast extends StatefulWidget {
  const DetailedForecast({super.key});

  @override
  State<DetailedForecast> createState() => _DetailedForecastState();
}

class _DetailedForecastState extends State<DetailedForecast> {
  String? _imageUrl;
  String? _lastImageQueryKey;
  final PexelsImage pexelsImage = PexelsImage();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final activeForecast = context.watch<ForecastProvider>().activeForecast;
    final location = context.watch<LocationProvider>().location;

    if (activeForecast == null) return;

    final queryKey = _buildQueryKey(activeForecast, location?.state);

    if (queryKey != _lastImageQueryKey) {
      _lastImageQueryKey = queryKey;
      _fetchAndUpdateImage(activeForecast, state: location?.state);
    }
  }

  String _buildQueryKey(Forecast forecast, String? state) {
    final dayNight = forecast.isDaytime ? 'day' : 'night';
    return '${state ?? "unknown"}|$dayNight|${forecast.shortForecast.toLowerCase()}';
  }

  String _mapWeatherKeyword(String shortForecast) {
    final forecast = shortForecast.toLowerCase();

    if (forecast.contains('thunder')) return 'thunderstorm';
    if (forecast.contains('snow') || forecast.contains('blizzard')) return 'snow';
    if (forecast.contains('sleet') || forecast.contains('hail')) return 'winter storm';
    if (forecast.contains('rain') ||
        forecast.contains('showers') ||
        forecast.contains('drizzle')) {
      return 'rain';
    }
    if (forecast.contains('fog') || forecast.contains('mist')) return 'fog';
    if (forecast.contains('cloud')) return 'cloudy';
    if (forecast.contains('sunny') || forecast.contains('clear')) return 'clear sky';

    return shortForecast;
  }

  List<String> _buildQueries(Forecast forecast, {String? state}) {
    final dayNight = forecast.isDaytime ? 'day' : 'night';
    final weatherKeyword = _mapWeatherKeyword(forecast.shortForecast);

    final statePart =
        (state != null && state.trim().isNotEmpty) ? state.trim() : null;

    return [
      if (statePart != null) '$statePart $dayNight $weatherKeyword landscape',
      if (statePart != null) '$statePart $weatherKeyword skyline',
      if (statePart != null) '$statePart nature $dayNight',
      '$dayNight $weatherKeyword landscape',
      '$weatherKeyword nature',
      '$dayNight sky',
    ];
  }

  Future<void> _fetchAndUpdateImage(
    Forecast forecast, {
    String? state,
  }) async {
    setState(() {
      _imageUrl = null;
    });

    final queries = _buildQueries(forecast, state: state);
    final imageUrl = await pexelsImage.getImageFromQueries(queries);

    if (!mounted) return;

    setState(() {
      _imageUrl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeForecast = context.watch<ForecastProvider>().activeForecast;
    final themeProvider = context.read<ThemeProvider>();

    if (activeForecast == null) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Text(
            'Select a forecast to see details',
            style: TextStyle(
              color: themeProvider.secondaryTextColor,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
    }

    return ExcludeSemantics(
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              if (_imageUrl != null)
                Positioned.fill(
                  child: Image.network(
                    _imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),

              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              ),

              DetailedForecastText(activeForecast: activeForecast),

              if (_imageUrl == null)
                const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }
}