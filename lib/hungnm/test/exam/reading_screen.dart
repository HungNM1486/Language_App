import 'dart:async';
import 'package:flutter/material.dart';
import 'writing_screen.dart';

class ReadingScreen extends StatefulWidget {
  final String examName;
  final int timeLeft;
  const ReadingScreen(
      {super.key, required this.examName, required this.timeLeft});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  late int timeLeft;
  int currentPassage = 0;
  List<Map<String, dynamic>> answers =
      List.generate(6, (_) => {'type': '', 'value': null}); // Lưu câu trả lời

  final List<Map<String, dynamic>> passages = [
    {
      'text': '''
      The Internet has become an essential part of modern life. It allows people to communicate instantly through email and social media, access vast amounts of information, and shop online from the comfort of their homes. However, it also has downsides, such as the risk of cybercrime and the spread of misinformation. Despite these challenges, the Internet remains a powerful tool for education and business.
      ''',
      'questions': [
        {
          'type': 'multiple_choice',
          'question':
              'What is one benefit of the Internet mentioned in the passage?',
          'options': [
            'A. Reduced travel costs',
            'B. Instant communication',
            'C. Fewer job opportunities',
            'D. Increased paper use'
          ],
          'correct': 'B',
        },
        {
          'type': 'fill_in_the_blank',
          'question':
              'The Internet is a powerful tool for ______ and business.',
          'correct': 'education',
        },
        {
          'type': 'multiple_choice',
          'question': 'What is a downside of the Internet?',
          'options': [
            'A. Cybercrime',
            'B. Better education',
            'C. Faster shopping',
            'D. Improved communication'
          ],
          'correct': 'A',
        },
      ],
    },
    {
      'text': '''
      Elephants are the largest land animals on Earth. They live in herds and are known for their strong family bonds. In the wild, elephants can be found in Africa and Asia, where they eat plants and use their trunks for many tasks, like drinking water or picking up objects. Sadly, their populations are decreasing due to habitat loss and poaching.
      ''',
      'questions': [
        {
          'type': 'multiple_choice',
          'question': 'Where can elephants be found in the wild?',
          'options': [
            'A. Europe and Australia',
            'B. Africa and Asia',
            'C. North America',
            'D. South America'
          ],
          'correct': 'B',
        },
        {
          'type': 'fill_in_the_blank',
          'question': 'Elephants use their ______ for many tasks.',
          'correct': 'trunks',
        },
        {
          'type': 'multiple_choice',
          'question': 'Why are elephant populations decreasing?',
          'options': [
            'A. Too many plants',
            'B. Habitat loss and poaching',
            'C. Strong family bonds',
            'D. Living in herds'
          ],
          'correct': 'B',
        },
      ],
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

  void _submitSection() {
    if (currentPassage == passages.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WritingScreen(
            examName: widget.examName,
            timeLeft: timeLeft,
          ),
        ),
      );
    } else {
      setState(() => currentPassage++);
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
      Navigator.pop(context); // Thoát về ExamScreen
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final current = passages[currentPassage];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
        appBar: AppBar(
          title: Text(
            '${widget.examName} - Kỹ Năng Đọc',
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
                      'Đoạn ${currentPassage + 1}/${passages.length}',
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
                  value: (currentPassage + 1) / passages.length,
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
                        'Đọc và trả lời câu hỏi',
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
                          child: Text(
                            current['text'],
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
                      SizedBox(height: 16 * pix),
                      ...current['questions'].asMap().entries.map((entry) {
                        final index =
                            entry.key + currentPassage * 3; // Chỉ số toàn cục
                        final question = entry.value;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12 * pix),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Câu ${index + 1}: ${question['question']}',
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
                              if (question['type'] == 'multiple_choice')
                                ...question['options']
                                    .asMap()
                                    .entries
                                    .map((optionEntry) {
                                  final optionIndex = optionEntry.key;
                                  final option = optionEntry.value;
                                  final isSelected =
                                      answers[index]['value'] == option[0];
                                  final isCorrect =
                                      option[0] == question['correct'];

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        answers[index] = {
                                          'type': 'multiple_choice',
                                          'value': option[0],
                                        };
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      margin: EdgeInsets.only(bottom: 4 * pix),
                                      padding: EdgeInsets.all(10 * pix),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? (isCorrect
                                                ? const Color(0xFF10B981)
                                                    .withOpacity(0.1)
                                                : const Color(0xFFEF4444)
                                                    .withOpacity(0.1))
                                            : (isDarkMode
                                                ? Colors.grey[800]
                                                : const Color(0xFFF1F5F9)),
                                        borderRadius:
                                            BorderRadius.circular(8 * pix),
                                        border: Border.all(
                                          color: isSelected
                                              ? (isCorrect
                                                  ? const Color(0xFF10B981)
                                                  : const Color(0xFFEF4444))
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
                                                    : const Color(0xFFEF4444))
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
                                  );
                                }).toList()
                              else if (question['type'] == 'fill_in_the_blank')
                                TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      answers[index] = {
                                        'type': 'fill_in_the_blank',
                                        'value': value.trim().toLowerCase(),
                                      };
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Nhập câu trả lời',
                                    hintStyle: TextStyle(
                                      fontSize: 14 * pix,
                                      fontFamily: 'BeVietnamPro',
                                      color: isDarkMode
                                          ? Colors.grey[400]
                                          : Colors.grey[600],
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(8 * pix),
                                      borderSide: BorderSide(
                                        color: isDarkMode
                                            ? Colors.grey[800]!
                                            : const Color(0xFFE5E7EB),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: isDarkMode
                                        ? Colors.grey[800]
                                        : const Color(0xFFF1F5F9),
                                  ),
                                  style: TextStyle(
                                    fontSize: 14 * pix,
                                    fontFamily: 'BeVietnamPro',
                                    color: isDarkMode
                                        ? Colors.white
                                        : const Color(0xFF1C2526),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
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
                    if (currentPassage > 0)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => currentPassage--),
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
                    if (currentPassage > 0) SizedBox(width: 16 * pix),
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
                          currentPassage < passages.length - 1
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
