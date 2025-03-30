import 'package:flutter/material.dart';
import 'dart:async';
import 'vocabulary_summary_screen.dart';

class VocabularyGamePlayScreen extends StatefulWidget {
  final String topic;
  const VocabularyGamePlayScreen({super.key, required this.topic});

  @override
  State<VocabularyGamePlayScreen> createState() => _VocabularyGamePlayScreenState();
}

class _VocabularyGamePlayScreenState extends State<VocabularyGamePlayScreen> {
  int currentGame = 1;
  int totalScore = 0;
  int gameTime = 0;

  @override
  void initState() {
    super.initState();
    _startGameTimer();
  }

  void _startGameTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => gameTime++);
    });
  }

  void _nextGame(int score) {
    setState(() {
      totalScore += score;
      currentGame++;
    });
  }

  void _showCongratsDialog(int gameNumber, int score) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20 * pix)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.celebration, size: 80 * pix, color: Colors.yellow),
            SizedBox(height: 16 * pix),
            Text(
              'Chúc mừng bạn đã hoàn thành Game $gameNumber!',
              style: TextStyle(
                fontSize: 20 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8 * pix),
            Text(
              'Điểm: $score',
              style: TextStyle(
                fontSize: 18 * pix,
                fontFamily: 'BeVietnamPro',
                color: Colors.green,
              ),
            ),
            SizedBox(height: 24 * pix),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Đóng dialog
                _nextGame(score); // Chuyển sang game tiếp theo
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24 * pix, vertical: 12 * pix),
                backgroundColor: Colors.blueAccent,
              ),
              child: Text(
                gameNumber < 3 ? 'Bắt đầu Game ${gameNumber + 1}' : 'Xem tổng kết',
                style: TextStyle(
                  fontSize: 18 * pix,
                  fontFamily: 'BeVietnamPro',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);

    Widget currentGameWidget;
    switch (currentGame) {
      case 1:
        currentGameWidget = Game1(onComplete: (score) => _showCongratsDialog(1, score));
        break;
      case 2:
        currentGameWidget = Game2(onComplete: (score) => _showCongratsDialog(2, score));
        break;
      case 3:
        currentGameWidget = Game3(onComplete: (score) {
          totalScore += score;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VocabularySummaryScreen(score: totalScore, time: gameTime),
            ),
          );
        });
        break;
      default:
        currentGameWidget = const SizedBox();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Trò chơi - ${widget.topic}'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: currentGameWidget,
    );
  }
}

// Game 1: Nối từ
class Game1 extends StatefulWidget {
  final Function(int) onComplete;
  const Game1({super.key, required this.onComplete});

  @override
  State<Game1> createState() => _Game1State();
}

class _Game1State extends State<Game1> {
  List<Map<String, dynamic>> words = [
    {'en': 'Dog', 'vi': 'Chó', 'visible': true},
    {'en': 'Cat', 'vi': 'Mèo', 'visible': true},
    {'en': 'Bird', 'vi': 'Chim', 'visible': true},
    {'en': 'Fish', 'vi': 'Cá', 'visible': true},
    {'en': 'Horse', 'vi': 'Ngựa', 'visible': true},
  ];
  List<int?> selected = [null, null];
  int score = 0;
  bool isWrong = false;

