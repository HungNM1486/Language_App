import 'package:flutter/material.dart';

class VocabularySummaryScreen extends StatelessWidget {
  final int score;
  final int time;
  const VocabularySummaryScreen({super.key, required this.score, required this.time});

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tổng kết trò chơi'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.celebration, size: 80 * pix, color: Colors.yellow),
            SizedBox(height: 16 * pix),
            Text(
              'Chúc mừng bạn đã hoàn thành!',
              style: TextStyle(fontSize: 20 * pix, fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8 * pix),
            Text(
              'Tổng điểm: $score',
              style: TextStyle(fontSize: 18 * pix, fontFamily: 'BeVietnamPro', color: Colors.green),
            ),
            SizedBox(height: 8 * pix),
            Text(
              'Thời gian: ${time ~/ 60}:${(time % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 18 * pix, fontFamily: 'BeVietnamPro', color: Colors.blue),
            ),
            SizedBox(height: 24 * pix),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24 * pix, vertical: 12 * pix),
                backgroundColor: Colors.blueAccent,
              ),
              child: Text(
                'Quay về',
                style: TextStyle(fontSize: 18 * pix, fontFamily: 'BeVietnamPro', color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}