import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:language_app/hungnm/community/create_post_screen.dart';
import 'package:language_app/hungnm/community/post_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<Map<String, dynamic>> posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? postsJson = prefs.getString('community_posts');
    if (postsJson != null) {
      setState(() {
        posts = List<Map<String, dynamic>>.from(jsonDecode(postsJson));
      });
    }
  }

  Future<void> _savePosts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('community_posts', jsonEncode(posts));
  }

  @override
  Widget build(BuildContext context) {
    final pix = MediaQuery.of(context).size.width / 375;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.community),
        backgroundColor: const Color(0xff43AAFF),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: posts.isEmpty
                ? Center(child: Text(l10n.noPosts, style: TextStyle(fontSize: 16 * pix)))
                : ListView.builder(
                    padding: EdgeInsets.all(16 * pix),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.only(bottom: 8 * pix),
                        child: ListTile(
                          title: Text(
                            post['title'],
                            style: TextStyle(
                              fontSize: 16 * pix,
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${post['content'].substring(0, post['content'].length > 50 ? 50 : post['content'].length)}...',
                            style: TextStyle(fontSize: 14 * pix, fontFamily: 'BeVietnamPro'),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.thumb_up, size: 16 * pix, color: Colors.grey),
                              SizedBox(width: 4 * pix),
                              Text('${post['likes']}', style: TextStyle(fontSize: 14 * pix)),
                              SizedBox(width: 8 * pix),
                              Icon(Icons.comment, size: 16 * pix, color: Colors.grey),
                              SizedBox(width: 4 * pix),
                              Text('${post['comments'].length}', style: TextStyle(fontSize: 14 * pix)),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailScreen(
                                  post: post,
                                  onUpdate: (updatedPost) {
                                    setState(() {
                                      posts[index] = updatedPost;
                                      _savePosts();
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: EdgeInsets.all(16 * pix),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatePostScreen(
                      onPostCreated: (newPost) {
                        setState(() {
                          posts.add(newPost);
                          _savePosts();
                        });
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff43AAFF),
                padding: EdgeInsets.symmetric(vertical: 12 * pix, horizontal: 24 * pix),
              ),
              child: Text(
                l10n.createPost,
                style: TextStyle(fontSize: 16 * pix, color: Colors.white, fontFamily: 'BeVietnamPro'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}