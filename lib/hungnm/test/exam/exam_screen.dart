import 'package:flutter/material.dart';
import 'listening_screen.dart';

final List<Map<String, String>> exams = [
  {'name': 'Bài kiểm tra 1', 'description': 'Kiểm tra toàn diện trình độ cơ bản'},
  {'name': 'Bài kiểm tra 2', 'description': 'Tập trung vào kỹ năng giao tiếp'},
  {'name': 'Bài kiểm tra 3', 'description': 'Ôn luyện nâng cao'},
];

class ExamScreen extends StatelessWidget {
  const ExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                  : [const Color(0xFFF1F5F9), Colors.white],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24 * pix, 32 * pix, 24 * pix, 16 * pix),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kiểm Tra Kỹ Năng',
                      style: TextStyle(
                        fontSize: 28 * pix,
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 24 * pix,
                        color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24 * pix, vertical: 16 * pix),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Danh Sách Bài Kiểm Tra',
                            style: TextStyle(
                              fontSize: 18 * pix,
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
                            ),
                          ),
                          SizedBox(width: 8 * pix),
                          Container(
                            height: 2 * pix,
                            width: 40 * pix,
                            color: isDarkMode ? Colors.grey[700] : const Color(0xFFE5E7EB),
                          ),
                        ],
                      ),
                      SizedBox(height: 8 * pix),
                      Text(
                        'Chọn bài kiểm tra để đánh giá kỹ năng của bạn',
                        style: TextStyle(
                          fontSize: 14 * pix,
                          fontFamily: 'BeVietnamPro',
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 24 * pix),
                      ...exams.map((exam) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8 * pix),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListeningScreen(
                                    examName: exam['name']!,
                                    timeLeft: 1200, // 20 phút
                                  ),
                                ),
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              padding: EdgeInsets.all(16 * pix),
                              decoration: BoxDecoration(
                                color: isDarkMode ? const Color(0xFF1E1E2F) : Colors.white,
                                borderRadius: BorderRadius.circular(12 * pix),
                                border: Border.all(
                                  color: isDarkMode ? Colors.grey[800]! : const Color(0xFFE5E7EB),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10 * pix),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD97706).withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.assessment,
                                      size: 24 * pix,
                                      color: const Color(0xFFD97706),
                                    ),
                                  ),
                                  SizedBox(width: 16 * pix),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          exam['name']!,
                                          style: TextStyle(
                                            fontSize: 18 * pix,
                                            fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.w600,
                                            color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
                                          ),
                                        ),
                                        SizedBox(height: 4 * pix),
                                        Text(
                                          exam['description']!,
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
                                    color: const Color(0xFFD97706),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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
}