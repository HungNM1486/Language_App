import 'dart:async';
import 'package:flutter/material.dart';
import 'exam_summary_screen.dart';
import 'exam_screen.dart';

class WritingScreen extends StatefulWidget {
  final String examName;
  final int timeLeft;
  const WritingScreen(
      {super.key, required this.examName, required this.timeLeft});

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  late int timeLeft;

  @override
  void initState() {
    super.initState();
    timeLeft = widget.timeLeft;
    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (timeLeft > 0) {
            timeLeft--;
          } else {
            timer.cancel();
            _submitSection();
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _submitSection() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ExamSummaryScreen(examName: widget.examName),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16 * pix)),
          backgroundColor: isDarkMode ? const Color(0xFF1E1E2F) : Colors.white,
          child: Padding(
            padding: EdgeInsets.all(20 * pix),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning_rounded,
                    size: 40 * pix, color: const Color(0xFFFFA726)),
                SizedBox(height: 16 * pix),
                Text(
                  'Thoát bài kiểm tra?',
                  style: TextStyle(
                    fontSize: 20 * pix,
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
                  ),
                ),
                SizedBox(height: 8 * pix),
                Text(
                  'Bạn sẽ quay lại trang chọn bài kiểm tra nếu thoát bây giờ',
                  style: TextStyle(
                    fontSize: 16 * pix,
                    fontFamily: 'BeVietnamPro',
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24 * pix),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12 * pix),
                          side: BorderSide(
                              color: isDarkMode
                                  ? Colors.grey[600]!
                                  : const Color(0xFFE5E7EB)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12 * pix)),
                        ),
                        child: Text(
                          'Tiếp tục làm',
                          style: TextStyle(
                            fontSize: 16 * pix,
                            fontFamily: 'BeVietnamPro',
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xFF1C2526),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16 * pix),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12 * pix),
                          backgroundColor: const Color(0xFFEF4444),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12 * pix)),
                          elevation: 0,
                        ),
                        child: Text(
                          'Thoát',
                          style: TextStyle(
                            fontSize: 16 * pix,
                            fontFamily: 'BeVietnamPro',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    if (shouldExit ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExamScreen(),
          settings: const RouteSettings(name: 'ExamScreen'),
        ),
      );
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
        appBar: AppBar(
          title: Text(
            '${widget.examName} - Kỹ Năng Viết',
            style: TextStyle(
              fontSize: 18 * pix,
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
            ),
          ),
          backgroundColor:
              isDarkMode ? const Color(0xFF1E1E2F) : const Color(0xFFF1F5F9),
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16 * pix),
              child: Row(
                children: [
                  Icon(Icons.timer,
                      size: 20 * pix, color: const Color(0xFFD97706)),
                  SizedBox(width: 4 * pix),
                  Text(
                    '${timeLeft ~/ 60}:${(timeLeft % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 16 * pix,
                      fontFamily: 'BeVietnamPro',
                      color: const Color(0xFFD97706),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.close, size: 24 * pix),
              color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
              onPressed: () async {
                await _onWillPop();
              },
            ),
          ],
        ),
        body: Container(
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
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Phần Viết (Chưa triển khai)',
                    style: TextStyle(
                      fontSize: 20 * pix,
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.w600,
                      color:
                          isDarkMode ? Colors.white : const Color(0xFF1C2526),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16 * pix),
                child: ElevatedButton(
                  onPressed: _submitSection,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 24 * pix, vertical: 12 * pix),
                    backgroundColor: const Color(0xFF10B981),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12 * pix)),
                    elevation: 0,
                  ),
                  child: Text(
                    'Hoàn Thành',
                    style: TextStyle(
                      fontSize: 16 * pix,
                      fontFamily: 'BeVietnamPro',
                      color: Colors.white,
                    ),
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
