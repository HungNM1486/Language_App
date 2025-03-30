import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pix = MediaQuery.of(context).size.width / 375;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.about),
        backgroundColor: const Color(0xff5B7BFE),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * pix),
        child: ListView(
          children: [
            // Tiêu đề ứng dụng
            Text(
              'Language App',
              style: TextStyle(
                fontSize: 24 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: const Color(0xff5B7BFE),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8 * pix),
            Text(
              'Phiên bản: 1.0.0',
              style: TextStyle(
                fontSize: 16 * pix,
                fontFamily: 'BeVietnamPro',
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24 * pix),

            // Mô tả ứng dụng
            Text(
              'Giới thiệu',
              style: TextStyle(
                fontSize: 18 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: const Color(0xff5B7BFE),
              ),
            ),
            SizedBox(height: 8 * pix),
            Text(
              'Language App là ứng dụng học ngoại ngữ được thiết kế để hỗ trợ người dùng nâng cao kỹ năng ngôn ngữ một cách dễ dàng và hiệu quả. Ứng dụng cung cấp các khóa học, mục tiêu học tập và nhiều tính năng tiện ích khác.',
              style: TextStyle(
                fontSize: 14 * pix,
                fontFamily: 'BeVietnamPro',
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 24 * pix),

            // Thông tin nhóm phát triển
            Text(
              'Nhóm phát triển',
              style: TextStyle(
                fontSize: 18 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: const Color(0xff5B7BFE),
              ),
            ),
            SizedBox(height: 8 * pix),
            _buildMemberInfo('Nguyễn Mạnh Hùng', 'B21DCCN412', pix),
            _buildMemberInfo('Nguyễn Văn Phú', 'B21DCCN412', pix),
            _buildMemberInfo('Nguyễn Minh Hồng', 'B21DCCN412', pix),
            _buildMemberInfo('Trần Duy Anh', 'B21DCCN412', pix),
            SizedBox(height: 16 * pix),

            // Thông tin liên hệ
            Text(
              'Liên hệ',
              style: TextStyle(
                fontSize: 18 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: const Color(0xff5B7BFE),
              ),
            ),
            SizedBox(height: 8 * pix),
            Text(
              'Email: languageapp.support@gmail.com',
              style: TextStyle(
                fontSize: 14 * pix,
                fontFamily: 'BeVietnamPro',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberInfo(String name, String studentId, double pix) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4 * pix),
      child: Row(
        children: [
          Icon(Icons.person, size: 20 * pix, color: Colors.grey),
          SizedBox(width: 8 * pix),
          Text(
            '$name - $studentId',
            style: TextStyle(
              fontSize: 16 * pix,
              fontFamily: 'BeVietnamPro',
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}