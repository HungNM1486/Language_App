import 'package:flutter/material.dart';
import 'package:language_app/widget/top_bar.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _selectedTabIndex = 0; // Trạng thái lựa chọn (0: Ngày, 1: Tháng, 2: Năm)

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 375; // Responsive ratio

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopBar(title: "Hoạt động", isBack: true),
            // Thanh nằm ngang với 3 lựa chọn: Ngày, Tháng, Năm
            Container(
              padding: EdgeInsets.only(top: 20 * pix, bottom: 10 * pix), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTabButton("Ngày", 0, pix),
                  SizedBox(width: 10 * pix),
                  _buildTabButton("Tháng", 1, pix),
                  SizedBox(width: 10 * pix),
                  _buildTabButton("Năm", 2, pix),
                ],
              ),
            ),
            // Nội dung bên dưới (placeholder)
            SizedBox(
              height: 500 * pix, // Placeholder cho nội dung sau này
              child: Center(
                child: Text(
                  'Nội dung cho ${_selectedTabIndex == 0 ? "Ngày" : _selectedTabIndex == 1 ? "Tháng" : "Năm"}',
                  style: TextStyle(
                    fontSize: 16 * pix,
                    fontFamily: 'BeVietnamPro',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget cho mỗi nút tab (Ngày/Tháng/Năm)
  Widget _buildTabButton(String title, int index, double pix) {
    bool isSelected = _selectedTabIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index; // Cập nhật lựa chọn
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20 * pix, vertical: 8 * pix),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff5B7BFE) : Colors.grey[200], // Màu nền khi được chọn
          borderRadius: BorderRadius.circular(20 * pix), // Bo góc
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14 * pix,
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black, // Màu chữ thay đổi
          ),
        ),
      ),
    );
  }
}
