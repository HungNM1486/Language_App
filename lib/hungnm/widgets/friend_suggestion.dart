import 'package:flutter/material.dart';

class FriendSuggestionList extends StatelessWidget {
  final Size size;
  final double pix;
  final int itemCount; // Thêm tham số để tùy chỉnh số lượng gợi ý

  const FriendSuggestionList({
    super.key,
    required this.size,
    required this.pix,
    this.itemCount = 10, // Giá trị mặc định là 10
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height - 200 * pix,
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) => FriendItem(index: index, pix: pix),
      ),
    );
  }
}

class FriendItem extends StatelessWidget {
  final int index;
  final double pix;

  const FriendItem({super.key, required this.index, required this.pix});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0 * pix),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24 * pix,
          backgroundImage: const AssetImage('lib/res/imagesLA/personlearn1.png'),
        ),
        title: Text(
          'Người dùng $index',
          style: TextStyle(
            fontSize: 16 * pix,
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          'Gợi ý cho bạn',
          style: TextStyle(
            fontSize: 14 * pix,
            fontFamily: 'BeVietnamPro',
            color: Colors.grey,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Đã gửi lời mời đến Người dùng $index'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff5B7BFE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8 * pix),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16 * pix, vertical: 8 * pix),
            elevation: 2,
          ),
          child: Text(
            'Thêm',
            style: TextStyle(
              fontSize: 14 * pix,
              fontFamily: 'BeVietnamPro',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
