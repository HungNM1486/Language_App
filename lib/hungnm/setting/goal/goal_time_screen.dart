import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:language_app/hungnm/setting/goal/study_time_screen.dart'; // Import trang mới

class GoalTimeScreen extends StatefulWidget {
  final String goal;

  const GoalTimeScreen({super.key, required this.goal});

  @override
  State<GoalTimeScreen> createState() => _GoalTimeScreenState();
}

class _GoalTimeScreenState extends State<GoalTimeScreen> {
  String _selectedTime = '1month';

  @override
  void initState() {
    super.initState();
    _loadTime();
  }

  Future<void> _loadTime() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedTime = prefs.getString('goal_time_${widget.goal}') ?? '1month';
    });
  }

  Future<void> _saveTimeAndContinue(String time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('goal_time_${widget.goal}', time);
    setState(() {
      _selectedTime = time;
    });
    // Chuyển sang trang chọn thời gian học
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StudyTimeScreen(goal: widget.goal, time: time)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pix = MediaQuery.of(context).size.width / 375;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.goalTime),
        backgroundColor: const Color(0xff5B7BFE),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * pix),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectGoalTime,
              style: TextStyle(
                fontSize: 18 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: const Color(0xff5B7BFE),
              ),
            ),
            SizedBox(height: 16 * pix),
            RadioListTile<String>(
              title: Text(l10n.oneMonth,
                  style: TextStyle(
                      fontSize: 16 * pix, fontFamily: 'BeVietnamPro')),
              subtitle: Text(l10n.oneMonthDesc,
                  style: TextStyle(
                      fontSize: 12 * pix,
                      fontFamily: 'BeVietnamPro',
                      color: Colors.grey[600])),
              value: '1month',
              groupValue: _selectedTime,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedTime = value;
                  });
                }
              },
            ),
            RadioListTile<String>(
              title: Text(l10n.threeMonths,
                  style: TextStyle(
                      fontSize: 16 * pix, fontFamily: 'BeVietnamPro')),
              subtitle: Text(l10n.threeMonthsDesc,
                  style: TextStyle(
                      fontSize: 12 * pix,
                      fontFamily: 'BeVietnamPro',
                      color: Colors.grey[600])),
              value: '3months',
              groupValue: _selectedTime,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedTime = value;
                  });
                }
              },
            ),
            RadioListTile<String>(
              title: Text(l10n.sixMonths,
                  style: TextStyle(
                      fontSize: 16 * pix, fontFamily: 'BeVietnamPro')),
              subtitle: Text(l10n.sixMonthsDesc,
                  style: TextStyle(
                      fontSize: 12 * pix,
                      fontFamily: 'BeVietnamPro',
                      color: Colors.grey[600])),
              value: '6months',
              groupValue: _selectedTime,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedTime = value;
                  });
                }
              },
            ),
            SizedBox(height: 24 * pix),
            ElevatedButton(
              onPressed: () => _saveTimeAndContinue(_selectedTime),
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
