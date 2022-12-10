import 'package:flutter/material.dart';
import 'package:social_media/models/post.dart';

import 'widgets/post_actions.dart';
import 'widgets/post_content.dart';
import 'widgets/post_title.dart';

class PostCard extends StatefulWidget {
  late Post post;
  PostCard({
    Key? key,
    required this.post
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(54, 5, 5, 5),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                PostTitle(author: widget.post.authorId,text: widget.post.titulo),
                PostContentType(widget.post)
              ],
            ),
          ),
          Container(
            height: 1.0,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ]));
  }

  Widget PostContentType(Post post){
    var photo = post.photo;
    if(photo!=null){
      return PostContent(photo: photo);
    } 
    return Container();
  }
}
