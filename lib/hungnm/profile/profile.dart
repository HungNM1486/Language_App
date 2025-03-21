import 'package:flutter/material.dart';
import 'package:language_app/phunv/home_screen.dart';
import 'package:language_app/hungnm/profile/activity.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 1; // Index mặc định là Profile (1)

  // Danh sách các màn hình tương ứng
  final List<Widget> _widgetOptions = <Widget>[
    const Homescreen(), // Màn hình Home (index 0)
    const ProfileScreen(), // Màn hình Profile (index 1)
    const Center(
        child: Text('Settings')), // Màn hình Settings (index 2, tạm thời)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Điều hướng đến màn hình tương ứng (nếu cần)
    if (index != 1) {
      // Không điều hướng nếu đã ở Profile
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => _widgetOptions[index]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 375; // Responsive ratio

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40 * pix), // Khoảng cách phía trên
            _buildUserInfo(size, pix), // Phần thông tin người dùng
            _buildLanguageAndFriendsSection(size, pix), // Phần ngôn ngữ và bạn bè
            _buildActivitySection(size, pix), // Phần hoạt động
            _buildAchievementsSection(size, pix), // Phần thành tích
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50 * pix, // Định nghĩa chiều cao cố định
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff5B7BFE),
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          iconSize: 20 * pix, // Giảm kích thước icon
          selectedFontSize: 12 * pix, // Giảm kích thước chữ khi chọn
          unselectedFontSize: 12 * pix, // Giảm kích thước chữ khi không chọn
        ),
      ),
    );
  }

  // Phần thông tin người dùng: ảnh đại diện, tên, ngày tham gia
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

  // Widget mới: Hàng với 2 cột (Cờ ngôn ngữ và Số lượng bạn bè)
  Widget _buildLanguageAndFriendsSection(Size size, double pix) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25 * pix, vertical: 25 * pix),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Cột bên trái: Cờ ngôn ngữ và "Khóa học"
          Column(
            children: [
              Container(
                width: 70 * pix,
                height: 40 * pix,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * pix), // Bo góc
                  image: const DecorationImage(
                    image: AssetImage("lib/res/imagesLA/vietnam.jpg"), // Cờ ngôn ngữ
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
          // Đường kẻ sọc mờ phân cách
          Container(
            width: 1 * pix,
            height: 80 * pix,
            color: Colors.grey.withOpacity(0.3), // Đường kẻ mờ
          ),
          // Cột bên phải: Số lượng bạn bè và "Bạn bè"
          Column(
            children: [
              Text(
                '120', // Số lượng bạn bè (có thể thay bằng dữ liệu động)
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

  // Phần hoạt động
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
                  // Điều hướng đến ActivityScreen khi nhấn "Xem chi tiết"
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ActivityScreen()),
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
                  value: 'Ngày',
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24 * pix,
                  elevation: 16,
                  style: TextStyle(
                    fontSize: 14 * pix,
                    fontFamily: 'BeVietnamPro',
                    color: Colors.black,
                  ),
                  underline: const SizedBox(),
                  onChanged: (String? newValue) {},
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

  // Phần thành tích
  Widget _buildAchievementsSection(Size size, double pix) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * pix, vertical: 20 * pix),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề "Thành tích"
          Text(
            'Thành tích',
            style: TextStyle(
              fontSize: 20 * pix,
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20 * pix),
          // Danh sách thành tích (2 cột)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBadgeItem(pix, 'Huy hiệu 1', 'Mô tả huy hiệu 1',
                      'lib/res/imagesLA/coviet.png'),
                  SizedBox(width: 20 * pix),
                  _buildBadgeItem(pix, 'Huy hiệu 2', 'Mô tả huy hiệu 2',
                      'lib/res/imagesLA/coviet.png'),
                ],
              ),
              SizedBox(height: 15 * pix),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBadgeItem(pix, 'Huy hiệu 3', 'Mô tả huy hiệu 3',
                      'lib/res/imagesLA/coviet.png'),
                  SizedBox(width: 20 * pix),
                  _buildBadgeItem(pix, 'Huy hiệu 4', 'Mô tả huy hiệu 4',
                      'lib/res/imagesLA/coviet.png'),
                ],
              ),
              SizedBox(height: 15 * pix),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBadgeItem(pix, 'Huy hiệu 5', 'Mô tả huy hiệu 5',
                      'lib/res/imagesLA/coviet.png'),
                  SizedBox(width: 20 * pix),
                  _buildBadgeItem(pix, 'Huy hiệu 6', 'Mô tả huy hiệu 6',
                      'lib/res/imagesLA/coviet.png'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget cho mỗi huy hiệu (hình ảnh, tên, mô tả, trong khung riêng)
  Widget _buildBadgeItem(
      double pix, String title, String description, String imagePath) {
    return Container(
      width: 150 * pix, // Chiều rộng khung
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
