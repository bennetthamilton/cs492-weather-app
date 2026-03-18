import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherapp/models/forecast_model.dart';

class DetailedForecastText extends StatefulWidget {
  const DetailedForecastText({
    super.key,
    required this.activeForecast,
    required this.cityName,
  });

  final Forecast activeForecast;
  final String cityName;

  @override
  State<DetailedForecastText> createState() => _DetailedForecastTextState();
}

class _DetailedForecastTextState extends State<DetailedForecastText> {
  final ScrollController _scrollController = ScrollController();

  String _dateLabel() {
    final label = widget.activeForecast.name.trim();
    return label.toLowerCase() == 'today' ? 'Today' : label;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      widget.activeForecast.imagePath,
                      width: 28,
                      height: 28,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.cityName,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _dateLabel(),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(height: 1, color: Colors.white54),
          Expanded(
            child: Column(
              children: [
                const Spacer(),
                Text(
                  '${widget.activeForecast.temperature}°',
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    
                    color: Colors.white70,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.white54),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: false,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Text(
                  widget.activeForecast.detailedForecast,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}