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
    final pix = (size.width / 375).clamp(0.8, 1.2); // Responsive ratio với giới hạn

    return Scaffold(
      body: Stack(
        children: [
          // Nội dung chính (có thể cuộn, nằm trong SafeArea)
          SafeArea(
            top: false, // Không áp dụng padding trên cùng cho nội dung
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Khoảng trống để tránh nội dung bị che bởi TopBar
                  SizedBox(height: 100 * pix), // Chiều cao của TopBar
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
                  // Nội dung bên dưới
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
          ),
          // TopBar cố định ở trên cùng, không nằm trong SafeArea
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopBar(
              title: "Hoạt động",
              isBack: true,
            ),
          ),
        ],
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
          color: isSelected ? const Color(0xff5B7BFE) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20 * pix),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.black..withAlpha((0.2 * 255).toInt()),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14 * pix,
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
