import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pix = MediaQuery.of(context).size.width / 375;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.support),
        backgroundColor: const Color(0xff5B7BFE),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * pix),
        child: ListView(
          children: [
            // Tiêu đề nhóm
            Text(
              'Thông tin nhóm phát triển',
              style: TextStyle(
                fontSize: 20 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: const Color(0xff5B7BFE),
              ),
            ),
            SizedBox(height: 16 * pix),

            // Thông tin thành viên
            _buildMemberInfo('Nguyễn Mạnh Hùng', 'B21DCCN412', pix),
            _buildMemberInfo('Nguyễn Văn Phú', 'B21DCCN412', pix),
            _buildMemberInfo('Nguyễn Minh Hồng', 'B21DCCN412', pix),
            _buildMemberInfo('Trần Duy Anh', 'B21DCCN412', pix),
            SizedBox(height: 24 * pix),

            // Thông tin liên hệ
            Text(
              'Liên hệ hỗ trợ',
              style: TextStyle(
                fontSize: 18 * pix,
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.bold,
                color: const Color(0xff5B7BFE),
              ),
            ),
            SizedBox(height: 8 * pix),
            Text(
              'Email: hungnm1486@gmail.com',
              style: TextStyle(
                fontSize: 16 * pix,
                fontFamily: 'BeVietnamPro',
                color: Colors.black,
              ),
            ),
            Text(
              'Hotline: +84 964 175 516 (8:00 - 17:00)',
              style: TextStyle(
                fontSize: 16 * pix,
                fontFamily: 'BeVietnamPro',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16 * pix),

            // Mô tả ngắn
            Text(
              'Ứng dụng Language App được phát triển bởi nhóm sinh viên B21DCCN412 nhằm hỗ trợ việc học ngoại ngữ một cách hiệu quả. Nếu bạn cần hỗ trợ, vui lòng liên hệ qua email hoặc hotline.',
              style: TextStyle(
                fontSize: 14 * pix,
                fontFamily: 'BeVietnamPro',
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.justify,
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