import 'package:flutter/material.dart';
import 'package:language_app/hungnm/test/vocab_game/vocabulary_topic_screen.dart';

// Dữ liệu mẫu các chủ đề
final List<Map<String, String>> topics = [
  {'name': 'Động vật', 'description': 'Từ vựng về động vật'},
  {'name': 'Thực phẩm', 'description': 'Từ vựng về đồ ăn'},
  {'name': 'Giao thông', 'description': 'Từ vựng về phương tiện'},
];

class VocabularyGameScreen extends StatelessWidget {
  const VocabularyGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pix = (MediaQuery.of(context).size.width / 375).clamp(0.8, 1.2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trò chơi từ vựng'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * pix),
        child: Column(
          children: topics.map((topic) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8 * pix),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VocabularyTopicScreen(topic: topic['name']!),
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
                    children: [
                      Icon(Icons.book, size: 24 * pix, color: Colors.blue),
                      SizedBox(width: 16 * pix),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            topic['name']!,
                            style: TextStyle(
                              fontSize: 18 * pix,
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4 * pix),
                          Text(
                            topic['description']!,
                            style: TextStyle(
                              fontSize: 14 * pix,
                              fontFamily: 'BeVietnamPro',
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}