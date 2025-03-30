import 'package:flutter/material.dart';

// Danh sách khóa học mẫu (có thể thay bằng dữ liệu thực từ API hoặc database)
final List<Map<String, String>> coursesList = [
  {'name': 'Tiếng Việt Cơ Bản', 'level': 'Sơ cấp'},
  {'name': 'Tiếng Anh Giao Tiếp', 'level': 'Trung cấp'},
  {'name': 'Tiếng Nhật N5', 'level': 'Cơ bản'},
  // Thêm nhiều khóa học hơn nếu cần
];

class CoursesListScreen extends StatelessWidget {
  const CoursesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = (size.width / 375).clamp(0.8, 1.2);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Danh sách khóa học',
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
        itemCount: coursesList.length,
        itemBuilder: (context, index) {
          final course = coursesList[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 5 * pix),
            child: ListTile(
              leading: Container(
                width: 40 * pix,
                height: 40 * pix,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8 * pix),
                  image: const DecorationImage(
                    image: AssetImage('lib/res/imagesLA/vietnam.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                course['name']!,
                style: TextStyle(
                  fontSize: 16 * pix,
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                'Cấp độ: ${course['level']}',
                style: TextStyle(
                  fontSize: 14 * pix,
                  fontFamily: 'BeVietnamPro',
                  color: Colors.grey,
                ),
              ),
              trailing: Icon(Icons.book, size: 24 * pix, color: Colors.blue),
            ),
          );
        },
      ),
    );
  }
}