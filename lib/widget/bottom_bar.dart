import 'package:flutter/material.dart';
import 'package:language_app/phunv/LoginSignup/login_screen.dart';
import 'package:language_app/phunv/home_screen.dart';
import 'package:language_app/phunv/vocabulary_topic_screen.dart';
import 'package:language_app/res/imagesLA/app_images.dart';
import 'package:language_app/res/theme/app_colors.dart';
import 'package:language_app/hungnm/profile.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key, required this.type});
  final int type;

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 375;
    return Container(
      height: 60 * pix, // Tăng chiều cao để chứa thêm nhãn
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white, // Màu nền trắng
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).toInt()),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Homescreen()),
              );
            },
            image: AppImages.iconhome,
            label: 'Home', // Thêm nhãn
            enabled: widget.type == 1,
          ),
          _buildActionButton(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const VocabularyTopicscreen()),
              );
            },
            image: AppImages.iconvocabulary,
            label: 'Vocabulary', // Thêm nhãn
            enabled: widget.type == 2,
          ),
          _buildActionButton(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Loginscreen()),
              );
            },
            image: AppImages.iconstudy,
            label: 'Study', // Thêm nhãn
            enabled: widget.type == 3,
          ),
          _buildActionButton(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Loginscreen()),
              );
            },
            image: AppImages.icontest,
            label: 'Test', // Thêm nhãn
            enabled: widget.type == 4,
          ),
          _buildActionButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            image: AppImages.iconprofile,
            label: 'Profile', // Thêm nhãn
            enabled: widget.type == 5,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onTap,
    required String image,
    required String label,
    required bool enabled,
  }) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 375;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40 * pix,
            width: 40 * pix,
            decoration: BoxDecoration(
              color: enabled
                  ? AppColors.primary.withAlpha((0.2 * 255).toInt())
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Image.asset(
                image,
                width: 24 * pix,
                height: 24 * pix,
                color: enabled
                    ? AppColors.primary
                    : Colors.grey, // Thay đổi màu icon khi active
              ),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12 * pix,
              color: enabled
                  ? AppColors.primary
                  : Colors.grey, // Thay đổi màu nhãn khi active
              fontWeight: enabled ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
