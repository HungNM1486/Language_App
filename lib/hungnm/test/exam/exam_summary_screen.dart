import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExamSummaryScreen extends StatelessWidget {
  final String examName;
  final Map<String, dynamic> results;

  const ExamSummaryScreen({
    super.key,
    required this.examName,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final totalScore = _calculateTotalScore();

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDarkMode
                  ? [const Color(0xFF1E1E2F), const Color(0xFF121212)]
                  : [const Color(0xFFF8FAFC), const Color(0xFFEFF6FF)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button
              Padding(
                padding: EdgeInsets.fromLTRB(24 * pix, 16 * pix, 24 * pix, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded,
                          color: isDarkMode
                              ? Colors.white
                              : const Color(0xFF1E293B)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    Text(
                      'Exam Summary',
                      style: TextStyle(
                        fontSize: 18 * pix,
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w600,
                        color:
                            isDarkMode ? Colors.white : const Color(0xFF1E293B),
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48), // For balance
                  ],
                ),
              ),

              // Main content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24 * pix),
                  child: Column(
                    children: [
                      SizedBox(height: 16 * pix),

                      // Congratulations card with score
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24 * pix),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color(0xFF1E1E2F)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16 * pix),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/images/celebration.svg',
                              height: 80 * pix,
                              color: const Color(0xFF4F46E5),
                            ),
                            SizedBox(height: 16 * pix),
                            Text(
                              'Congratulations!',
                              style: TextStyle(
                                fontSize: 24 * pix,
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w700,
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color(0xFF1E293B),
                              ),
                            ),
                            SizedBox(height: 8 * pix),
                            Text(
                              'You completed "$examName"',
                              style: TextStyle(
                                fontSize: 16 * pix,
                                fontFamily: 'BeVietnamPro',
                                color: isDarkMode
                                    ? Colors.grey[400]
                                    : const Color(0xFF64748B),
                              ),
                            ),
                            SizedBox(height: 24 * pix),

                            // Score circle
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 120 * pix,
                                  height: 120 * pix,
                                  child: CircularProgressIndicator(
                                    value: totalScore / 100,
                                    strokeWidth: 10,
                                    backgroundColor: isDarkMode
                                        ? Colors.grey[800]
                                        : Colors.grey[200],
                                    color: _getScoreColor(totalScore),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '$totalScore',
                                      style: TextStyle(
                                        fontSize: 32 * pix,
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w700,
                                        color: isDarkMode
                                            ? Colors.white
                                            : const Color(0xFF1E293B),
                                      ),
                                    ),
                                    Text(
                                      'Total Score',
                                      style: TextStyle(
                                        fontSize: 14 * pix,
                                        fontFamily: 'BeVietnamPro',
                                        color: isDarkMode
                                            ? Colors.grey[400]
                                            : const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24 * pix),

                      // Skills breakdown title
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Skills Breakdown',
                          style: TextStyle(
                            fontSize: 20 * pix,
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xFF1E293B),
                          ),
                        ),
                      ),

                      SizedBox(height: 16 * pix),

                      // Skills grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16 * pix,
                        mainAxisSpacing: 16 * pix,
                        childAspectRatio: 1.2,
                        children: [
                          _buildSkillCard(
                            pix: pix,
                            isDarkMode: isDarkMode,
                            title: 'Listening',
                            icon: Icons.headphones_rounded,
                            data: results['listening'],
                          ),
                          _buildSkillCard(
                            pix: pix,
                            isDarkMode: isDarkMode,
                            title: 'Speaking',
                            icon: Icons.mic_rounded,
                            data: results['speaking'],
                          ),
                          _buildSkillCard(
                            pix: pix,
                            isDarkMode: isDarkMode,
                            title: 'Reading',
                            icon: Icons.menu_book_rounded,
                            data: results['reading'],
                          ),
                          _buildSkillCard(
                            pix: pix,
                            isDarkMode: isDarkMode,
                            title: 'Writing',
                            icon: Icons.edit_rounded,
                            data: results['writing'],
                          ),
                        ],
                      ),

                      SizedBox(height: 32 * pix),

                      // Detailed results button
                      OutlinedButton(
                        onPressed: () {
                          // Navigate to detailed results
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 12 * pix, horizontal: 24 * pix),
                          side: BorderSide(
                              color: const Color(0xFF4F46E5), width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12 * pix),
                          ),
                        ),
                        child: Text(
                          'View Detailed Results',
                          style: TextStyle(
                            fontSize: 16 * pix,
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF4F46E5),
                          ),
                        ),
                      ),

                      SizedBox(height: 24 * pix),

                      // Main action button
                      ElevatedButton(
                        onPressed: () => Navigator.popUntil(
                            context, (route) => route.isFirst),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 56 * pix),
                          padding: EdgeInsets.symmetric(horizontal: 24 * pix),
                          backgroundColor: const Color(0xFF4F46E5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12 * pix),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Back to Home',
                          style: TextStyle(
                            fontSize: 16 * pix,
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      SizedBox(height: 32 * pix),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCard({
    required double pix,
    required bool isDarkMode,
    required String title,
    required IconData icon,
    required Map<String, dynamic> data,
  }) {
    final score = ((data['correct'] / data['total']) * 100).round();

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E2F) : Colors.white,
        borderRadius: BorderRadius.circular(12 * pix),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16 * pix),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8 * pix),
              decoration: BoxDecoration(
                color: _getSkillColor(title).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 24 * pix,
                color: _getSkillColor(title),
              ),
            ),
            SizedBox(height: 16 * pix),
            Text(
              title,
              style: TextStyle(
                fontSize: 16 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : const Color(0xFF1E293B),
              ),
            ),
            SizedBox(height: 8 * pix),
            Text(
              '${data['correct']}/${data['total']} correct',
              style: TextStyle(
                fontSize: 14 * pix,
                fontFamily: 'BeVietnamPro',
                color: isDarkMode ? Colors.grey[400] : const Color(0xFF64748B),
              ),
            ),
            SizedBox(height: 4 * pix),
            LinearProgressIndicator(
              value: data['correct'] / data['total'],
              backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              color: _getScoreColor(score),
              minHeight: 6 * pix,
              borderRadius: BorderRadius.circular(3 * pix),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSkillColor(String skill) {
    switch (skill.toLowerCase()) {
      case 'listening':
        return const Color(0xFF10B981);
      case 'speaking':
        return const Color(0xFFF59E0B);
      case 'reading':
        return const Color(0xFF3B82F6);
      case 'writing':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF4F46E5);
    }
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return const Color(0xFF10B981);
    if (score >= 60) return const Color(0xFF3B82F6);
    if (score >= 40) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  int _calculateTotalScore() {
    final listening =
        (results['listening']['correct'] / results['listening']['total']) * 25;
    final speaking =
        (results['speaking']['correct'] / results['speaking']['total']) * 25;
    final reading =
        (results['reading']['correct'] / results['reading']['total']) * 25;
    final writing =
        (results['writing']['correct'] / results['writing']['total']) * 25;
    return (listening + speaking + reading + writing).round();
  }
}
