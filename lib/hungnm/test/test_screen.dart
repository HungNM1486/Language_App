import 'package:flutter/material.dart';
import 'package:language_app/widget/bottom_bar.dart';
import 'package:language_app/hungnm/test/questions_screen.dart';
import 'package:language_app/hungnm/test/vocab_game/vocabulary_game_screen.dart';
import 'package:language_app/hungnm/test/exam_screen.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = (size.width / 375).clamp(0.8, 1.2);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [
                    const Color(0xFF0F2027),
                    const Color(0xFF203A43),
                    const Color(0xFF2C5364)
                  ]
                : [
                    const Color(0xFFE0F7FA),
                    const Color(0xFFB2EBF2),
                    const Color(0xFF80DEEA)
                  ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 20 * pix),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24 * pix),
              child: Row(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).padding.top + 20 * pix),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24 * pix),
                    child: Center(
                      // Sử dụng Center để căn giữa chữ
                      child: Text(
                        'Kiểm Tra',
                        style: TextStyle(
                          fontSize: 28 * pix,
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w800,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32 * pix),
                ],
              ),
            ),
            SizedBox(height: 32 * pix),
            Expanded(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(40 * pix)),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40 * pix)),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(
                        24 * pix, 40 * pix, 24 * pix, 24 * pix),
                    child: Column(
                      children: [
                        _buildModernOption(
                          context: context,
                          icon: Icons.auto_awesome,
                          title: "Câu Hỏi Thông Minh",
                          subtitle: "Hệ thống câu hỏi AI tự điều chỉnh",
                          color: const Color(0xFFFF6B6B),
                          pix: pix,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QuestionsScreen()),
                          ),
                        ),
                        SizedBox(height: 24 * pix),
                        _buildModernOption(
                          context: context,
                          icon: Icons.videogame_asset,
                          title: "Trò Chơi Tương Tác",
                          subtitle: "Học từ vựng qua trò chơi",
                          color: const Color(0xFF4ECDC4),
                          pix: pix,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const VocabularyGameScreen()),
                          ),
                        ),
                        SizedBox(height: 24 * pix),
                        _buildModernOption(
                          context: context,
                          icon: Icons.analytics,
                          title: "Đánh Giá Năng Lực",
                          subtitle: "Bài test phân tích điểm mạnh/yếu",
                          color: const Color(0xFFFFA3A3),
                          pix: pix,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ExamScreen()),
                          ),
                        ),
                        SizedBox(height: 40 * pix),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Bottombar(type: 4),
    );
  }

  Widget _buildModernOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required double pix,
    required VoidCallback onTap,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(20 * pix),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20 * pix),
        margin: EdgeInsets.symmetric(vertical: 8 * pix),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(20 * pix),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black : Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(4, 4),
            ),
            BoxShadow(
              color: isDarkMode ? Colors.grey[800]! : Colors.white,
              blurRadius: 10,
              offset: const Offset(-4, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60 * pix,
              height: 60 * pix,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.8), color],
                ),
              ),
              child: Icon(icon, size: 28 * pix, color: Colors.white),
            ),
            SizedBox(width: 20 * pix),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18 * pix,
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4 * pix),  
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14 * pix,
                      fontFamily: 'BeVietnamPro',
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18 * pix,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}
