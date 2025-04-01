import 'dart:async';
import 'package:flutter/material.dart';
import 'exam_summary_screen.dart';

class WritingScreen extends StatefulWidget {
  final String examName;
  final int timeLeft;
  final Map<String, dynamic> listeningResults;
  final Map<String, dynamic> speakingResults;
  final Map<String, dynamic> readingResults;
  const WritingScreen({
    super.key,
    required this.examName,
    required this.timeLeft,
    required this.listeningResults,
    required this.speakingResults,
    required this.readingResults,
  });

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  late int timeLeft;
  int currentQuestion = 0;
  List<List<String>> userAnswers = List.generate(3, (_) => []);
  List<bool?> checkResults =
      List.filled(3, null); // null: chưa kiểm tra, true: đúng, false: sai

  final List<Map<String, dynamic>> questions = [
    {
      'correct': 'I enjoy reading books',
      'words': <String>['enjoy', 'I', 'reading', 'books', 'play', 'the'],
    },
    {
      'correct': 'She runs every morning',
      'words': <String>['every', 'She', 'runs', 'morning', 'fast', 'on'],
    },
    {
      'correct': 'They watch movies together',
      'words': <String>['watch', 'They', 'movies', 'together', 'sing', 'often'],
    },
  ];

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

  void _checkAnswer() {
    final userSentence = userAnswers[currentQuestion].join(' ').trim();
    final correctSentence = questions[currentQuestion]['correct'].trim();
    setState(() {
      checkResults[currentQuestion] = userSentence == correctSentence;
    });
  }

