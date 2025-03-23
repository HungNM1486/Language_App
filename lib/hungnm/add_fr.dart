import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Package để tạo mã QR
import 'package:share_plus/share_plus.dart'; // Package để chia sẻ
import 'package:clipboard/clipboard.dart'; // Package clipboard mới
import 'package:language_app/hungnm/profile.dart';
import 'package:language_app/hungnm/find_fr.dart';


class AddFrScreen extends StatelessWidget {
  const AddFrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = (size.width / 375).clamp(0.8, 1.2); // Responsive ratio

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0 * pix),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60 * pix), // Khoảng trống cho TopBar
                  Text(
                    'Thêm bạn bè',
                    style: TextStyle( 
                      fontSize: 24 * pix,
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20 * pix),
                  // Lựa chọn "Tìm theo tên"
                  _buildOptionTile(
                    context: context,
                    icon: Icons.person_search,
                    title: 'Tìm theo tên',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FindFrSreen ()),
                      );
                    },
                    pix: pix,
                  ),
                  SizedBox(height: 16 * pix),
                  // Lựa chọn "Chia sẻ đường dẫn"
                  _buildOptionTile(
                    context: context,
                    icon: Icons.share,
                    title: 'Chia sẻ đường dẫn',
                    onTap: () {
                      _showShareOptions(context, pix);
                    },
                    pix: pix,
                  ),
                ],
              ),
            ),
          ),
          // TopBar với dấu X
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopBar(context, pix),
          ),
        ],
      ),
    );
  }

  // Widget TopBar với dấu X
  Widget _buildTopBar(BuildContext context, double pix) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * pix, vertical: 10 * pix),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.close, size: 28 * pix),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  // Widget cho mỗi lựa chọn (Tìm theo tên, Chia sẻ đường dẫn)
  Widget _buildOptionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required double pix,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12 * pix),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12 * pix),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6 * pix,
              offset: Offset(0, 2 * pix),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16 * pix,
              backgroundColor: const Color(0xff5B7BFE).withOpacity(0.1),
              child: Icon(icon, size: 20 * pix, color: const Color(0xff5B7BFE)),
            ),
            SizedBox(width: 12 * pix),
            Text(
              title,
              style: TextStyle(
                fontSize: 16 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hiển thị modal bottom sheet chứa mã QR và tùy chọn chia sẻ
  void _showShareOptions(BuildContext context, double pix) {
    const String inviteLink = 'https://example.com/invite/abc123'; // Đường dẫn mẫu
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20 * pix),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Chia sẻ mã QR',
                style: TextStyle(
                  fontSize: 18 * pix,
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20 * pix),
              QrImageView(
                data: inviteLink,
                version: QrVersions.auto,
                size: 150 * pix,
                backgroundColor: Colors.grey[200]!,
                padding: EdgeInsets.all(10 * pix),
              ),
              SizedBox(height: 20 * pix),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.message, size: 30 * pix, color: const Color(0xff5B7BFE)),
                    onPressed: () {
                      Share.share('Mời bạn tham gia: $inviteLink', subject: 'Chia sẻ qua tin nhắn');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.email, size: 30 * pix, color: const Color(0xff5B7BFE)),
                    onPressed: () {
                      Share.share('Mời bạn tham gia: $inviteLink', subject: 'Chia sẻ qua email');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.copy, size: 30 * pix, color: const Color(0xff5B7BFE)),
                    onPressed: () {
                      FlutterClipboard.copy(inviteLink).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Đã sao chép: $inviteLink')),
                        );
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
