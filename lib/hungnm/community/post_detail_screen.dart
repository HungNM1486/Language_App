import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostDetailScreen extends StatefulWidget {
  final Map<String, dynamic> post;
  final Function(Map<String, dynamic>) onUpdate;

  const PostDetailScreen(
      {super.key, required this.post, required this.onUpdate});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late Map<String, dynamic> post;
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    post = Map.from(widget.post); 
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pix = MediaQuery.of(context).size.width / 375;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(post['title']),
        backgroundColor: const Color(0xff43AAFF),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * pix),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post['content'],
              style: TextStyle(fontSize: 16 * pix, fontFamily: 'BeVietnamPro'),
            ),
            SizedBox(height: 16 * pix),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      post['likes'] += 1;
                      widget.onUpdate(post);
                    });
                  },
                ),
                Text('${post['likes']} ${l10n.likes}',
                    style: TextStyle(fontSize: 14 * pix)),
                SizedBox(width: 16 * pix),
                Text('${post['comments'].length} ${l10n.comments}',
                    style: TextStyle(fontSize: 14 * pix)),
              ],
            ),
            SizedBox(height: 16 * pix),
            Expanded(
              child: ListView.builder(
                itemCount: post['comments'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      post['comments'][index],
                      style: TextStyle(
                          fontSize: 14 * pix, fontFamily: 'BeVietnamPro'),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: l10n.addComment,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color:  Color(0xff43AAFF)),
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      setState(() {
                        post['comments'].add(_commentController.text);
                        widget.onUpdate(post);
                        _commentController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
