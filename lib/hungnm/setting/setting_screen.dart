import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:language_app/hungnm/setting/language_settings_screen.dart';
import 'package:language_app/hungnm/setting/profile_settings_screen.dart';
import 'package:language_app/hungnm/setting/course_settings_screen.dart';
import 'package:language_app/hungnm/setting/goal/goal_settings_screen.dart';
import 'package:language_app/hungnm/setting/theme_settings_screen.dart';
import 'package:language_app/hungnm/setting/sound_settings_screen.dart';
import 'package:language_app/hungnm/setting/notification_settings_screen.dart';
import 'package:language_app/hungnm/setting/support_screen.dart';
import 'package:language_app/hungnm/setting/about_screen.dart';
import 'package:language_app/hungnm/setting/widgets/section_title.dart';
import 'package:language_app/hungnm/setting/widgets/setting_item.dart';
import 'package:language_app/hungnm/setting/widgets/logout_dialog.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = (size.width / 375).clamp(0.8, 1.2);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: const Color(0xff5B7BFE),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16 * pix),
        children: [
          SectionTitle(title: l10n.profileInfo, pix: pix),
          SettingItem(
            icon: Icons.person,
            title: l10n.profileInfo,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileSettingsScreen()));
            },
            pix: pix,
          ),
          SettingItem(
            icon: Icons.logout,
            title: l10n.logout,
            color: Colors.red,
            onTap: () => showLogoutDialog(context),
            pix: pix,
          ),
          SizedBox(height: 20 * pix),

          SectionTitle(title: l10n.courses, pix: pix),
          SettingItem(
            icon: Icons.language,
            title: l10n.language,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageSettingsScreen()));
            },
            pix: pix,
          ),
          SettingItem(
            icon: Icons.book,
            title: l10n.courses,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CourseSettingsScreen()));
            },
            pix: pix,
          ),
          SettingItem(
            icon: Icons.flag,
            title: l10n.learningGoals,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const GoalSettingsScreen()));
            },
            pix: pix,
          ),
          SizedBox(height: 20 * pix),

          SectionTitle(title: l10n.theme, pix: pix),
          SettingItem(
            icon: Icons.brightness_6,
            title: l10n.theme,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ThemeSettingsScreen()));
            },
            pix: pix,
          ),
          SettingItem(
            icon: Icons.volume_up,
            title: l10n.sound,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SoundSettingsScreen()));
            },
            pix: pix,
          ),
          SettingItem(
            icon: Icons.notifications,
            title: l10n.notifications,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationSettingsScreen()));
            },
            pix: pix,
          ),
          SizedBox(height: 20 * pix),

          SectionTitle(title: l10n.support, pix: pix),
          SettingItem(
            icon: Icons.help,
            title: l10n.support,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SupportScreen()));
            },
            pix: pix,
          ),
          SettingItem(
            icon: Icons.info,
            title: l10n.about,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
            },
            pix: pix,
          ),
        ],
      ),
    );
  }
}
