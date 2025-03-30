import 'package:flutter/material.dart';
import 'package:language_app/widget/top_bar.dart';
import 'package:language_app/widget/bottom_bar.dart';

// Dữ liệu mẫu
final List<Map<String, dynamic>> weeks = [
  {'week': 'Tuần 1', 'description': 'Cơ bản về từ vựng', 'score': '8/10'},
  {'week': 'Tuần 2', 'description': 'Ngữ pháp cơ bản', 'score': null},
  {'week': 'Tuần 3', 'description': 'Đọc hiểu', 'score': '5/10'},
];

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = (size.width / 375).clamp(0.8, 1.2);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const TopBar(title: 'Câu hỏi'),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16 * pix),
                  child: Column(
                    children: weeks.map((week) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8 * pix),
                        child: _buildWeekOption(
                          context,
                          week: week['week'],
                          description: week['description'],
                          score: week['score'],
                          pix: pix,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const Bottombar(type: 4),
    );
  }

  Widget _buildWeekOption(BuildContext context, {required String week, required String description, required String? score, required double pix}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizScreen(week: week),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16 * pix),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12 * pix),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  week,
                  style: TextStyle(
                    fontSize: 18 * pix,
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4 * pix),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14 * pix,
                    fontFamily: 'BeVietnamPro',
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Text(
              score ?? 'Chưa làm bài',
              style: TextStyle(
                fontSize: 16 * pix,
                fontFamily: 'BeVietnamPro',
                color: score != null ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Trang làm bài trắc nghiệm
class QuizScreen extends StatefulWidget {
  final String week;
  const QuizScreen({super.key, required this.week});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int timeLeft = 300; // 5 phút
  List<bool?> answers = List.filled(10, null); // Trạng thái trả lời
  final List<Map<String, dynamic>> questions = List.generate(
    10,
    (index) => {
      'question': index % 2 == 0 
          ? "What does '${_getRandomWord()}' mean?" 
          : "Is this sentence correct? '${_getExampleSentence()}'",
      'options': _generateOptions(index),
      'correct': index % 4, // Chọn đáp án đúng ngẫu nhiên (0-3)
      'explanation': _getExplanation(index),
    },
  );

  static String _getRandomWord() {
    final words = ['Diligent', 'Eloquent', 'Pragmatic', 'Resilient', 'Ephemeral'];
    return words[(DateTime.now().millisecondsSinceEpoch % words.length)];
  }

  static String _getExampleSentence() {
    final sentences = [
      'She go to school every day.',
      'I have been living here since 2010.',
      'He don\'t likes coffee.',
      'They are playing football now.'
    ];
    return sentences[(DateTime.now().millisecondsSinceEpoch % sentences.length)];
  }

  static List<String> _generateOptions(int index) {
    if (index % 2 == 0) {
      // Câu hỏi về nghĩa từ
      return [
        'Hardworking and careful',
        'Speaking fluently and persuasively',
        'Practical and realistic',
        'Able to recover quickly from difficulties'
      ];
    } else {
      // Câu hỏi về đúng/sai câu
      return [
        'Correct',
        'Incorrect - verb agreement error',
        'Incorrect - tense error',
        'Incorrect - preposition error'
      ];
    }
  }

  static String _getExplanation(int index) {
    if (index % 2 == 0) {
      return 'This word comes from Latin origin and is often used in academic contexts.';
    } else {
      return 'Pay attention to subject-verb agreement and verb tenses in English sentences.';
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        if (timeLeft > 0) {
          setState(() => timeLeft--);
          _startTimer();
        } else {
          _submitQuiz();
        }
      }
    });
  }

  void _showQuestionList() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Question Navigator',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() => currentQuestion = index);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: answers[index] != null 
                              ? Colors.green[answers[index]! ? 400 : 300]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: currentQuestion == index 
                                ? Colors.blue 
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 16,
                              color: answers[index] != null 
                                  ? Colors.white 
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(
          week: widget.week, 
          answers: answers, 
          questions: questions
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (answers.any((answer) => answer != null)) {
      final shouldExit = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Exit Quiz?'),
          content: const Text('Your progress will not be saved if you exit now.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Exit'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
          ],
        ),
      );
      return shouldExit ?? false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final current = questions[currentQuestion];
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text(
            'English Quiz - ${widget.week}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red[300]!),
              ),
              child: Row(
                children: [
                  const Icon(Icons.timer, size: 18, color: Colors.red),
                  const SizedBox(width: 4),
                  Text(
                    '${timeLeft ~/ 60}:${(timeLeft % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: Colors.red[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(isPortrait ? 16.0 : 32.0),
          child: Column(
            children: [
              // Progress indicator
              LinearProgressIndicator(
                value: (currentQuestion + 1) / questions.length,
                backgroundColor: Colors.grey[200],
                color: Colors.blue[800],
                minHeight: 6,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${currentQuestion + 1}/${questions.length}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: _showQuestionList,
                    child: const Text(
                      'View all questions',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Question card
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            current['question'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Options
                          ...current['options'].asMap().entries.map((entry) {
                            int idx = entry.key;
                            String option = entry.value;
                            bool isSelected = answers[currentQuestion] != null;
                            bool isCorrect = idx == current['correct'];
                            
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  setState(() {
                                    answers[currentQuestion] = isCorrect;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? (isCorrect 
                                            ? Colors.green[50] 
                                            : Colors.red[50])
                                        : Colors.grey[50],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? (isCorrect 
                                              ? Colors.green 
                                              : Colors.red)
                                          : Colors.grey[300]!,
                                      width: 1.5,
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
                                        color: isSelected
                                            ? (isCorrect 
                                                ? Colors.green 
                                                : Colors.red)
                                            : Colors.grey,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          option,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: isSelected
                                                ? (isCorrect 
                                                    ? Colors.green[800] 
                                                    : Colors.red[800])
                                                : Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          
                          // Explanation (shown after answering)
                          if (answers[currentQuestion] != null) ...[
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.blue[200]!,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Explanation:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(current['explanation']),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              // Navigation buttons
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: currentQuestion > 0 
                          ? () => setState(() => currentQuestion--) 
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.blue[800]!),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_back, size: 18),
                          SizedBox(width: 8),
                          Text('Previous'),
                        ],
                      ),
                    ),
                    
                    ElevatedButton(
                      onPressed: currentQuestion < questions.length - 1
                          ? () => setState(() => currentQuestion++)
                          : () => _submitQuiz(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            currentQuestion < questions.length - 1 
                                ? 'Next' 
                                : 'Submit',
                          ),
                          if (currentQuestion < questions.length - 1) ...[
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward, size: 18),
                          ],
                        ],
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

// Trang tổng kết
class SummaryScreen extends StatelessWidget {
  final String week;
  final List<bool?> answers;
  final List<Map<String, dynamic>> questions;

  const SummaryScreen({
    super.key, 
    required this.week, 
    required this.answers, 
    required this.questions
  });

  @override
  Widget build(BuildContext context) {
    final correctCount = answers.where((a) => a == true).length;
    final scorePercentage = (correctCount / questions.length * 100).round();
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Results - $week',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 24.0),
        child: Column(
          children: [
            // Result summary card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      scorePercentage >= 70 ? Icons.celebration : Icons.school,
                      size: 60,
                      color: scorePercentage >= 70 ? Colors.amber : Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      scorePercentage >= 70 
                          ? 'Excellent Work!' 
                          : 'Keep Practicing!',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You completed the $week quiz',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildScoreCircle(
                          context, 
                          'Score', 
                          '$scorePercentage%', 
                          _getScoreColor(scorePercentage)
                        ),
                        _buildScoreCircle(
                          context, 
                          'Correct', 
                          '$correctCount', 
                          Colors.green
                        ),
                        _buildScoreCircle(
                          context, 
                          'Incorrect', 
                          '${questions.length - correctCount}', 
                          Colors.red
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Detailed results
            Expanded(
              child: ListView.separated(
                itemCount: questions.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final question = questions[index];
                  final isCorrect = answers[index] == true;
                  final userAnswer = answers[index];
                  
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundColor: isCorrect ? Colors.green[50] : Colors.red[50],
                        foregroundColor: isCorrect ? Colors.green : Colors.red,
                        child: Icon(isCorrect ? Icons.check : Icons.close),
                      ),
                      title: Text(
                        'Question ${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        userAnswer == null 
                            ? 'Not answered' 
                            : (isCorrect ? 'Correct' : 'Incorrect'),
                        style: TextStyle(
                          color: userAnswer == null 
                              ? Colors.grey 
                              : (isCorrect ? Colors.green : Colors.red),
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                question['question'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Correct answer:',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.green[100]!,
                                  ),
                                ),
                                child: Text(
                                  question['options'][question['correct']],
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (question.containsKey('explanation')) ...[
                                const SizedBox(height: 12),
                                Text(
                                  'Explanation:',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  question['explanation'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Action buttons
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.blue[800]!),
                      ),
                      child: const Text(
                        'Back to Quiz',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TestScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Try Again',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
    );
  }

  Widget _buildScoreCircle(BuildContext context, String title, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Color _getScoreColor(int percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 50) return Colors.amber;
    return Colors.red;
  }
}

// Placeholder for TestScreen
class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Screen')),
      body: const Center(child: Text('Test Screen Content')),
    );
  }
}