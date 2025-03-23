import 'package:flutter/material.dart';
import 'package:language_app/phunv/LoginSignup/signup_screen.dart';
import 'package:language_app/phunv/home_screen.dart';
import 'package:language_app/res/imagesLA/app_images.dart';

// Màn hình đăng nhập với hai trạng thái: intro và form đăng nhập
class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool isIntro = true; // Hiển thị màn hình intro ban đầu
  bool _obscureText = true; // Ẩn/hiện mật khẩu

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Kích thước màn hình
    final pix = size.width / 375; // Tỷ lệ responsive dựa trên chiều rộng 375px

    return Scaffold(
      body: isIntro
          ? _buildIntroScreen(size, pix) // Màn hình giới thiệu
          : _buildLoginForm(size, pix), // Form đăng nhập
    );
  }

  // Xây dựng màn hình intro
  Widget _buildIntroScreen(Size size, double pix) {
    return InkWell(
      onTap: () {
        setState(() {
          isIntro = false; // Chuyển sang form đăng nhập khi nhấn
        });
      },
      child: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.intro), // Ảnh intro toàn màn hình
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // Xây dựng form đăng nhập
  Widget _buildLoginForm(Size size, double pix) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(size, pix), // Thanh tiêu đề
          _buildAvatar(pix), // Avatar trung tâm
          _buildEmailField(size, pix), // Trường nhập email
          SizedBox(height: 16 * pix),
          _buildPasswordField(size, pix), // Trường nhập mật khẩu
          _buildForgotPassword(size, pix), // Link quên mật khẩu
          SizedBox(height: 69 * pix),
          _buildLoginButton(size, pix), // Nút đăng nhập
          SizedBox(height: 10 * pix),
          _buildDivider(size, pix), // Dòng "Or"
          _buildSignupLink(size, pix), // Link đăng ký
        ],
      ),
    );
  }

  // Thanh tiêu đề với nút quay lại
  Widget _buildHeader(Size size, double pix) {
    return Container(
      height: 100 * pix,
      width: size.width,
      color: const Color(0xff43AAFF), // Màu nền xanh
      child: Row(
        children: [
          Container(
            width: 50 * pix,
            margin: EdgeInsets.only(top: 16 * pix),
            child: IconButton(
              onPressed: () {
                setState(() {
                  isIntro = true; // Quay lại intro
                });
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
          ),
          SizedBox(
            width: size.width - 100 * pix,
            height: 80 * pix,
            child: Padding(
              padding: EdgeInsets.only(top: 30 * pix),
              child: Text(
                'Đăng nhập',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24 * pix,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'BeVietnamPro',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Avatar người học
  Widget _buildAvatar(double pix) {
    return Center(
      child: Container(
        width: 188 * pix,
        height: 188 * pix,
        padding: EdgeInsets.all(10 * pix),
        child: Image.asset(AppImages.personlearn1), // Ảnh minh họa
      ),
    );
  }

  // Trường nhập email
  Widget _buildEmailField(Size size, double pix) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16 * pix),
          child: Text(
            'Email',
            style: TextStyle(
              fontSize: 14 * pix,
              fontFamily: 'BeVietnamPro',
              color: Colors.black,
            ),
          ),
        ),
        Container(
          width: size.width,
          height: 56 * pix,
          margin: EdgeInsets.symmetric(horizontal: 16 * pix),
          padding: EdgeInsets.only(left: 16 * pix),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(16 * pix),
          ),
          child: const TextField(
            decoration: InputDecoration(
              labelText: 'Nhập email của bạn',
              labelStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'BeVietnamPro',
                color: Colors.grey,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  // Trường nhập mật khẩu
  Widget _buildPasswordField(Size size, double pix) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16 * pix),
          child: Text(
            'Mật khẩu',
            style: TextStyle(
              fontSize: 14 * pix,
              fontFamily: 'BeVietnamPro',
              color: Colors.black,
            ),
          ),
        ),
        Container(
          width: size.width,
          height: 56 * pix,
          margin: EdgeInsets.symmetric(horizontal: 16 * pix),
          padding: EdgeInsets.only(left: 16 * pix),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(16 * pix),
          ),
          child: TextField(
            obscureText: _obscureText, // Ẩn mật khẩu
            decoration: InputDecoration(
              labelText: 'Mật khẩu',
              labelStyle: TextStyle(
                fontSize: 14 * pix,
                fontFamily: 'BeVietnamPro',
                color: Colors.grey,
              ),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // Chuyển đổi ẩn/hiện
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Link "Quên mật khẩu"
  Widget _buildForgotPassword(Size size, double pix) {
    return InkWell(
      onTap: () {}, // Chưa xử lý quên mật khẩu
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16 * pix),
        child: SizedBox(
          width: size.width,
          height: 20 * pix,
          child: Text(
            'Quên mật khẩu?',
            style: TextStyle(
              fontSize: 14 * pix,
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w500,
              color: Colors.red[400],
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }

  // Nút đăng nhập
  Widget _buildLoginButton(Size size, double pix) {
    return Padding(
      padding: EdgeInsets.all(16 * pix),
      child: InkWell(
        onTap: () {
          // Chuyển sang HomeScreen sau khi đăng nhập
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Homescreen()),
          );
        },
        child: Container(
          width: size.width,
          height: 56 * pix,
          decoration: BoxDecoration(
            color: const Color(0xff5B7BFE), // Màu xanh nút
            borderRadius: BorderRadius.circular(16 * pix),
          ),
          child: Center(
            child: Text(
              'Đăng nhập',
              style: TextStyle(
                fontSize: 20 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Dòng phân cách "Or"
  Widget _buildDivider(Size size, double pix) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * pix),
      child: SizedBox(
        width: size.width,
        height: 20 * pix,
        child: Text(
          'Or',
          style: TextStyle(
            fontSize: 14 * pix,
            fontFamily: 'BeVietnamPro',
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Link đăng ký
  Widget _buildSignupLink(Size size, double pix) {
    return SizedBox(
      width: size.width,
      height: 56 * pix,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Bạn chưa có tài khoản?',
            style: TextStyle(
              fontSize: 14 * pix,
              fontFamily: 'BeVietnamPro',
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              // Chuyển sang SignupScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Signupscreen()),
              );
            },
            child: Text(
              ' Đăng ký',
              style: TextStyle(
                fontSize: 14 * pix,
                fontFamily: 'BeVietnamPro',
                color: const Color(0xff5B7BFE),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
