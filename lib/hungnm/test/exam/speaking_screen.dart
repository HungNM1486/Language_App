import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'reading_screen.dart';

class SpeakingScreen extends StatefulWidget {
  final String examName;
  final int timeLeft;
  final Map<String, dynamic> listeningResults;
  const SpeakingScreen({
    super.key,
    required this.examName,
    required this.timeLeft,
    required this.listeningResults,
  });
  @override
  State<SpeakingScreen> createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  late int timeLeft;
  late int initialTime;

  int currentWord = 0;
  List<bool?> answers =
      List.filled(3, null); // null: chưa ghi, true: đúng, false: sai
  bool isRecording = false; // Trạng thái đang ghi âm
  Timer? recordingTimer; // Timer để đếm 5 giây

  final List<String> words = [
    'Hello',
    'World',
    'Flutter',
  ];

  @override
  void initState() {
    super.initState();
    timeLeft = widget.timeLeft;
    initialTime = widget.timeLeft; // Lưu thời gian ban đầu
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

  void _startRecording() {
    if (isRecording) return; // Không làm gì nếu đang ghi âm

    setState(() {
      isRecording = true;
      answers[currentWord] = null; // Reset trạng thái về chưa ghi
    });

    print('Bắt đầu ghi âm từ: ${words[currentWord]}');
    HapticFeedback.mediumImpact(); // Rung khi bắt đầu

    recordingTimer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        _stopRecording();
      }
    });
  }

  void _stopRecording() {
    setState(() {
      isRecording = false;
    });
    recordingTimer?.cancel();
    _checkPronunciation();
  }

  void _checkPronunciation() {
    bool isCorrect = _mockPronunciationCheck(words[currentWord]);

    setState(() {
      answers[currentWord] = isCorrect;
    });
    print('Kết quả ghi âm: ${isCorrect ? "Đúng" : "Sai"}');
    HapticFeedback.lightImpact(); // Rung khi dừng

    if (!isCorrect) {
      _showRetryDialog();
    }
  }

  bool _mockPronunciationCheck(String word) {
    // Giả lập: 50% đúng, 50% sai (thay bằng API thật nếu có)
    return DateTime.now().millisecond % 2 == 0;
  }

  void _showRetryDialog() {
    showDialog(
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
                Icon(Icons.error_outline,
                    size: 40 * pix, color: const Color(0xFFEF4444)),
                SizedBox(height: 16 * pix),
                Text(
                  'Phát âm chưa đúng',
                  style: TextStyle(
                    fontSize: 20 * pix,
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : const Color(0xFF1C2526),
                  ),
                ),
                SizedBox(height: 8 * pix),
                Text(
                  'Bạn muốn thử lại hay bỏ qua?',
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
                        onPressed: () {
                          Navigator.pop(context); // Đóng dialog
                          _startRecording(); // Thử lại
                        },
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
                          'Thử lại',
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
                        onPressed: () {
                          Navigator.pop(context); // Đóng dialog
                          _submitSection(); // Bỏ qua
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12 * pix),
                          backgroundColor: const Color(0xFF10B981),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12 * pix)),
                          elevation: 0,
                        ),
                        child: Text(
                          'Bỏ qua',
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
  }

  void _submitSection() {
    if (currentWord == words.length - 1) {
      final speakingResults = {
        'correct': answers.where((answer) => answer == true).length,
        'total': words.length,
        'timeTaken': widget.timeLeft - timeLeft, // Thời gian đã dùng
      };
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReadingScreen(
            examName: widget.examName,
            timeLeft: timeLeft,
            listeningResults:
                widget.listeningResults, // Truyền từ ListeningScreen
            speakingResults: speakingResults, // Kết quả SpeakingScreen
          ),
        ),
      );
    } else {
      setState(() => currentWord++);
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
      recordingTimer?.cancel(); // Hủy timer nếu đang ghi âm
      Navigator.pop(context); // Thoát về ExamScreen
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    recordingTimer?.cancel(); // Hủy timer khi thoát màn hình
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final current = words[currentWord];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
        appBar: AppBar(
          title: Text(
            '${widget.examName} - Kỹ Năng Nói',
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
                      'Từ ${currentWord + 1}/${words.length}',
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
                  value: (currentWord + 1) / words.length,
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
                        'Phát âm từ dưới đây',
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
                          padding: EdgeInsets.all(24 * pix),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                current,
                                style: TextStyle(
                                  fontSize: 24 * pix,
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w600,
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xFF1C2526),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 32 * pix),
                              Center(
                                child: GestureDetector(
                                  onTap: _startRecording,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    padding: EdgeInsets.all(16 * pix),
                                    decoration: BoxDecoration(
                                      color: isRecording
                                          ? const Color(0xFF10B981)
                                              .withOpacity(0.5)
                                          : answers[currentWord] == null
                                              ? const Color(0xFFEF4444)
                                                  .withOpacity(0.1)
                                              : answers[currentWord] == true
                                                  ? const Color(0xFF10B981)
                                                      .withOpacity(0.5)
                                                  : const Color(0xFFEF4444)
                                                      .withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isRecording
                                          ? Icons.mic
                                          : answers[currentWord] == null
                                              ? Icons.mic_none
                                              : answers[currentWord] == true
                                                  ? Icons.check_circle
                                                  : Icons.error,
                                      size: 32 * pix,
                                      color: isRecording
                                          ? const Color(0xFF10B981)
                                          : answers[currentWord] == null
                                              ? const Color(0xFFEF4444)
                                              : answers[currentWord] == true
                                                  ? const Color(0xFF10B981)
                                                  : const Color(0xFFEF4444),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8 * pix),
                              Text(
                                isRecording
                                    ? 'Đang ghi...'
                                    : answers[currentWord] == null
                                        ? 'Nhấn để ghi âm'
                                        : answers[currentWord] == true
                                            ? 'Đúng'
                                            : 'Sai',
                                style: TextStyle(
                                  fontSize: 14 * pix,
                                  fontFamily: 'BeVietnamPro',
                                  color: isDarkMode
                                      ? Colors.grey[400]
                                      : Colors.grey[600],
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
                    if (currentWord > 0)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => currentWord--),
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
                    if (currentWord > 0) SizedBox(width: 16 * pix),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: answers[currentWord] == true && !isRecording
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
                          currentWord < words.length - 1
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
