import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:language_app/hungnm/setting/goal/goal_completion_screen.dart'; // Import trang mới

class StudyTimeScreen extends StatefulWidget {
  final String goal;
  final String time;

  const StudyTimeScreen({super.key, required this.goal, required this.time});

  @override
  State<StudyTimeScreen> createState() => _StudyTimeScreenState();
}

class _StudyTimeScreenState extends State<StudyTimeScreen> {
  String _selectedStudyTime = 'breakfast';

  @override
  void initState() {
    super.initState();
    _loadStudyTime();
  }

  Future<void> _loadStudyTime() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedStudyTime =
          prefs.getString('study_time_${widget.goal}') ?? 'breakfast';
    });
  }

  Future<void> _saveStudyTimeAndContinue(String studyTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('study_time_${widget.goal}', studyTime);
    setState(() {
      _selectedStudyTime = studyTime;
    });
    // Chuyển sang trang hoàn thành
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoalCompletionScreen(
          goal: widget.goal,
          time: widget.time,
          studyTime: studyTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pix = MediaQuery.of(context).size.width / 375;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.studyTime),
        backgroundColor: const Color(0xff5B7BFE),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * pix),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectStudyTime,
              style: TextStyle(
                fontSize: 18 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: const Color(0xff5B7BFE),
              ),
            ),
            SizedBox(height: 16 * pix),
            _buildOption(
                l10n.breakfast, 'breakfast', Icons.free_breakfast, pix, l10n),
            SizedBox(height: 12 * pix),
            _buildOption(
                l10n.commuting, 'commuting', Icons.directions_bus, pix, l10n),
            SizedBox(height: 12 * pix),
            _buildOption(l10n.lunch, 'lunch', Icons.lunch_dining, pix, l10n),
            SizedBox(height: 12 * pix),
            _buildOption(l10n.dinner, 'dinner', Icons.dinner_dining, pix, l10n),
            SizedBox(height: 24 * pix),
            ElevatedButton(
              onPressed: () => _saveStudyTimeAndContinue(_selectedStudyTime),
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

  Widget _buildOption(String title, String value, IconData icon, double pix,
      AppLocalizations l10n) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStudyTime = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(12 * pix),
        decoration: BoxDecoration(
          border: Border.all(
              color: _selectedStudyTime == value
                  ? const Color(0xff5B7BFE)
                  : Colors.grey),
          borderRadius: BorderRadius.circular(12 * pix),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16 * pix,
                  fontFamily: 'BeVietnamPro',
                  color: _selectedStudyTime == value
                      ? const Color(0xff5B7BFE)
                      : Colors.black,
                ),
              ),
            ),
            CircleAvatar(
              radius: 16 * pix,
              backgroundColor: _selectedStudyTime == value
                  ? const Color(0xff5B7BFE)
                  : Colors.grey[300],
              child: Icon(
                icon,
                size: 20 * pix,
                color:
                    _selectedStudyTime == value ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
