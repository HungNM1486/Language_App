import 'package:flutter/material.dart';
import 'package:language_app/phunv/LoginSignup/signup_screen.dart';
import 'package:language_app/phunv/home_screen.dart';
import 'package:language_app/res/imagesLA/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Thêm import

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
    final size = MediaQuery.of(context).size;
    final pix = size.width / 375;

    return Scaffold(
      body: isIntro
          ? _buildIntroScreen(size, pix)
          : _buildLoginForm(size, pix),
    );
  }

  Widget _buildIntroScreen(Size size, double pix) {
    return InkWell(
      onTap: () {
        setState(() {
          isIntro = false;
        });
      },
      child: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.intro),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(Size size, double pix) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(size, pix),
          _buildAvatar(pix),
          _buildEmailField(size, pix),
          SizedBox(height: 16 * pix),
          _buildPasswordField(size, pix),
          _buildForgotPassword(size, pix),
          SizedBox(height: 69 * pix),
          _buildLoginButton(size, pix),
          SizedBox(height: 10 * pix),
          _buildDivider(size, pix),
          _buildSignupLink(size, pix),
        ],
      ),
    );
  }

  Widget _buildHeader(Size size, double pix) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: 100 * pix,
      width: size.width,
      color: const Color(0xff43AAFF),
      child: Row(
        children: [
          Container(
            width: 50 * pix,
            margin: EdgeInsets.only(top: 16 * pix),
            child: IconButton(
              onPressed: () {
                setState(() {
                  isIntro = true;
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
                l10n.login, // Chuỗi đã dịch
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

  Widget _buildAvatar(double pix) {
    return Center(
      child: Container(
        width: 188 * pix,
        height: 188 * pix,
        padding: EdgeInsets.all(10 * pix),
        child: Image.asset(AppImages.personlearn1),
      ),
    );
  }

  Widget _buildEmailField(Size size, double pix) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16 * pix),
          child: Text(
            l10n.email, // Chuỗi đã dịch
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
            decoration: InputDecoration(
              labelText: l10n.enterYourEmail, // Chuỗi đã dịch
              labelStyle: const TextStyle(
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

  Widget _buildPasswordField(Size size, double pix) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16 * pix),
          child: Text(
            l10n.password, // Chuỗi đã dịch
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
            obscureText: _obscureText,
            decoration: InputDecoration(
              labelText: l10n.password, // Chuỗi đã dịch
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
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPassword(Size size, double pix) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16 * pix),
        child: SizedBox(
          width: size.width,
          height: 20 * pix,
          child: Text(
            l10n.forgotPassword, // Chuỗi đã dịch
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

  Widget _buildLoginButton(Size size, double pix) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.all(16 * pix),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Homescreen()),
          );
        },
        child: Container(
          width: size.width,
          height: 56 * pix,
          decoration: BoxDecoration(
            color: const Color(0xff5B7BFE),
            borderRadius: BorderRadius.circular(16 * pix),
          ),
          child: Center(
            child: Text(
              l10n.login, // Chuỗi đã dịch
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

  Widget _buildDivider(Size size, double pix) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * pix),
      child: SizedBox(
        width: size.width,
        height: 20 * pix,
        child: Text(
          l10n.or, // Chuỗi đã dịch
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

  Widget _buildSignupLink(Size size, double pix) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      width: size.width,
      height: 56 * pix,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.noAccount, // Chuỗi đã dịch
            style: TextStyle(
              fontSize: 14 * pix,
              fontFamily: 'BeVietnamPro',
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Signupscreen()),
              );
            },
            child: Text(
              l10n.signup, // Chuỗi đã dịch
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
