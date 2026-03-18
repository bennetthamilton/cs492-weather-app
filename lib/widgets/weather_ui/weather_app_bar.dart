import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/providers/theme_provider.dart';

class WeatherAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WeatherAppBar({
    super.key,
    required this.title,
    required TabController tabController,
  }) : _tabController = tabController;

  final String title;
  final TabController _tabController;

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final location = locationProvider.location;
    final theme = Theme.of(context);

    return AppBar(
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: [
        Semantics(
          label: "Dark Mode Switch",
          child: Switch(
            value: themeProvider.darkMode,
            onChanged: themeProvider.setDarkMode,
          ),
        ),
        if (location != null)
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.28,
              ),
              child: Center(
                child: Text(
                  "${location.city}, ${location.state}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: themeProvider.secondaryTextColor,
                  ),
                ),
              ),
            ),
          ),
      ],
      bottom: TabBar(
        controller: _tabController,
        tabs: [
          Semantics(
            label: "Forecasts Tab",
            child: Tab(icon: Icon(Icons.sunny_snowing)),
          ),
          Semantics(
            label: "Location Tab",
            child: Tab(icon: Icon(Icons.location_pin)),
          ),
        ],
      ),
    );
  }
}