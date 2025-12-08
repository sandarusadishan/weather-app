import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive_center.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("My Cities", style: AppTheme.titleLarge.copyWith(fontSize: 20)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Stack(
          children: [
             // Background Orb
            Positioned(
              top: 100,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.accentColor.withOpacity(0.2),
                  boxShadow: [
                    BoxShadow(color: AppTheme.accentColor.withOpacity(0.2), blurRadius: 100, spreadRadius: 50)
                  ],
                ),
              ),
            ),
            
            Consumer<WeatherProvider>(
              builder: (context, provider, child) {
                if (provider.favorites.isEmpty) {
                  return Center(child: Text("No favorites yet.", style: AppTheme.bodyLarge));
                }
                return ResponsiveCenter(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 100),
                    physics: const BouncingScrollPhysics(),
                    itemCount: provider.favorites.length,
                    itemBuilder: (context, index) {
                      final city = provider.favorites[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Dismissible(
                          key: Key(city),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) => provider.removeFavorite(city),
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: GlassContainer(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(city, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                              trailing: const Icon(Icons.arrow_forward_ios, color: AppTheme.accentColor, size: 16),
                              onTap: () {
                                provider.fetchWeather(city);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}