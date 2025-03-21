import 'package:flutter/material.dart';
import 'package:language_app/phunv/vocabulary_screen.dart';
import 'package:language_app/phunv/widget/topic_widget.dart';
import 'package:language_app/models/topic_model.dart';
import 'package:language_app/res/imagesLA/app_images.dart';
import 'package:language_app/widget/bottom_bar.dart';
import 'package:language_app/widget/top_bar.dart';

class VocabularyTopicscreen extends StatefulWidget {
  const VocabularyTopicscreen({super.key});

  @override
  State<VocabularyTopicscreen> createState() => _VocabularyTopicscreenState();
}

class _VocabularyTopicscreenState extends State<VocabularyTopicscreen> {
  final List<Topicmodel> _list = [
    Topicmodel(
      id: '1',
      topic: 'English',
      image: AppImages.animal,
      numbervocabulary: 50,
      description: 'normal',
    ),
    Topicmodel(
      id: '2',
      topic: 'Math',
      image: AppImages.family,
      numbervocabulary: 50,
      description: 'normal',
    ),
    Topicmodel(
      id: '3',
      topic: 'Science',
      image: AppImages.animal,
      numbervocabulary: 50,
      description: 'normal',
    ),
    Topicmodel(
      id: '4',
      topic: 'History',
      image: AppImages.family,
      numbervocabulary: 50,
      description: 'normal',
    ),
    Topicmodel(
      id: '5',
      topic: 'Geography',
      image: AppImages.animal,
      numbervocabulary: 50,
      description: 'normal',
    ),
    Topicmodel(
      id: '6',
      topic: 'Music',
      image: AppImages.family,
      numbervocabulary: 50,
      description: 'normal',
    ),
    Topicmodel(
      id: '7',
      topic: 'English',
      image: AppImages.animal,
      numbervocabulary: 50,
      description: 'normal',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 375;
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const TopBar(title: "Chủ đề từ vựng", isBack: false),
                Container(
                  height: 55 * pix,
                  width: size.width,
                  margin: EdgeInsets.only(
                      left: 66 * pix,
                      right: 66 * pix,
                      top: 10 * pix,
                      bottom: 10 * pix),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatItem('Đã thử', '6', pix),
                      Container(
                        height: 55 * pix,
                        width: 0.5 * pix,
                        margin: EdgeInsets.all(10 * pix),
                        color: const Color(0xff165598),
                      ),
                      _buildStatItem('Tổng', '21', pix),
                    ],
                  ),
                ),
                Container(
                  height: 0.5 * pix,
                  width: size.width,
                  margin: EdgeInsets.all(10 * pix),
                  color: const Color(0xff165598),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16 * pix, right: 16 * pix, top: 16 * pix),
                      child: Row(
                        children: [
                          Text(
                            'Tất cả',
                            style: TextStyle(
                              fontSize: 16 * pix,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BeVietnamPro',
                              color: const Color(0xff165598),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10 * pix, right: 10 * pix),
                      child: SizedBox(
                        height: 540 * pix,
                        width: double.maxFinite,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 2 cột mỗi hàng
                            childAspectRatio:
                                3 / 4, // Tỷ lệ chiều rộng / chiều cao
                            crossAxisSpacing: 10, // Khoảng cách ngang
                            mainAxisSpacing: 10, // Khoảng cách dọc
                          ),
                          itemCount: _list.length,
                          itemBuilder: (context, index) {
                            return Topicwidget(
                              title: _list[index].topic,
                              image: _list[index].image,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Vocabularyscreen(
                                      title: _list[index].topic,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          bottom: 0,
          child: Bottombar(type: 2),
        ),
      ],
    );
  }

  Widget _buildStatItem(String title, String value, double pix) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14 * pix, color: const Color(0xff165598)),
        ),
        SizedBox(height: 5 * pix),
        Text(
          value,
          style: TextStyle(
              fontSize: 20 * pix,
              fontWeight: FontWeight.bold,
              color: const Color(0xff165598)),
        ),
      ],
    );
  }
}
