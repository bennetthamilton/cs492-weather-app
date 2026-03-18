import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/forecast/forecast.dart';
import 'package:weatherapp/widgets/location/set_location/location.dart';

class WeatherAppBody extends StatelessWidget {
  const WeatherAppBody({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: TabBarView(
              controller: _tabController,
              children: const [
                ForecastWidget(),
                LocationWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
