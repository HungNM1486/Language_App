import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:language_app/hungnm/profile.dart'; // Import ProfileScreen

class GoalCompletionScreen extends StatelessWidget {
  final String goal;
  final String time;
  final String studyTime;

  const GoalCompletionScreen({
    super.key,
    required this.goal,
    required this.time,
    required this.studyTime,
  });

  // Chuyển đổi giá trị sang chuỗi dịch
  String _getGoalText(AppLocalizations l10n) {
    switch (goal) {
      case 'basic':
        return l10n.basic;
      case 'advanced':
        return l10n.advanced;
      case 'expert':
        return l10n.expert;
      default:
        return l10n.basic;
    }
  }

  String _getTimeText(AppLocalizations l10n) {
    switch (time) {
      case '1month':
        return l10n.oneMonth;
      case '3months':
        return l10n.threeMonths;
      case '6months':
        return l10n.sixMonths;
      default:
        return l10n.oneMonth;
    }
  }

  String _getStudyTimeText(AppLocalizations l10n) {
    switch (studyTime) {
      case 'breakfast':
        return l10n.breakfast;
      case 'commuting':
        return l10n.commuting;
      case 'lunch':
        return l10n.lunch;
      case 'dinner':
        return l10n.dinner;
      default:
        return l10n.breakfast;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pix = MediaQuery.of(context).size.width / 375;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.goalCompletion),
        backgroundColor: const Color(0xff5B7BFE),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * pix),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20 * pix),
            Icon(
              Icons.celebration,
              size: 60 * pix,
              color: const Color(0xff5B7BFE),
            ),
            SizedBox(height: 16 * pix),
            Text(
              l10n.congratulations,
              style: TextStyle(
                fontSize: 24 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: const Color(0xff5B7BFE),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12 * pix),
            Text(
              l10n.goalSetSuccess,
              style: TextStyle(
                fontSize: 16 * pix,
                fontFamily: 'BeVietnamPro',
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24 * pix),
            Text(
              l10n.goalOverview,
              style: TextStyle(
                fontSize: 18 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: const Color(0xff5B7BFE),
              ),
            ),
            SizedBox(height: 16 * pix),
            _buildOverviewItem(l10n.goalLabel, _getGoalText(l10n), pix),
            _buildOverviewItem(l10n.timeLabel, _getTimeText(l10n), pix),
            _buildOverviewItem(
                l10n.studyTimeLabel, _getStudyTimeText(l10n), pix),
            SizedBox(height: 24 * pix),
            ElevatedButton(
              onPressed: () {
                // Chuyển về trang cá nhân
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                  (route) => false, // Xóa toàn bộ stack, chỉ giữ ProfileScreen
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff5B7BFE),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8 * pix)),
                padding: EdgeInsets.symmetric(
                    vertical: 12 * pix, horizontal: 24 * pix),
              ),
              child: Text(
                l10n.finishButton,
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

  Widget _buildOverviewItem(String label, String value, double pix) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8 * pix),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 16 * pix,
                fontFamily: 'BeVietnamPro',
                color: Colors.grey[600]),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 16 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
