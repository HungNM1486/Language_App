import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showLogoutDialog(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.logout),
      content: Text(l10n.areYouSureLogout),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: Text(
            l10n.agree,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}