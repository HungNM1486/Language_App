import 'package:flutter/material.dart';
import 'package:language_app/hungnm/test/vocab_game/vocabulary_game_play_screen.dart';

// Dữ liệu mẫu bảng xếp hạng bạn bè
final List<Map<String, dynamic>> leaderboard = [
  {'name': 'Nguyen Van A', 'time': 120}, // 2 phút
  {'name': 'Tran Thi B', 'time': 150},
  {'name': 'Le Van C', 'time': 180},
];

class VocabularyTopicScreen extends StatelessWidget {
  final String topic;
  const VocabularyTopicScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chủ đề: $topic'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * pix),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bảng xếp hạng bạn bè',
              style: TextStyle(
                fontSize: 20 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16 * pix),
            ...leaderboard.map((entry) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8 * pix),
                child: Container(
                  padding: EdgeInsets.all(12 * pix),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12 * pix),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry['name'],
                        style: TextStyle(fontSize: 16 * pix, fontFamily: 'BeVietnamPro'),
                      ),
                      Text(
                        '${entry['time'] ~/ 60}:${(entry['time'] % 60).toString().padLeft(2, '0')}',
                        style: TextStyle(fontSize: 16 * pix, fontFamily: 'BeVietnamPro', color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 24 * pix),
            Text(
              'Thành tích của bạn',
              style: TextStyle(
                fontSize: 20 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8 * pix),
            Container(
              padding: EdgeInsets.all(12 * pix),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12 * pix),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chưa hoàn thành',
                    style: TextStyle(fontSize: 16 * pix, fontFamily: 'BeVietnamPro'),
                  ),
                  Text(
                    '--:--',
                    style: TextStyle(fontSize: 16 * pix, fontFamily: 'BeVietnamPro', color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VocabularyGamePlayScreen(topic: topic)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16 * pix),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * pix)),
                ),
                child: Text(
                  'Bắt đầu',
                  style: TextStyle(
                    fontSize: 18 * pix,
                    fontFamily: 'BeVietnamPro',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}