import 'package:flutter/material.dart';
import 'package:language_app/LoginSignup/login_screen.dart'; // Import màn hình đăng nhập
import 'package:language_app/phunv/home_screen.dart'; // Import màn hình chính
import 'package:language_app/phunv/vocabulary_topic_screen.dart'; // Import màn hình chủ đề từ vựng
import 'package:language_app/res/imagesLA/app_images.dart'; // Import danh sách ảnh (icon)
import 'package:language_app/res/theme/app_colors.dart'; // Import màu sắc chủ đề
import 'package:language_app/hungnm/profile/profile.dart'; // Import ProfileScreen

// Widget Bottombar là Stateful để quản lý trạng thái của thanh điều hướng dưới
class Bottombar extends StatefulWidget {
  const Bottombar(
      {super.key,
      required this.type}); // Constructor với tham số type để xác định nút nào được chọn
  final int type; // Biến type xác định nút đang active (1-5)

  @override
  State<Bottombar> createState() =>
      _BottombarState(); // Tạo state cho Bottombar
}

class _BottombarState extends State<Bottombar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Lấy kích thước màn hình
    final pix = size.width /
        375; // Tỷ lệ pixel dựa trên chiều rộng chuẩn 375px (để responsive)
    return Container(
      height: 64 * pix, // Chiều cao thanh bottom bar, tính theo tỷ lệ
      width: 312 * pix, // Chiều rộng thanh, tính theo tỷ lệ
      padding:
          EdgeInsets.symmetric(horizontal: 8 * pix), // Khoảng cách lề trái/phải
      decoration: BoxDecoration(
        color: const Color(0xffD1D1D6), // Màu nền xám nhạt cho thanh bottom
        borderRadius: BorderRadius.circular(50), // Bo góc tròn 50px
        border: Border.all(
          color: const Color.fromARGB(255, 130, 130, 130), // Viền màu xám đậm
          width: 1 * pix, // Độ dày viền theo tỷ lệ
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 0, 0, 0), // Màu bóng đen
            offset: Offset(0, 0), // Vị trí bóng (giữa)
            blurRadius: 5, // Độ mờ bóng
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround, // Các nút cách đều nhau
        children: [
          // Nút Home
          _buildActionButton(
              onTap: () {
                // Khi nhấn, chuyển sang màn hình HomeScreen
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Homescreen()));
              },
              image: AppImages.iconhome, // Icon Home từ AppImages
              enabled: widget.type == 1 ? true : false), // Active nếu type = 1

          // Nút Vocabulary
          _buildActionButton(
              onTap: () {
                // Khi nhấn, chuyển sang màn hình VocabularyTopicscreen
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VocabularyTopicscreen()));
              },
              image: AppImages.iconvocabulary, // Icon Vocabulary
              enabled: widget.type == 2 ? true : false), // Active nếu type = 2

          // Nút Study (dẫn đến LoginScreen)
          _buildActionButton(
              onTap: () {
                // Khi nhấn, chuyển sang màn hình LoginScreen
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Loginscreen()));
              },
              image: AppImages.iconstudy, // Icon Study
              enabled: widget.type == 3 ? true : false), // Active nếu type = 3

          // Nút Test (dẫn đến LoginScreen)
          _buildActionButton(
              onTap: () {
                // Khi nhấn, chuyển sang màn hình LoginScreen
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Loginscreen()));
              },
              image: AppImages.icontest, // Icon Test
              enabled: widget.type == 4 ? true : false), // Active nếu type = 4

          // Nút Profile (dẫn đến LoginScreen)
          _buildActionButton(
            onTap: () {
              // Khi nhấn, chuyển sang màn hình ProfileScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            image: AppImages.iconprofile, // Icon Profile
            enabled: widget.type == 5 ? true : false,
          ), // Active nếu type = 5
        ],
      ),
    );
  }

  // Hàm tạo nút hành động (button) trong bottom bar
  Widget _buildActionButton({
    required VoidCallback onTap, // Hàm xử lý khi nhấn
    required String image, // Đường dẫn ảnh icon
    required bool enabled, // Trạng thái active/inactive
  }) {
    final size = MediaQuery.of(context).size; // Lấy kích thước màn hình
    final pix = size.width / 375; // Tỷ lệ pixel
    return GestureDetector(
      onTap: onTap, // Gắn sự kiện nhấn
      child: Container(
        height: 56 * pix, // Chiều cao nút
        width: 56 * pix, // Chiều rộng nút
        decoration: BoxDecoration(
          color: enabled
              ? AppColors.primary
              : Colors
                  .transparent, // Màu primary nếu active, trong suốt nếu không
          borderRadius: BorderRadius.circular(50), // Bo tròn nút
        ),
        child: Center(
          child: Image.asset(image,
              width: 32 * pix,
              height: 32 * pix), // Hiển thị icon, kích thước theo tỷ lệ
        ),
      ),
    );
  }
}
