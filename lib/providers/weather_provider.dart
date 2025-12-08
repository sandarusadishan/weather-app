import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String? _error;
  List<String> _favorites = [];

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<String> get favorites => _favorites;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _weather = await WeatherService().getWeather(city);
    } catch (e) {
      _error = "City not found. Please check spelling.";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList('favorites') ?? [];
    notifyListeners();
  }

  void addFavorite(String city) async {
    if (!_favorites.contains(city)) {
      _favorites.add(city);
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('favorites', _favorites);
      notifyListeners();
    }
  }

  void removeFavorite(String city) async {
    _favorites.remove(city);
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favorites);
    notifyListeners();
  }
}