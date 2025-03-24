import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:language_app/locale_provider.dart'; // Import file provider
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import file sinh ra

// Trang cài đặt chính
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
          _buildSectionTitle(l10n.profileInfo, pix),
          _buildSettingItem(
            icon: Icons.person,
            title: l10n.profileInfo,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileSettingsScreen()));
            },
            pix: pix,
          ),
          _buildSettingItem(
            icon: Icons.logout,
            title: l10n.logout,
            color: Colors.red,
            onTap: () {
              _showLogoutDialog(context);
            },
            pix: pix,
          ),
          SizedBox(height: 20 * pix),

          _buildSectionTitle(l10n.courses, pix),
          _buildSettingItem(
            icon: Icons.language,
            title: l10n.language,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageSettingsScreen()));
            },
            pix: pix,
          ),
          _buildSettingItem(
            icon: Icons.book,
            title: l10n.courses,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CourseSettingsScreen()));
            },
            pix: pix,
          ),
          _buildSettingItem(
            icon: Icons.flag,
            title: l10n.learningGoals,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const GoalSettingsScreen()));
            },
            pix: pix,
          ),
          SizedBox(height: 20 * pix),

          _buildSectionTitle(l10n.theme, pix),
          _buildSettingItem(
            icon: Icons.brightness_6,
            title: l10n.theme,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ThemeSettingsScreen()));
            },
            pix: pix,
          ),
          _buildSettingItem(
            icon: Icons.volume_up,
            title: l10n.sound,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SoundSettingsScreen()));
            },
            pix: pix,
          ),
          _buildSettingItem(
            icon: Icons.notifications,
            title: l10n.notifications,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationSettingsScreen()));
            },
            pix: pix,
          ),
          SizedBox(height: 20 * pix),

          _buildSectionTitle(l10n.support, pix),
          _buildSettingItem(
            icon: Icons.help,
            title: l10n.support,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SupportScreen()));
            },
            pix: pix,
          ),
          _buildSettingItem(
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

  Widget _buildSectionTitle(String title, double pix) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8 * pix),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18 * pix,
          fontFamily: 'BeVietnamPro',
          fontWeight: FontWeight.bold,
          color: const Color(0xff5B7BFE),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required double pix,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, size: 24 * pix, color: color ?? Colors.grey),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16 * pix,
          fontFamily: 'BeVietnamPro',
          color: color ?? Colors.black,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16 * pix, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.areYouSureLogout), // Chuỗi đã dịch
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel), // Chuỗi đã dịch
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text(
              l10n.agree, // Chuỗi đã dịch
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

// Trang cài đặt ngôn ngữ ứng dụng
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

// Các trang con với localization
class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pix = MediaQuery.of(context).size.width / 375;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileInfo)),
      body: ListView(
        padding: EdgeInsets.all(16 * pix),
        children: [
          _buildSubItem(l10n.avatar, Icons.account_circle, pix), // "Ảnh đại diện"
          _buildSubItem(l10n.username, Icons.person, pix), // "Tên người dùng"
          _buildSubItem(l10n.loginName, Icons.login, pix), // "Tên đăng nhập"
          _buildSubItem(l10n.password, Icons.lock, pix), // "Mật khẩu"
          _buildSubItem(l10n.email, Icons.email, pix), // "Email"
          _buildSubItem(l10n.deleteAccount, Icons.delete_forever, pix, color: Colors.red), // "Xóa tài khoản"
        ],
      ),
    );
  }
}

class CourseSettingsScreen extends StatelessWidget {
  const CourseSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pix = MediaQuery.of(context).size.width / 375;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.courses)),
      body: ListView(
        padding: EdgeInsets.all(16 * pix),
        children: [
          _buildSubItem(l10n.addCourse, Icons.add_circle, pix), // "Thêm khóa học"
          _buildSubItem(l10n.removeCourse, Icons.remove_circle, pix), // "Xóa khóa học"
        ],
      ),
    );
  }
}

class GoalSettingsScreen extends StatelessWidget {
  const GoalSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.learningGoals)),
      body: Center(child: Text(l10n.goalsUnderDevelopment)), // "Trang cài đặt mục tiêu học tập (đang phát triển)"
    );
  }
}

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.theme)),
      body: Center(child: Text(l10n.themeUnderDevelopment)), // "Trang cài đặt chủ đề (đang phát triển)"
    );
  }
}

class SoundSettingsScreen extends StatelessWidget {
  const SoundSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.sound)),
      body: Center(child: Text(l10n.soundUnderDevelopment)), // "Trang cài đặt âm thanh (đang phát triển)"
    );
  }
}

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.notifications)),
      body: Center(child: Text(l10n.notificationsUnderDevelopment)), // "Trang cài đặt thông báo (đang phát triển)"
    );
  }
}

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.support)),
      body: Center(child: Text(l10n.supportUnderDevelopment)), // "Trang hỗ trợ (đang phát triển)"
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.about)),
      body: Center(child: Text(l10n.aboutUnderDevelopment)), // "Trang thông tin ứng dụng (đang phát triển)"
    );
  }
}

Widget _buildSubItem(String title, IconData icon, double pix, {Color? color}) {
  return ListTile(
    leading: Icon(icon, size: 24 * pix, color: color ?? Colors.grey),
    title: Text(
      title,
      style: TextStyle(
        fontSize: 16 * pix,
        fontFamily: 'BeVietnamPro',
        color: color ?? Colors.black,
      ),
    ),
    onTap: () {
      // Logic xử lý từng mục (có thể thêm sau)
    },
  );
}
