import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:language_app/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String _selectedLanguage = 'Tiếng Việt';

  final List<String> _languages = [
    'Tiếng Việt',
    'English',
  ];

  @override
  Widget build(BuildContext context) {
    final pix = MediaQuery.of(context).size.width / 375;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.language),
        backgroundColor: const Color(0xff5B7BFE),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * pix),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectAppLanguage,
              style: TextStyle(
                fontSize: 18 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20 * pix),
            DropdownButton<String>(
              value: _selectedLanguage,
              isExpanded: true,
              items: _languages.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(
                    language,
                    style: TextStyle(
                      fontSize: 16 * pix,
                      fontFamily: 'BeVietnamPro',
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                  Provider.of<LocaleProvider>(context, listen: false).setLocale(newValue);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đã chọn: $newValue')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
