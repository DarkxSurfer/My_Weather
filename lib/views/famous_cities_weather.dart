import 'package:flutter/material.dart';

import '/models/famous_city.dart';
import '/screens/weather_detail_screen.dart';
import '/widgets/city_weather_tile.dart';

class FamousCitiesWeather extends StatelessWidget {
  const FamousCitiesWeather({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: famousCities.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        final city = famousCities[index];

        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => WeatherDetailScreen(
                  cityName: city.name,
                ),
              ),
            );
          },
          child: CityWeatherTile(
            index: index,
            city: city,
          ),
        );
      },
    );
  }
}

// List of famous cities as a constant
List<FamousCity> famousCities = [
  FamousCity(name: 'Tokyo', lat: 35.6833, lon: 139.7667),
  FamousCity(name: 'New Delhi', lat: 28.5833, lon: 77.2),
  FamousCity(name: 'Paris', lat: 48.85, lon: 2.3333),
  FamousCity(name: 'London', lat: 51.4833, lon: -0.0833),
  FamousCity(name: 'New York', lat: 40.7167, lon: -74.0167),
  FamousCity(name: 'Tehran', lat: 35.6833, lon: 51.4167),
];
