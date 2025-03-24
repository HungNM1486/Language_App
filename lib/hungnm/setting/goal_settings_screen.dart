import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GoalSettingsScreen extends StatelessWidget {
  const GoalSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.learningGoals)),
      body: Center(child: Text(l10n.goalsUnderDevelopment)),
    );
  }
}