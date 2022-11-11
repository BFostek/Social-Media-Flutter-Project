import 'package:flutter/material.dart';

import 'widgets/post_actions.dart';
import 'widgets/post_content.dart';
import 'widgets/post_title.dart';

class PostCard extends StatelessWidget {
  final String author;
  final String text;
  const PostCard({
    Key? key,
    required this.author,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 5, 5, 5),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                PostTitle(author: this.author,text: this.text),
                const PostContent(),
                const PostActions(),
              ],
            ),
          ),
          Container(
            height: 1.0,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ]));
  }
}
