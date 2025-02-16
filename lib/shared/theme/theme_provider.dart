import 'package:flutter/material.dart';
import 'package:student_pal/shared/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool _isSelected = false;
  bool get isSelected => _isSelected;
  ThemeData _themeData = AppTheme.lightMode;
  ThemeData get themeData => _themeData;
  void toggleTheme() {
    if (_themeData == AppTheme.lightMode) {
      _themeData = AppTheme.darkMode;
    } else {
      _themeData = AppTheme.lightMode;
    }
    _isSelected = !_isSelected;
    notifyListeners();
  }
}
