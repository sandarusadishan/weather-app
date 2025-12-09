import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../utils/app_theme.dart'; // Ensure this file exists
import '../widgets/glass_container.dart'; // Ensure this file exists
import '../widgets/responsive_center.dart'; // Ensure this file exists
import 'search_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(context, listen: false).fetchWeather("Colombo");
      Provider.of<WeatherProvider>(context, listen: false).loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherProv = Provider.of<WeatherProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.grid_view_rounded, color: AppTheme.darkText),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen())),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: AppTheme.darkText),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
          ),
        ],
        title: Text(
          weatherProv.weather?.cityName ?? "Weather", 
          style: AppTheme.titleLarge.copyWith(fontSize: 20)
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          // Ensure AppTheme has backgroundGradient defined
          gradient: AppTheme.backgroundGradient, 
        ),
        child: Stack(
          children: [

            SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  if (weatherProv.weather != null) {
                    await weatherProv.fetchWeather(weatherProv.weather!.cityName);
                  }
                },
                color: AppTheme.primaryColor,
                child: weatherProv.isLoading
                    ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor))
                    : weatherProv.error != null
                        ? Center(child: Text(weatherProv.error!, style: AppTheme.bodyLarge))
                        : ResponsiveCenter(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20), 
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 10),
                                  
                                  // Weather Icon Animation
                                  TweenAnimationBuilder(
                                    tween: Tween<double>(begin: 0, end: 1),
                                    duration: const Duration(seconds: 1),
                                    builder: (context, double value, child) {
                                      return Opacity(
                                        opacity: value,
                                        child: Transform.translate(
                                          offset: Offset(0, 30 * (1 - value)),
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          // White Glow behind the image
                                          Container(
                                            width: 180, height: 180,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(color: Colors.white.withOpacity(0.8), blurRadius: 100, spreadRadius: -10),
                                              ],
                                            ),
                                          ),
                                          if (weatherProv.weather != null)
                                            Image.network(
                                              'https://openweathermap.org/img/wn/${weatherProv.weather!.iconCode}@4x.png',
                                              width: 180,
                                              height: 180,
                                              fit: BoxFit.contain,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Temperature
                                  Column(
                                    children: [
                                      Text(
                                        "${weatherProv.weather?.temperature.toStringAsFixed(0)}°", 
                                        style: AppTheme.displayLarge.copyWith(fontSize: 100, height: 1, color: AppTheme.darkText, shadows: [
                                          Shadow(color: Colors.black.withOpacity(0.1), offset: const Offset(2, 2), blurRadius: 4)
                                        ]),
                                      ),
                                      Text(
                                        weatherProv.weather?.description.toUpperCase() ?? "",
                                        style: AppTheme.titleLarge.copyWith(fontSize: 20, color: AppTheme.darkText.withOpacity(0.7)),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 30),

                                  // Info Grid
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildInfoCard(Icons.air, "${weatherProv.weather?.windSpeed} km/h", "Wind"),
                                      _buildInfoCard(Icons.water_drop_outlined, "${weatherProv.weather?.humidity}%", "Humidity"),
                                      _buildInfoCard(Icons.thermostat, "${weatherProv.weather?.temperature.toStringAsFixed(0)}°", "Feels Like"),
                                    ],
                                  ),

                                  const SizedBox(height: 30),

                                  // Hourly Forecast Section
                                  GlassContainer(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    color: Colors.white,
                                    opacity: 0.4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Hourly Forecast", style: AppTheme.titleLarge.copyWith(fontSize: 18)),
                                            Text("See All", style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          height: 120,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            physics: const BouncingScrollPhysics(),
                                            children: [
                                              _buildHourlyItem("Now", weatherProv.weather?.iconCode ?? "01d", "${weatherProv.weather?.temperature.toStringAsFixed(0)}°", isActive: true),
                                              _buildHourlyItem("10:00", "01d", "29°"),
                                              _buildHourlyItem("11:00", "02d", "30°"),
                                              _buildHourlyItem("12:00", "03d", "31°"),
                                              _buildHourlyItem("13:00", "09d", "28°"),
                                              _buildHourlyItem("14:00", "11d", "27°"),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 120), // Spacer for FAB
                                ],
                              ),
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(weatherProv.weather != null) {
            weatherProv.addFavorite(weatherProv.weather!.cityName);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Added to Favorites!")));
          }
        },
        backgroundColor: AppTheme.darkText,
        child: const Icon(Icons.favorite, color: Colors.red),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String value, String title) {
    return GlassContainer(
      width: 100,
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.white,
      opacity: 0.4, // Light glass
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppTheme.darkText, size: 30),
          const SizedBox(height: 10),
          Text(value, style: AppTheme.bodyLarge.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.darkText)),
          Text(title, style: AppTheme.bodyMedium.copyWith(fontSize: 12, color: AppTheme.darkText.withOpacity(0.6))),
        ],
      ),
    );
  }

  Widget _buildHourlyItem(String time, String iconCode, String temp, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: isActive 
        ? BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 5))],
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
          )
        : BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.3),
            border: Border.all(color: AppTheme.primaryColor.withOpacity(0.5), width: 1.5), // Electric Blue Border (Restored)
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(time, style: TextStyle(color: isActive ? Colors.white : AppTheme.darkText, fontSize: 12)),
          Image.network('https://openweathermap.org/img/wn/$iconCode.png', width: 40, height: 40),
          Text(temp, style: TextStyle(color: isActive ? Colors.white : AppTheme.darkText, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}