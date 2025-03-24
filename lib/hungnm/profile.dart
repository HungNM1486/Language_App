import 'package:flutter/material.dart';
import 'package:language_app/hungnm/activity.dart';
import 'package:language_app/widget/bottom_bar.dart';
import 'package:language_app/hungnm/add_fr.dart';
import 'package:language_app/hungnm/setting/setting.dart'; // Import file setting.dart
import 'package:qr_flutter/qr_flutter.dart'; // Package để tạo mã QR
import 'package:share_plus/share_plus.dart'; // Package để chia sẻ
import 'package:clipboard/clipboard.dart'; // Package clipboard

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _selectedTimeFilter = 'Ngày'; // Giá trị mặc định cho DropdownButton

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = (size.width / 375).clamp(0.8, 1.2); // Responsive ratio với giới hạn

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 80 * pix),
              child: Column(
                children: [
                  SizedBox(height: 40 * pix),
                  _buildUserInfo(size, pix),
                  _buildLanguageAndFriendsSection(size, pix),
                  _buildAddFriendAndShareSection(size, pix),
                  _buildActivitySection(size, pix),
                  _buildAchievementsSection(size, pix),
                ],
              ),
            ),
          ),
          // Icon Settings ở trên cùng bên phải
          Positioned(
            top: 40 * pix, // Điều chỉnh vị trí theo giao diện
            right: 16 * pix,
            child: IconButton(
              icon: Icon(Icons.settings, size: 28 * pix, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingScreen()),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Bottombar(type: 5),
    );
  }

  Widget _buildAddFriendAndShareSection(Size size, double pix) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25 * pix, vertical: 10 * pix),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddFrScreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(16 * pix),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10 * pix),
                  border: Border.all(
                    color: Colors.grey.withAlpha((0.3 * 255).toInt()),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add, size: 20 * pix, color: Colors.blue),
                    SizedBox(width: 10 * pix),
                    Text(
                      'Thêm bạn bè',
                      style: TextStyle(
                        fontSize: 16 * pix,
                        fontFamily: 'BeVietnamPro',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 10 * pix),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                _showShareOptions(context, pix);
              },
              child: Container(
                padding: EdgeInsets.all(16 * pix),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10 * pix),
                  border: Border.all(
                    color: Colors.grey.withAlpha((0.3 * 255).toInt()),
                  ),
                ),
                child: Icon(Icons.share, size: 20 * pix, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                    onPressed: () async {
                      await FlutterClipboard.copy(inviteLink);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đã sao chép: $inviteLink')),
                        );
                      }
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

  // Các phương thức khác giữ nguyên
  Widget _buildUserInfo(Size size, double pix) {
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: 20 * pix),
      child: Column(
        children: [
          Container(
            width: 100 * pix,
            height: 100 * pix,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 2 * pix),
              image: const DecorationImage(
                image: AssetImage('lib/res/imagesLA/personlearn1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10 * pix),
          Text(
            'HungNM1486',
            style: TextStyle(
              fontSize: 20 * pix,
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5 * pix),
          Text(
            'Tham gia vào 3/2025',
            style: TextStyle(
              fontSize: 14 * pix,
              fontFamily: 'BeVietnamPro',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageAndFriendsSection(Size size, double pix) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25 * pix, vertical: 25 * pix),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                width: 70 * pix,
                height: 40 * pix,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * pix),
                  image: const DecorationImage(
                    image: AssetImage("lib/res/imagesLA/vietnam.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 5 * pix),
              Text(
                'Khóa học',
                style: TextStyle(
                  fontSize: 16 * pix,
                  fontFamily: 'BeVietnamPro',
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Container(
            width: 1 * pix,
            height: 80 * pix,
            color: Colors.grey.withAlpha((0.3 * 255).toInt()),
          ),
          Column(
            children: [
              Text(
                '120',
                style: TextStyle(
                  fontSize: 30 * pix,
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5 * pix),
              Text(
                'Bạn bè',
                style: TextStyle(
                  fontSize: 16 * pix,
                  fontFamily: 'BeVietnamPro',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection(Size size, double pix) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * pix),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hoạt động',
                style: TextStyle(
                  fontSize: 18 * pix,
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ActivityScreen()),
                  );
                },
                child: Text(
                  'Xem chi tiết',
                  style: TextStyle(
                    fontSize: 14 * pix,
                    fontFamily: 'BeVietnamPro',
                    color: const Color(0xff5B7BFE),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10 * pix),
          Container(
            padding: EdgeInsets.all(16 * pix),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16 * pix),
            ),
            child: Row(
              children: [
                Container(
                  width: 40 * pix,
                  height: 40 * pix,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.notifications,
                    size: 24 * pix,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(width: 10 * pix),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thời gian học',
                        style: TextStyle(
                          fontSize: 16 * pix,
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '4h: 20p',
                        style: TextStyle(
                          fontSize: 14 * pix,
                          fontFamily: 'BeVietnamPro',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedTimeFilter,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24 * pix,
                  elevation: 16,
                  style: TextStyle(
                    fontSize: 14 * pix,
                    fontFamily: 'BeVietnamPro',
                    color: Colors.black,
                  ),
                  underline: const SizedBox(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedTimeFilter = newValue;
                      });
                    }
                  },
                  items: <String>['Ngày', 'Tuần', 'Tháng']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection(Size size, double pix) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * pix, vertical: 20 * pix),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thành tích',
            style: TextStyle(
              fontSize: 20 * pix,
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20 * pix),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBadgeItem(pix, 'Huy hiệu 1', 'Mô tả huy hiệu 1', 'lib/res/imagesLA/coviet.png'),
                  SizedBox(width: 20 * pix),
                  _buildBadgeItem(pix, 'Huy hiệu 2', 'Mô tả huy hiệu 2', 'lib/res/imagesLA/coviet.png'),
                ],
              ),
              SizedBox(height: 15 * pix),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBadgeItem(pix, 'Huy hiệu 3', 'Mô tả huy hiệu 3', 'lib/res/imagesLA/coviet.png'),
                  SizedBox(width: 20 * pix),
                  _buildBadgeItem(pix, 'Huy hiệu 4', 'Mô tả huy hiệu 4', 'lib/res/imagesLA/coviet.png'),
                ],
              ),
              SizedBox(height: 15 * pix),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBadgeItem(pix, 'Huy hiệu 5', 'Mô tả huy hiệu 5', 'lib/res/imagesLA/coviet.png'),
                  SizedBox(width: 20 * pix),
                  _buildBadgeItem(pix, 'Huy hiệu 6', 'Mô tả huy hiệu 6', 'lib/res/imagesLA/coviet.png'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeItem(double pix, String title, String description, String imagePath) {
    return Container(
      width: 150 * pix,
      padding: EdgeInsets.all(10 * pix),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12 * pix),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.3 * 255).toInt()),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80 * pix,
            height: 80 * pix,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[300]!, width: 1 * pix),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5 * pix),
          Text(
            title,
            style: TextStyle(
              fontSize: 15 * pix,
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 3 * pix),
          Text(
            description,
            style: TextStyle(
              fontSize: 12 * pix,
              fontFamily: 'BeVietnamPro',
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
