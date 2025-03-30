import 'package:flutter/material.dart';
import 'package:language_app/widget/bottom_bar.dart';
import 'package:language_app/hungnm/test/questions_screen.dart';
import 'package:language_app/hungnm/test/vocab_game/vocabulary_game_screen.dart';
import 'package:language_app/hungnm/test/exam_screen.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header với nền nhẹ
            Container(
              padding:
                  EdgeInsets.fromLTRB(24 * pix, 32 * pix, 24 * pix, 16 * pix),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDarkMode
                      ? [const Color(0xFF1E1E2F), const Color(0xFF121212)]
                      : [const Color(0xFFF1F5F9), Colors.white],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Luyện Tập & Đánh Giá',
                    style: TextStyle(
                      fontSize: 28 * pix,
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.w700,
                      color:
                          isDarkMode ? Colors.white : const Color(0xFF1C2526),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            // Nội dung chính
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: 24 * pix, vertical: 24 * pix),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hành Trình Học Tập',
                          style: TextStyle(
                            fontSize: 18 * pix,
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xFF1C2526),
                          ),
                        ),
                        SizedBox(width: 8 * pix),
                        Container(
                          height: 2 * pix,
                          width: 40 * pix,
                          color: isDarkMode
                              ? Colors.grey[700]
                              : const Color(0xFFE5E7EB),
                        ),
                      ],
                    ),
                    SizedBox(height: 8 * pix),
                    Text(
                      'Chọn một nhiệm vụ để nâng cao kỹ năng tiếng Anh',
                      style: TextStyle(
                        fontSize: 14 * pix,
                        fontFamily: 'BeVietnamPro',
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 24 * pix),
                    _buildTaskCard(
                      context: context,
                      icon: Icons.quiz,
                      title: 'Câu Đố Thích Ứng',
                      subtitle: 'Câu hỏi cá nhân hóa để kiểm tra kiến thức',
                      progress: 0.7,
                      color: const Color(0xFF3B82F6), // Xanh dương
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuestionsScreen()),
                      ),
                      pix: pix,
                    ),
                    SizedBox(height: 16 * pix),
                    _buildTaskCard(
                      context: context,
                      icon: Icons.extension,
                      title: 'Luyện Từ Vựng',
                      subtitle: 'Trò chơi tương tác để nắm vững từ mới',
                      progress: 0.4,
                      color: const Color(0xFF10B981), // Xanh lá
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VocabularyGameScreen()),
                      ),
                      pix: pix,
                    ),
                    SizedBox(height: 16 * pix),
                    _buildTaskCard(
                      context: context,
                      icon: Icons.analytics,
                      title: 'Đánh Giá Kỹ Năng',
                      subtitle: 'Bài kiểm tra toàn diện để đánh giá trình độ',
                      progress: 0.2,
                      color: const Color(0xFFD97706), // Cam
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExamScreen()),
                      ),
                      pix: pix,
                    ),
                    SizedBox(height: 32 * pix),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Bottombar(type: 4),
    );
  }

  Widget _buildTaskCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required double progress,
    required Color color,
    required double pix,
    required VoidCallback onTap,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(20 * pix),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E2F) : Colors.white,
          borderRadius: BorderRadius.circular(16 * pix),
          border: Border.all(
            color: isDarkMode ? Colors.grey[800]! : const Color(0xFFE5E7EB),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12 * pix),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 24 * pix,
                    color: color,
                  ),
                ),
                SizedBox(width: 16 * pix),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18 * pix,
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w600,
                          color: isDarkMode
                              ? Colors.white
                              : const Color(0xFF1C2526),
                        ),
                      ),
                      SizedBox(height: 4 * pix),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14 * pix,
                          fontFamily: 'BeVietnamPro',
                          color:
                              isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18 * pix,
                  color: color,
                ),
              ],
            ),
            SizedBox(height: 16 * pix),
            LinearProgressIndicator(
              value: progress,
              backgroundColor:
                  isDarkMode ? Colors.grey[700] : const Color(0xFFE5E7EB),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 4 * pix,
            ),
          ],
        ),
      ),
    );
  }
}
