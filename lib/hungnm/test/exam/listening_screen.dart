import 'dart:async';
import 'package:flutter/material.dart';
import 'speaking_screen.dart';

class ListeningScreen extends StatefulWidget {
  final String examName;
  final int timeLeft;
  const ListeningScreen(
      {super.key, required this.examName, required this.timeLeft});

  @override
  State<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  late int timeLeft;
  int currentQuestion = 0;
  List<bool?> answers = List.filled(3, null);

  final List<Map<String, dynamic>> questions = [
    {
      'audio': 'audio/listening_1.mp3',
      'question': 'What is the man asking for?',
      'options': [
        'A cup of coffee',
        'A glass of water',
        'A sandwich',
        'A ticket'
      ],
      'correct': 1,
    },
    {
      'audio': 'audio/listening_2.mp3',
      'question': 'Where is the woman going?',
      'options': ['To the park', 'To the office', 'To the store', 'To school'],
      'correct': 2,
    },
    {
      'audio': 'audio/listening_3.mp3',
      'question': 'What time does the meeting start?',
      'options': ['9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM'],
      'correct': 0,
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

  void _playAudio(String audioPath) {
    print('Playing audio: $audioPath');
  }

  void _submitSection() {
    if (currentQuestion == questions.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SpeakingScreen(
            examName: widget.examName,
            timeLeft: timeLeft,
          ),
        ),
      );
    } else {
      setState(() => currentQuestion++);
    }
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
      // Thoát về ExamScreen bằng cách pop hết stack đến ExamScreen
      Navigator.pop(context); // Thoát ListeningScreen
      return true; // Cho phép thoát
    }
    return false; // Không thoát nếu chọn "Tiếp tục làm"
  }

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final current = questions[currentQuestion];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
        appBar: AppBar(
          title: Text(
            '${widget.examName} - Kỹ Năng Nghe',
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
                        'Hãy chọn đáp án đúng',
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
                          padding: EdgeInsets.all(12 * pix),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => _playAudio(current['audio']),
                                    child: Container(
                                      padding: EdgeInsets.all(8 * pix),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF3B82F6)
                                            .withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.volume_up,
                                        size: 20 * pix,
                                        color: const Color(0xFF3B82F6),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12 * pix),
                                  Expanded(
                                    child: Text(
                                      current['question'],
                                      style: TextStyle(
                                        fontSize: 16 * pix,
                                        fontFamily: 'BeVietnamPro',
                                        color: isDarkMode
                                            ? Colors.white
                                            : const Color(0xFF1C2526),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12 * pix),
                              ...current['options']
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                final idx = entry.key;
                                final option = entry.value;
                                final isSelected =
                                    answers[currentQuestion] != null;
                                final isCorrect = idx == current['correct'];

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 6 * pix),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        answers[currentQuestion] = isCorrect;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      padding: EdgeInsets.all(10 * pix),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? (isCorrect
                                                ? const Color(0xFF10B981)
                                                    .withOpacity(0.1)
                                                : Colors.red.withOpacity(0.1))
                                            : (isDarkMode
                                                ? Colors.grey[800]
                                                : const Color(0xFFF1F5F9)),
                                        borderRadius:
                                            BorderRadius.circular(8 * pix),
                                        border: Border.all(
                                          color: isSelected
                                              ? (isCorrect
                                                  ? const Color(0xFF10B981)
                                                  : Colors.red)
                                              : Colors.transparent,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            isSelected
                                                ? (isCorrect
                                                    ? Icons.check_circle
                                                    : Icons.cancel)
                                                : Icons.radio_button_unchecked,
                                            size: 18 * pix,
                                            color: isSelected
                                                ? (isCorrect
                                                    ? const Color(0xFF10B981)
                                                    : Colors.red)
                                                : (isDarkMode
                                                    ? Colors.grey[400]
                                                    : Colors.grey[600]),
                                          ),
                                          SizedBox(width: 10 * pix),
                                          Expanded(
                                            child: Text(
                                              option,
                                              style: TextStyle(
                                                fontSize: 14 * pix,
                                                fontFamily: 'BeVietnamPro',
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : const Color(0xFF1C2526),
                                              ),
                                            ),
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
                        onPressed: _submitSection,
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
