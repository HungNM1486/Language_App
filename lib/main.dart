import 'package:flutter/material.dart';
import 'package:language_app/phunv/LoginSignup/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Ẩn banner debug
      title: 'Language App', // Tiêu đề ứng dụng
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Chủ đề màu tím
        useMaterial3: true, // Dùng Material Design 3
      ),
      routes: {
        '/': (context) => const Loginscreen(), // Màn hình gốc là LoginScreen
      },
    );
  }
}
  