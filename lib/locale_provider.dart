import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('vi', 'VN'); // Mặc định là Tiếng Việt

  Locale get locale => _locale;

  void setLocale(String language) {
    if (language == 'English') {
      _locale = const Locale('en', 'US');
    } else {
      _locale = const Locale('vi', 'VN');
    }
    notifyListeners(); // Cập nhật giao diện
  }
}
