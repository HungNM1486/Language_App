import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:language_app/main.dart'; // Import để dùng ThemeProvider

class ThemeSettingsScreen extends StatefulWidget {
  const ThemeSettingsScreen({super.key});

  @override
  State<ThemeSettingsScreen> createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  late ThemeMode _selectedTheme;

  @override
  void initState() {
    super.initState();
    _loadTheme(); // Tải theme từ SharedPreferences
  }

  // Tải theme từ SharedPreferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('theme_mode') ?? 'light';
    setState(() {
      _selectedTheme = _themeModeFromString(themeString);
    });
  }

  // Lưu theme vào SharedPreferences và cập nhật ThemeProvider
  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', _themeModeToString(mode));
    Provider.of<ThemeProvider>(context, listen: false).setTheme(mode);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã lưu cài đặt giao diện')),
    );
  }

  // Chuyển đổi chuỗi thành ThemeMode
  ThemeMode _themeModeFromString(String mode) {
    switch (mode) {
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      case 'light':
      default:
        return ThemeMode.light;
    }
  }

  // Chuyển đổi ThemeMode thành chuỗi
  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
      case ThemeMode.light:
      default:
        return 'light';
    }
  }

  @override
  Widget build(BuildContext context) {
    final pix = MediaQuery.of(context).size.width / 375;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.theme),
        backgroundColor: const Color(0xff5B7BFE),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * pix),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chọn giao diện',
              style: TextStyle(
                fontSize: 18 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: const Color(0xff5B7BFE),
              ),
            ),
            SizedBox(height: 16 * pix),

            // Theme sáng
            RadioListTile<ThemeMode>(
              title: Text(
                'Sáng',
                style:
                    TextStyle(fontSize: 16 * pix, fontFamily: 'BeVietnamPro'),
              ),
              value: ThemeMode.light,
              groupValue: _selectedTheme,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedTheme = value;
                  });
                  _saveTheme(value);
                }
              },
            ),

            // Theme tối
            RadioListTile<ThemeMode>(
              title: Text(
                'Tối',
                style:
                    TextStyle(fontSize: 16 * pix, fontFamily: 'BeVietnamPro'),
              ),
              value: ThemeMode.dark,
              groupValue: _selectedTheme,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedTheme = value;
                  });
                  _saveTheme(value);
                }
              },
            ),

            // Theme theo hệ thống
            RadioListTile<ThemeMode>(
              title: Text(
                'Theo hệ thống',
                style:
                    TextStyle(fontSize: 16 * pix, fontFamily: 'BeVietnamPro'),
              ),
              value: ThemeMode.system,
              groupValue: _selectedTheme,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedTheme = value;
                  });
                  _saveTheme(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
