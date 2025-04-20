import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final String key = 'theme_mode';
  late SharedPreferences _prefs;
  late ThemeMode _themeMode;
  
  // Getter for current theme mode
  ThemeMode get themeMode => _themeMode;
  
  // Constructor initializes with default theme
  ThemeProvider() {
    _themeMode = ThemeMode.light;
    _loadFromPrefs();
  }
  
  // Toggle between light and dark theme
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveToPrefs();
    notifyListeners();
  }
  
  // Initialize and load saved theme preference
  _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  _loadFromPrefs() async {
    await _initPrefs();
    final themeIndex = _prefs.getInt(key) ?? 1; // Default to light theme
    _themeMode = ThemeMode.values[themeIndex];
    notifyListeners();
  }
  
  _saveToPrefs() async {
    await _initPrefs();
    await _prefs.setInt(key, _themeMode.index);
  }
  
  // Check if current theme is dark
  bool isDarkMode() {
    return _themeMode == ThemeMode.dark;
  }
}