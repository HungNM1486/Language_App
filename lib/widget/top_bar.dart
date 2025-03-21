import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;
  final bool isBack;

  const TopBar({super.key, required this.title, this.isBack = true});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 375;

    return Container(
      height: 100 * pix,
      width: size.width,
      color: const Color(0xff43AAFF),
      padding: EdgeInsets.only(top: 20 * pix),
      child: Row(
        children: [
          Container(
            width: pix * 50,
            margin: EdgeInsets.only(top: 16 * pix),
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
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24 * pix,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'BeVietnamPro'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
