import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:language_app/hungnm/setting/goal/goal_time_screen.dart'; // Import trang mới

class GoalSettingsScreen extends StatefulWidget {
  const GoalSettingsScreen({super.key});

  @override
  State<GoalSettingsScreen> createState() => _GoalSettingsScreenState();
}

class _GoalSettingsScreenState extends State<GoalSettingsScreen> {
  String _selectedGoal = 'basic';

  @override
  void initState() {
    super.initState();
    _loadGoal();
  }

  Future<void> _loadGoal() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedGoal = prefs.getString('learning_goal') ?? 'basic';
    });
  }

  Future<void> _saveGoalAndContinue(String goal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('learning_goal', goal);
    setState(() {
      _selectedGoal = goal;
    });
    // Chuyển sang trang chọn thời gian
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GoalTimeScreen(goal: goal)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pix = MediaQuery.of(context).size.width / 375;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.learningGoals),
        backgroundColor: const Color(0xff5B7BFE),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * pix),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectGoal,
              style: TextStyle(
                fontSize: 18 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: const Color(0xff5B7BFE),
              ),
            ),
            SizedBox(height: 16 * pix),
            RadioListTile<String>(
              title: Text(l10n.basic,
                  style: TextStyle(
                      fontSize: 16 * pix, fontFamily: 'BeVietnamPro')),
              subtitle: Text(l10n.basicDesc,
                  style: TextStyle(
                      fontSize: 12 * pix,
                      fontFamily: 'BeVietnamPro',
                      color: Colors.grey[600])),
              value: 'basic',
              groupValue: _selectedGoal,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedGoal = value;
                  });
                }
              },
            ),
            RadioListTile<String>(
              title: Text(l10n.advanced,
                  style: TextStyle(
                      fontSize: 16 * pix, fontFamily: 'BeVietnamPro')),
              subtitle: Text(l10n.advancedDesc,
                  style: TextStyle(
                      fontSize: 12 * pix,
                      fontFamily: 'BeVietnamPro',
                      color: Colors.grey[600])),
              value: 'advanced',
              groupValue: _selectedGoal,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedGoal = value;
                  });
                }
              },
            ),
            RadioListTile<String>(
              title: Text(l10n.expert,
                  style: TextStyle(
                      fontSize: 16 * pix, fontFamily: 'BeVietnamPro')),
              subtitle: Text(l10n.expertDesc,
                  style: TextStyle(
                      fontSize: 12 * pix,
                      fontFamily: 'BeVietnamPro',
                      color: Colors.grey[600])),
              value: 'expert',
              groupValue: _selectedGoal,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedGoal = value;
                  });
                }
              },
            ),
            SizedBox(height: 24 * pix),
            ElevatedButton(
              onPressed: () => _saveGoalAndContinue(_selectedGoal),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff5B7BFE),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8 * pix)),
                padding: EdgeInsets.symmetric(vertical: 12 * pix),
              ),
              child: Text(
                l10n.continueButton,
                style: TextStyle(
                    fontSize: 16 * pix,
                    fontFamily: 'BeVietnamPro',
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
