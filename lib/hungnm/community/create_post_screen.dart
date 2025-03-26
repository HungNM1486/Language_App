import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreatePostScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onPostCreated;

  const CreatePostScreen({super.key, required this.onPostCreated});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pix = MediaQuery.of(context).size.width / 375;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.createPost),
        backgroundColor: const Color(0xff43AAFF),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * pix),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: l10n.postTitle,
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16 * pix),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: l10n.postContent,
                border: const OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 24 * pix),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
                  final newPost = {
                    'title': _titleController.text,
                    'content': _contentController.text,
                    'likes': 0,
                    'comments': [],
                  };
                  widget.onPostCreated(newPost);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff43AAFF),
                padding: EdgeInsets.symmetric(vertical: 12 * pix, horizontal: 24 * pix),
              ),
              child: Text(
                l10n.submitPost,
                style: TextStyle(fontSize: 16 * pix, color: Colors.white, fontFamily: 'BeVietnamPro'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}