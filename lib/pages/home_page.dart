import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/pages/new_post.dart';
import 'package:social_media/repositories/posts_repository.dart';
import 'package:social_media/widgets/post_card/post_card.dart';

import '../widgets/nav_drawer.dart';
import 'package:dio/dio.dart';

Future<String> getHttp() async {
  try {
    var response = await Dio().get('https://api.adviceslip.com/advice');
    return jsonDecode(response.toString())["slip"]["advice"];
  } catch (e) {
    print(e);
    return "";
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PostsRepository posts;
  late String message;

  @override
  void initState() {
    super.initState();
    message = " ";
    getHttp().then((value) => setState(() => message = value));
  }

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
        body: Column(children: [
          Card(
            color: Color.fromARGB(255, 214, 213, 213),
              child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(message),
          )),
          Expanded(
            child: ListView.separated(
              itemBuilder: ((context, index) =>
                  Container(child: PostCard(post: posts.posts[index]))),
              shrinkWrap: true,
              separatorBuilder: (_, __) => Divider(
                height: 1,
              ),
              itemCount: posts.posts.length,
            ),
          )
        ]));
  }
}
