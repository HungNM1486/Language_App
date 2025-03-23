import 'package:flutter/material.dart';
import 'package:language_app/widget/top_bar.dart';
import 'package:language_app/hungnm/widgets/friend_suggestion.dart'; // Import file mới

class FindFrSreen extends StatelessWidget {
  const FindFrSreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = (size.width / 375).clamp(0.8, 1.2);

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 100 * pix),
                  _buildMainContent(context, size, pix),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopBar(title: "Thêm bạn bè", isBack: true),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, Size size, double pix) {
    return Padding(
      padding: EdgeInsets.all(16.0 * pix),
      child: Column(
        children: [
          _SearchBar(pix: pix),
          SizedBox(height: 20 * pix),
          FriendSuggestionList(size: size, pix: pix), // Sử dụng widget từ file mới
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final double pix;

  const _SearchBar({required this.pix});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Tìm kiếm bạn bè...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0 * pix),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 14.0 * pix,
          horizontal: 16.0 * pix,
        ),
      ),
    );
  }
}
