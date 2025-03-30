import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart'; // Để chọn ảnh
import 'dart:io';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  File? _avatarImage; // Ảnh đại diện
  final TextEditingController _usernameController = TextEditingController(text: 'Nguyễn Mạnh Hùng');
  final TextEditingController _loginNameController = TextEditingController(text: 'hungnm');
  final TextEditingController _passwordController = TextEditingController(text: '********');
  final TextEditingController _emailController = TextEditingController(text: 'hungnm@example.com');
  bool _obscurePassword = true; // Ẩn/hiện mật khẩu

  // Chọn ảnh từ thư viện
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
      });
    }
  }

  // Hiển thị dialog xác nhận xóa tài khoản
  void _showDeleteAccountDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteAccount),
        content: Text(l10n.deleteConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              // Logic xóa tài khoản (có thể gọi API hoặc xử lý local)
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login'); // Quay về màn đăng nhập
            },
            child: Text(
              l10n.agree,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pix = MediaQuery.of(context).size.width / 375;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileInfo),
        backgroundColor: const Color(0xff5B7BFE),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16 * pix),
        children: [
          // Ảnh đại diện
          _buildAvatarSection(pix, l10n),
          SizedBox(height: 20 * pix),

          // Tên người dùng
          _buildTextFieldSection(l10n.username, _usernameController, pix, Icons.person),
          SizedBox(height: 16 * pix),

          // Tên đăng nhập
          _buildTextFieldSection(l10n.loginName, _loginNameController, pix, Icons.login),
          SizedBox(height: 16 * pix),

          // Mật khẩu
          _buildPasswordFieldSection(l10n.password, _passwordController, pix, l10n),
          SizedBox(height: 16 * pix),

          // Email
          _buildTextFieldSection(l10n.email, _emailController, pix, Icons.email),
          SizedBox(height: 24 * pix),

          // Nút lưu thay đổi
          _buildSaveButton(pix, l10n),
          SizedBox(height: 16 * pix),

          // Xóa tài khoản
          _buildDeleteAccountButton(pix, l10n),
        ],
      ),
    );
  }

  // Ảnh đại diện
  Widget _buildAvatarSection(double pix, AppLocalizations l10n) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50 * pix,
              backgroundImage: _avatarImage != null
                  ? FileImage(_avatarImage!)
                  : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
              child: _avatarImage == null
                  ? Icon(Icons.camera_alt, size: 30 * pix, color: Colors.grey)
                  : null,
            ),
          ),
          SizedBox(height: 8 * pix),
          Text(
            l10n.avatar,
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

  // Trường nhập liệu thông thường
  Widget _buildTextFieldSection(String label, TextEditingController controller, double pix, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14 * pix,
            fontFamily: 'BeVietnamPro',
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4 * pix),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12 * pix),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8 * pix),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(icon, color: Colors.grey, size: 20 * pix),
            ),
          ),
        ),
      ],
    );
  }

  // Trường nhập mật khẩu
  Widget _buildPasswordFieldSection(String label, TextEditingController controller, double pix, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14 * pix,
            fontFamily: 'BeVietnamPro',
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4 * pix),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12 * pix),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8 * pix),
          ),
          child: TextField(
            controller: controller,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.lock, color: Colors.grey, size: 20 * pix),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                  size: 20 * pix,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Nút lưu thay đổi
  Widget _buildSaveButton(double pix, AppLocalizations l10n) {
    return ElevatedButton(
      onPressed: () {
        // Logic lưu thay đổi (gọi API hoặc lưu local)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã lưu thay đổi')),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff5B7BFE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8 * pix)),
        padding: EdgeInsets.symmetric(vertical: 12 * pix),
      ),
      child: Text(
        l10n.saveChanges,
        style: TextStyle(
          fontSize: 16 * pix,
          fontFamily: 'BeVietnamPro',
          color: Colors.white,
        ),
      ),
    );
  }

  // Nút xóa tài khoản
  Widget _buildDeleteAccountButton(double pix, AppLocalizations l10n) {
    return TextButton(
      onPressed: () => _showDeleteAccountDialog(context),
      child: Text(
        l10n.deleteAccount,
        style: TextStyle(
          fontSize: 16 * pix,
          fontFamily: 'BeVietnamPro',
          color: Colors.red,
        ),
      ),
    );
  }
}