  void _checkPair() {
    if (selected[0] != null && selected[1] != null) {
      final enIdx = selected[0]! ~/ 2;
      final viIdx = selected[1]! ~/ 2;
      if (words[enIdx]['en'] == 'Dog' && words[viIdx]['vi'] == 'Chó' ||
          words[enIdx]['en'] == 'Cat' && words[viIdx]['vi'] == 'Mèo' ||
          words[enIdx]['en'] == 'Bird' && words[viIdx]['vi'] == 'Chim' ||
          words[enIdx]['en'] == 'Fish' && words[viIdx]['vi'] == 'Cá' ||
          words[enIdx]['en'] == 'Horse' && words[viIdx]['vi'] == 'Ngựa') {
        setState(() {
          words[enIdx]['visible'] = false;
          words[viIdx]['visible'] = false;
          score += 20;
          selected = [null, null];
          isWrong = false;
        });
        if (words.every((w) => !w['visible'])) {
          widget.onComplete(score); // Gọi khi hoàn thành
        }
      } else {
        setState(() => isWrong = true);
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) setState(() {
            selected = [null, null];
            isWrong = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);
    return Padding(
      padding: EdgeInsets.all(16 * pix),
      child: Column(
        children: [
          Text(
            'Game 1: Nối từ',
            style: TextStyle(fontSize: 20 * pix, fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 16 * pix),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8 * pix,
              mainAxisSpacing: 8 * pix,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              final word = words[index ~/ 2];
              final isEnglish = index % 2 == 0;
              if (!word['visible']) return const SizedBox();
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (selected[0] == null) selected[0] = index;
                    else if (selected[1] == null && selected[0] != index) selected[1] = index;
                    _checkPair();
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8 * pix),
                  decoration: BoxDecoration(
                    color: selected.contains(index) ? Colors.blueAccent : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8 * pix),
                    border: Border.all(color: isWrong && selected.contains(index) ? Colors.red : Colors.transparent),
                  ),
                  child: Center(
                    child: Text(
                      isEnglish ? word['en'] : word['vi'],
                      style: TextStyle(fontSize: 14 * pix, fontFamily: 'BeVietnamPro'),
                    ),
                  ),
                ),
              );
            },
          ),
          if (isWrong)
            Padding(
              padding: EdgeInsets.only(top: 16 * pix),
              child: Text(
                'Sai rồi, thử lại!',
                style: TextStyle(fontSize: 16 * pix, fontFamily: 'BeVietnamPro', color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}

// Game 2: Trộn từ
class Game2 extends StatefulWidget {
  final Function(int) onComplete;
  const Game2({super.key, required this.onComplete});

  @override
  State<Game2> createState() => _Game2State();
}

class _Game2State extends State<Game2> {
  final List<String> words = ['Apple', 'Banana', 'Orange', 'Grape'];
  int currentWordIndex = 0;
  String scrambled = '';
  String userInput = '';
  int score = 0;

  @override
  void initState() {
    super.initState();
    _scrambleWord();
  }

  void _scrambleWord() {
    final word = words[currentWordIndex];
    scrambled = (word.split('')..shuffle()).join();
  }

  void _checkWord() {
    if (userInput.toLowerCase() == words[currentWordIndex].toLowerCase()) {
      setState(() {
        score += 25;
        currentWordIndex++;
        userInput = '';
        if (currentWordIndex < words.length) _scrambleWord();
        else widget.onComplete(score);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);
    return Padding(
      padding: EdgeInsets.all(16 * pix),
      child: Column(
        children: [
          Text(
            'Game 2: Trộn từ',
            style: TextStyle(fontSize: 20 * pix, fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 16 * pix),
          if (currentWordIndex < words.length) ...[
            Text(
              'Sắp xếp lại: $scrambled',
              style: TextStyle(fontSize: 18 * pix, fontFamily: 'BeVietnamPro'),
            ),
            SizedBox(height: 16 * pix),
            TextField(
              onChanged: (value) => setState(() => userInput = value),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12 * pix)),
                hintText: 'Nhập từ',
              ),
            ),
            SizedBox(height: 16 * pix),
            ElevatedButton(
              onPressed: _checkWord,
              child: Text('Kiểm tra', style: TextStyle(fontFamily: 'BeVietnamPro')),
            ),
          ],
        ],
      ),
    );
  }
}

// Game 3: Thử thách nghe
class Game3 extends StatefulWidget {
  final Function(int) onComplete;
  const Game3({super.key, required this.onComplete});

  @override
  State<Game3> createState() => _Game3State();
}

class _Game3State extends State<Game3> {
  final List<String> words = ['Hello', 'World', 'Flutter', 'Dart'];
  int currentWordIndex = 0;
  String userInput = '';
  bool isChecked = false;
  bool isCorrect = false;
  int score = 0;

  void _playAudio() {
    print('Playing: ${words[currentWordIndex]}');
  }

  void _checkAnswer() {
    setState(() {
      isChecked = true;
      isCorrect = userInput.toLowerCase() == words[currentWordIndex].toLowerCase();
      if (isCorrect) score += 30;
    });
  }

  void _nextWord() {
    setState(() {
      currentWordIndex++;
      userInput = '';
      isChecked = false;
      if (currentWordIndex >= words.length) widget.onComplete(score);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);
    return Padding(
      padding: EdgeInsets.all(16 * pix),
      child: Column(
        children: [
          Text(
            'Game 3: Thử thách nghe',
            style: TextStyle(fontSize: 20 * pix, fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 16 * pix),
          if (currentWordIndex < words.length) ...[
            IconButton(
              onPressed: _playAudio,
              icon: Icon(Icons.volume_up, size: 40 * pix),
            ),
            SizedBox(height: 16 * pix),
            TextField(
              onChanged: (value) => setState(() {
                userInput = value;
                if (isChecked) isChecked = false;
              }),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12 * pix)),
                hintText: 'Điền từ bạn nghe được',
              ),
            ),
            SizedBox(height: 16 * pix),
            ElevatedButton(
              onPressed: isChecked && isCorrect ? _nextWord : _checkAnswer,
              style: ElevatedButton.styleFrom(
                backgroundColor: isChecked ? (isCorrect ? Colors.green : Colors.red) : null,
              ),
              child: Text(
                isChecked ? (isCorrect ? 'Tiếp tục' : 'Kiểm tra') : 'Kiểm tra',
                style: TextStyle(fontFamily: 'BeVietnamPro'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}