  void _submitSection() {
    if (currentQuestion == questions.length - 1) {
      final writingResults = {
        'correct': checkResults.where((result) => result == true).length,
        'total': questions.length,
        'timeTaken': widget.timeLeft - timeLeft, // Thời gian đã dùng
      };
      final allResults = {
        'listening': widget.listeningResults,
        'speaking': widget.speakingResults,
        'reading': widget.readingResults,
        'writing': writingResults,
      };
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ExamSummaryScreen(
            examName: widget.examName,
            results: allResults,
          ),
        ),
      ); // Chuyển sang ExamSummaryScreen với tất cả kết quả
    } else {
      setState(() { 
        currentQuestion++;
        checkResults[currentQuestion] =
            null; // Reset trạng thái kiểm tra cho câu mới
      });
    }
  }

  void _addWordToAnswer(String word) {
    setState(() {
      userAnswers[currentQuestion].add(word);
      checkResults[currentQuestion] = null; // Reset trạng thái khi thay đổi câu
    });
  }

  void _removeWordFromAnswer(int index) {
    setState(() {
      userAnswers[currentQuestion].removeAt(index);
      checkResults[currentQuestion] = null; // Reset trạng thái khi thay đổi câu
    });
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
      Navigator.pop(context); // Thoát về ExamScreen
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final current = questions[currentQuestion];
    final List<String> availableWords = (current['words'] as List<String>)
        .where((word) => !userAnswers[currentQuestion].contains(word))
        .toList();

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
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16 * pix, vertical: 8 * pix),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Câu ${currentQuestion + 1}/${questions.length}',
                      style: TextStyle(
                        fontSize: 16 * pix,
                        fontFamily: 'BeVietnamPro',
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16 * pix),
                child: LinearProgressIndicator(
                  value: (currentQuestion + 1) / questions.length,
                  backgroundColor:
                      isDarkMode ? Colors.grey[700] : const Color(0xFFE5E7EB),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
                  minHeight: 4 * pix,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(16 * pix),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sắp xếp thành câu đúng',
                        style: TextStyle(
                          fontSize: 18 * pix,
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w600,
                          color: isDarkMode
                              ? Colors.white
                              : const Color(0xFF1C2526),
                        ),
                      ),
                      SizedBox(height: 16 * pix),
                      Card(
                        color:
                            isDarkMode ? const Color(0xFF1E1E2F) : Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12 * pix),
                          side: BorderSide(
                              color: isDarkMode
                                  ? Colors.grey[800]!
                                  : const Color(0xFFE5E7EB)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16 * pix),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chọn và sắp xếp các từ dưới đây thành câu hoàn chỉnh:',
                                style: TextStyle(
                                  fontSize: 16 * pix,
                                  fontFamily: 'BeVietnamPro',
                                  color: isDarkMode
                                      ? Colors.grey[400]
                                      : Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 12 * pix),
                              Wrap(
                                spacing: 8 * pix,
                                runSpacing: 8 * pix,
                                children: availableWords.map((word) {
                                  return GestureDetector(
                                    onTap: () => _addWordToAnswer(word),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12 * pix,
                                          vertical: 8 * pix),
                                      decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? Colors.grey[700]
                                            : const Color(0xFFF1F5F9),
                                        borderRadius:
                                            BorderRadius.circular(8 * pix),
                                      ),
                                      child: Text(
                                        word,
                                        style: TextStyle(
                                          fontSize: 14 * pix,
                                          fontFamily: 'BeVietnamPro',
                                          color: isDarkMode
                                              ? Colors.white
                                              : const Color(0xFF1C2526),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 16 * pix),
                              Text(
                                'Câu của bạn:',
                                style: TextStyle(
                                  fontSize: 16 * pix,
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w500,
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xFF1C2526),
                                ),
                              ),
                              SizedBox(height: 8 * pix),
                              Wrap(
                                spacing: 8 * pix,
                                runSpacing: 8 * pix,
                                children: userAnswers[currentQuestion]
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final index = entry.key;
                                  final word = entry.value;
                                  return GestureDetector(
                                    onTap: () => _removeWordFromAnswer(index),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12 * pix,
                                          vertical: 8 * pix),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF10B981)
                                            .withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(8 * pix),
                                        border: Border.all(
                                            color: const Color(0xFF10B981)),
                                      ),
                                      child: Text(
                                        word,
                                        style: TextStyle(
                                          fontSize: 14 * pix,
                                          fontFamily: 'BeVietnamPro',
                                          color: isDarkMode
                                              ? Colors.white
                                              : const Color(0xFF1C2526),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 12 * pix),
                              if (checkResults[currentQuestion] != null)
                                Text(
                                  checkResults[currentQuestion]!
                                      ? 'Đúng!'
                                      : 'Sai, hãy thử lại.',
                                  style: TextStyle(
                                    fontSize: 14 * pix,
                                    fontFamily: 'BeVietnamPro',
                                    color: checkResults[currentQuestion]!
                                        ? const Color(0xFF10B981)
                                        : const Color(0xFFEF4444),
                                  ),
                                ),
                              SizedBox(height: 12 * pix),
                              ElevatedButton(
                                onPressed:
                                    userAnswers[currentQuestion].isNotEmpty
                                        ? _checkAnswer
                                        : null,
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16 * pix, vertical: 12 * pix),
                                  backgroundColor: const Color(0xFF3B82F6),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12 * pix)),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Kiểm tra',
                                  style: TextStyle(
                                    fontSize: 16 * pix,
                                    fontFamily: 'BeVietnamPro',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16 * pix, vertical: 16 * pix),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentQuestion > 0)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => currentQuestion--),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12 * pix),
                            backgroundColor: Colors.transparent,
                            foregroundColor: const Color(0xFF3B82F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12 * pix),
                              side: const BorderSide(color: Color(0xFF3B82F6)),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Quay Lại',
                            style: TextStyle(
                              fontSize: 16 * pix,
                              fontFamily: 'BeVietnamPro',
                              color: const Color(0xFF3B82F6),
                            ),
                          ),
                        ),
                      ),
                    if (currentQuestion > 0) SizedBox(width: 16 * pix),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: checkResults[currentQuestion] == true
                            ? _submitSection
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12 * pix),
                          backgroundColor: const Color(0xFF10B981),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12 * pix)),
                          elevation: 0,
                        ),
                        child: Text(
                          currentQuestion < questions.length - 1
                              ? 'Tiếp Theo'
                              : 'Hoàn Thành',
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
            ],
          ),
        ),
      ),
    );
  }
}
