import 'package:flutter/material.dart';

import '../themes/dark_theme.dart';
import '../themes/light_theme.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData get themeData {
    return _isDarkMode ? darkTheme : lightTheme;
  }

  // Örnek Kullanım : Provider.of<ThemeProvider>(context).toggleTheme();
}
