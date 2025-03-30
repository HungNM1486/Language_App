import 'package:flutter/material.dart';

// Danh sách bạn bè mẫu (có thể thay bằng dữ liệu thực từ API hoặc database)
final List<Map<String, String>> friendsList = [
  {'name': 'Nguyen Van A', 'joined': '3/2025'},
  {'name': 'Tran Thi B', 'joined': '4/2025'},
  {'name': 'Le Van C', 'joined': '5/2025'},
  // Thêm nhiều bạn bè hơn nếu cần
];

class FriendsListScreen extends StatelessWidget {
  const FriendsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = (size.width / 375).clamp(0.8, 1.2);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Danh sách bạn bè',
          style: TextStyle(
            fontSize: 20 * pix,
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10 * pix),
        itemCount: friendsList.length,
        itemBuilder: (context, index) {
          final friend = friendsList[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 5 * pix),
            child: ListTile(
              leading: CircleAvatar(
                radius: 20 * pix,
                backgroundImage:
                    const AssetImage('lib/res/imagesLA/personlearn1.png'),
              ),
              title: Text(
                friend['name']!,
                style: TextStyle(
                  fontSize: 16 * pix,
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                'Tham gia: ${friend['joined']}',
                style: TextStyle(
                  fontSize: 14 * pix,
                  fontFamily: 'BeVietnamPro',
                  color: Colors.grey,
                ),
              ),
              trailing: Icon(Icons.person, size: 24 * pix, color: Colors.blue),
            ),
          );
        },
      ),
    );
  }
}