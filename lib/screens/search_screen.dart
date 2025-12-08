import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive_center.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController cityController = TextEditingController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white)),
        title: Text("Search Location", style: AppTheme.titleLarge.copyWith(fontSize: 20)),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: ResponsiveCenter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  GlassContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      controller: cityController,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                        hintText: "Enter City Name...",
                        hintStyle: const TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        icon: const Icon(Icons.search, color: Colors.white54),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, color: AppTheme.accentColor, size: 20),
                          onPressed: () {
                            if (cityController.text.isNotEmpty) {
                              Provider.of<WeatherProvider>(context, listen: false).fetchWeather(cityController.text);
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          Provider.of<WeatherProvider>(context, listen: false).fetchWeather(value);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Add some suggestion chips or recent searches if logic existed, but for now just the design
                  const Text("Popular Cities", style: TextStyle(color: Colors.white54, fontSize: 14)),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildCityChip(context, "London"),
                      _buildCityChip(context, "New York"),
                      _buildCityChip(context, "Tokyo"),
                      _buildCityChip(context, "Dubai"),
                      _buildCityChip(context, "Colombo"),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCityChip(BuildContext context, String city) {
    return GestureDetector(
      onTap: () {
         Provider.of<WeatherProvider>(context, listen: false).fetchWeather(city);
         Navigator.pop(context);
      },
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        borderRadius: 30,
        child: Text(city, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}