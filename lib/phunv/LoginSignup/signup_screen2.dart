import 'package:flutter/material.dart';
import 'package:language_app/phunv/LoginSignup/login_screen.dart';
import 'package:language_app/phunv/LoginSignup/SelectLanguage/start_1screen.dart';
import 'package:language_app/res/imagesLA/app_images.dart';

class Signupscreen2 extends StatefulWidget {
  const Signupscreen2({super.key});

  @override
  State<Signupscreen2> createState() => _Signupscreen2State();
}

class _Signupscreen2State extends State<Signupscreen2> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 375;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100 * pix,
              width: size.width,
              color: const Color(0xff43AAFF),
              child: Row(
                children: [
                  SizedBox(
                    width: pix * 50,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width - 100 * pix,
                    height: 80 * pix,
                    padding: EdgeInsets.only(top: 30 * pix),
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24 * pix,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'BeVietnamPro'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: 175 * pix,
                height: 180 * pix,
                margin: EdgeInsets.only(top: 20 * pix, left: 20 * pix),
                padding: EdgeInsets.all(10 * pix),
                child: Image.asset(AppImages.personlearn2),
              ),
            ),
            Container(
              width: size.width,
              height: 20 * pix,
              padding: EdgeInsets.only(left: 16 * pix, right: 20 * pix),
              margin: EdgeInsets.only(bottom: 5 * pix),
              child: Text(
                'Mật khẩu',
                style: TextStyle(
                    fontSize: 14 * pix,
                    fontFamily: 'BeVietnamPro',
                    color: Colors.black),
                textAlign: TextAlign.left,
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
                obscureText: _obscureText1,
                decoration: InputDecoration(
                  labelText: 'Nhập mật khẩu',
                  labelStyle: TextStyle(
                    fontSize: 14 * pix,
                    fontFamily: 'BeVietnamPro',
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText1 ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText1 = !_obscureText1;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16 * pix,
            ),
            Container(
              width: size.width,
              height: 20 * pix,
              padding: EdgeInsets.only(left: 16 * pix, right: 20 * pix),
              margin: EdgeInsets.only(bottom: 5 * pix),
              child: Text(
                'Xác nhận mật khẩu',
                style: TextStyle(
                    fontSize: 14 * pix,
                    fontFamily: 'BeVietnamPro',
                    color: Colors.black),
                textAlign: TextAlign.left,
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
                obscureText: _obscureText2,
                decoration: InputDecoration(
                  labelText: 'Nhập lại mật khẩu',
                  labelStyle: TextStyle(
                    fontSize: 14 * pix,
                    fontFamily: 'BeVietnamPro',
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText2 ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText2 = !_obscureText2;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 89 * pix,
            ),
            Padding(
              padding: EdgeInsets.all(16 * pix),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Start1screen()));
                },
                child: Container(
                  width: size.width,
                  height: 56 * pix,
                  margin: EdgeInsets.only(top: 16 * pix),
                  padding: EdgeInsets.only(
                      left: 16 * pix, right: 16 * pix, top: 12 * pix),
                  decoration: BoxDecoration(
                    color: const Color(0xff5B7BFE),
                    borderRadius: BorderRadius.circular(16 * pix),
                  ),
                  child: Text('Đăng ký',
                      style: TextStyle(
                          fontSize: 20 * pix,
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
            SizedBox(
              height: 10 * pix,
            ),
            Container(
              width: size.width,
              height: 20 * pix,
              padding: EdgeInsets.only(left: 16 * pix, right: 16 * pix),
              child: Text('Or',
                  style: TextStyle(
                      fontSize: 14 * pix,
                      fontFamily: 'BeVietnamPro',
                      color: Colors.black),
                  textAlign: TextAlign.center),
            ),
            Container(
              width: size.width,
              height: 56 * pix,
              padding: EdgeInsets.only(
                  left: 66 * pix, right: 16 * pix, top: 12 * pix),
              child: Row(
                children: [
                  Text('Bạn đã có tài khoản?',
                      style: TextStyle(
                          fontSize: 14 * pix,
                          fontFamily: 'BeVietnamPro',
                          color: Colors.black),
                      textAlign: TextAlign.center),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Loginscreen()));
                    },
                    child: Text(' Đăng nhập',
                        style: TextStyle(
                            fontSize: 14 * pix,
                            fontFamily: 'BeVietnamPro',
                            color: const Color(0xff5B7BFE)),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
