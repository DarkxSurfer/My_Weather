import 'package:flutter/material.dart';
import 'package:my_weather/src/screens/weather_detail_screen.dart';

import '../models/famous_city.dart';
import '../services/weather_service.dart';
import '../views/famous_cities_weather.dart';
import '../widgets/city_weather_tile.dart';
import '/src/constants/app_colors.dart';
import '/src/constants/text_styles.dart';
import '/src/views/gradient_container.dart';
import '/src/widgets/round_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  List<FamousCity> _cities = List.from(famousCities); // Copy of famous cities
  bool _isLoading = false;

  Future<void> _searchCityWeather() async {
    final cityName = _searchController.text.trim();
    if (cityName.isEmpty) return;

    setState(() {
      _isLoading = true; // Show loading spinner while fetching data
    });

    final weatherData = await _weatherService.fetchWeather(cityName);

    if (weatherData != null) {
      final newCity = FamousCity(
        name: weatherData['name'],
        lat: weatherData['coord']['lat'],
        lon: weatherData['coord']['lon'],
        temperature: weatherData['main']['temp'],
        weatherDescription: weatherData['weather'][0]['description'],
      );

      setState(() {
        _cities.add(newCity); // Add the new city with real-time weather
        _isLoading = false; // Hide loading spinner
      });
    } else {
      setState(() {
        _isLoading = false; // Hide loading spinner even if there's an error
      });

      // Optionally show an error dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('City not found')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text('Pick Location', style: TextStyles.h1),
        ),
        const SizedBox(height: 20),
        const Text(
          'Find the area or city that you want to know the detailed weather info at this time',
          style: TextStyles.subtitleText,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: RoundTextField(
                controller: _searchController,
                onSubmitted: (_) => _searchCityWeather(),
                // Trigger search on Enter
              ),
            ),
            const SizedBox(width: 15),
            LocationIcon(
              onTap: () {
                _searchController.clear();
                setState(() {
                  _cities = List.from(famousCities);
                  // Reset to famous cities on clear
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 30),
        _isLoading
            ? const Center(
                child: CircularProgressIndicator()) // Show loading indicator
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _cities.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final city = _cities[index];

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
              ),
      ],
    );
  }
}

// ignore: must_be_immutable
class LocationIcon extends StatefulWidget {
  const LocationIcon({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  State<LocationIcon> createState() => _LocationIconState();
}

class _LocationIconState extends State<LocationIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: AppColors.accentBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.location_on_outlined,
          color: AppColors.grey,
        ),
      ),
    );
  }
}
