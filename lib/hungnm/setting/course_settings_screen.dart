import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:language_app/hungnm/setting/widgets/sub_item.dart';

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
          SubItem(title: l10n.addCourse, icon: Icons.add_circle, pix: pix),
          SubItem(title: l10n.removeCourse, icon: Icons.remove_circle, pix: pix),
        ],
      ),
    );
  }
}