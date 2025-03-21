import 'package:flutter/material.dart';
import 'package:language_app/phunv/LoginSignup/SelectLanguage/start_2screen.dart'; // Màn hình tiếp theo sau chọn ngôn ngữ
import 'package:language_app/res/imagesLA/app_images.dart'; // Danh sách ảnh (cờ)

class SelectLanguescreen extends StatefulWidget {
  const SelectLanguescreen({super.key});

  @override
  State<SelectLanguescreen> createState() => _SelectLanguescreenState();
}

class _SelectLanguescreenState extends State<SelectLanguescreen> {
  // Danh sách ngôn ngữ với ảnh và tiêu đề
  final List<Map<String, String>> _listLanguages = [
    {'img': AppImages.coviet, "title": 'Tiếng Việt'},
    {'img': AppImages.comy, "title": 'Tiếng Anh'},
    {'img': AppImages.cohan, "title": 'Tiếng Hàn'},
    {'img': AppImages.cotrung, "title": 'Tiếng Trung'},
    {'img': AppImages.cophap, "title": 'Tiếng Pháp'},
    // Lặp lại để tạo danh sách dài
    {'img': AppImages.coviet, "title": 'Tiếng Việt'},
    {'img': AppImages.comy, "title": 'Tiếng Anh'},
    {'img': AppImages.cohan, "title": 'Tiếng Hàn'},
    {'img': AppImages.cotrung, "title": 'Tiếng Trung'},
    {'img': AppImages.cophap, "title": 'Tiếng Pháp'},
    {'img': AppImages.coviet, "title": 'Tiếng Việt'},
    {'img': AppImages.comy, "title": 'Tiếng Anh'},
    {'img': AppImages.cohan, "title": 'Tiếng Hàn'},
    {'img': AppImages.cotrung, "title": 'Tiếng Trung'},
    {'img': AppImages.cophap, "title": 'Tiếng Pháp'},
  ];
  int _selected = 0; // Chỉ số ngôn ngữ được chọn

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Kích thước màn hình
    final pix = size.width / 375; // Tỷ lệ pixel cho responsive
    return Scaffold(
      body: SingleChildScrollView(
        // Cho phép cuộn
        child: Column(
          children: [
            // Header với nút back và tiêu đề
            Container(
              height: 100 * pix,
              width: size.width,
              color: const Color(0xff43AAFF), // Màu xanh header
              child: Row(
                children: [
                  Container(
                    width: pix * 50,
                    margin: EdgeInsets.only(top: 16 * pix),
                    child: IconButton(
                      onPressed: () =>
                          Navigator.pop(context), // Quay lại màn hình trước
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                  ),
                  Container(
                    width: size.width - 100 * pix,
                    height: 80 * pix,
                    padding: EdgeInsets.only(top: 30 * pix),
                    child: Text(
                      'Chọn ngôn ngữ',
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
            // Danh sách ngôn ngữ và nút tiếp tục
            SizedBox(
              height: size.height - 100 * pix,
              width: size.width,
              child: Stack(
                children: [
                  // ListView hiển thị danh sách ngôn ngữ
                  Container(
                    height: size.height - 100 * pix,
                    width: size.width,
                    padding: EdgeInsets.only(top: 20 * pix),
                    child: ListView.builder(
                      itemCount: _listLanguages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: 16 * pix,
                              left: 24 * pix,
                              right: 24 * pix),
                          child: InkWell(
                            onTap: () {
                              setState(() => _selected =
                                  index); // Cập nhật ngôn ngữ được chọn
                            },
                            child: Container(
                              width: 327 * pix,
                              height: 62 * pix,
                              padding: EdgeInsets.all(5 * pix),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: _selected == index
                                    ? const Color(0xff40CEB6)
                                    : Colors.grey[
                                        300], // Màu xanh nếu được chọn, xám nếu không
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 52 * pix,
                                    width: 52 * pix,
                                    child: Image.asset(
                                        _listLanguages[index]['img']!,
                                        height: 52 * pix,
                                        width: 52 * pix),
                                  ),
                                  Container(
                                    height: 52 * pix,
                                    width: 250 * pix,
                                    padding: EdgeInsets.only(top: 10 * pix),
                                    child: Text(
                                      _listLanguages[index]
                                          ['title']!, // Tên ngôn ngữ
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18 * pix,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'BeVietnamPro'),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Nút "Tiếp tục" cố định ở dưới
                  Positioned(
                    bottom: 80 * pix,
                    left: 16 * pix,
                    right: 16 * pix,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Start2screen())); // Chuyển sang màn hình tiếp theo
                      },
                      child: Container(
                        width: size.width,
                        height: 56 * pix,
                        padding: EdgeInsets.only(
                            left: 16 * pix, right: 16 * pix, top: 12 * pix),
                        decoration: BoxDecoration(
                          color: const Color(0xff5B7BFE), // Màu xanh nút
                          borderRadius: BorderRadius.circular(16 * pix),
                        ),
                        child: Text(
                          'Tiếp tục',
                          style: TextStyle(
                              fontSize: 20 * pix,
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
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
