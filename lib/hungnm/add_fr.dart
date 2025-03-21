import 'package:flutter/material.dart';

class AddFriendScreen extends StatelessWidget {
  const AddFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm bạn bè'),
        backgroundColor: Colors.blue, // Màu nền của AppBar
        elevation: 0, // Bỏ bóng đổ
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ô tìm kiếm
            TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm bạn bè...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Danh sách bạn bè gợi ý
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Số lượng bạn bè gợi ý
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage('lib/res/imagesLA/personlearn1.png'), // Ảnh đại diện
                    ),
                    title: Text('Người dùng $index'),
                    subtitle: const Text('Gợi ý cho bạn'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Xử lý thêm bạn bè
                      },
                      child: const Text('Thêm'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}