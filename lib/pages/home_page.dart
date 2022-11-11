import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/pages/new_post.dart';
import 'package:social_media/repositories/posts_repository.dart';
import 'package:social_media/widgets/post_card/post_card.dart';

import '../widgets/nav_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PostsRepository posts;
  @override
  Widget build(BuildContext context) {
    posts = context.watch<PostsRepository>();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewPost()));
            },
            child: Text("+")),
        drawer: NavDrawer(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.black,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Posts',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: ListView.separated(
          itemBuilder: ((context, index) => Container(child: PostCard(author: "Autor 1",text: posts.posts[index].descricao,))),
          shrinkWrap: true,
          separatorBuilder: (_, __) => Divider(
            height: 1,
          ),
          itemCount: posts.posts.length,
        ));
  }
}
