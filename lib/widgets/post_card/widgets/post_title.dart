import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/repositories/posts_repository.dart';
import 'package:social_media/services/auth_service.dart';

class PostTitle extends StatefulWidget {
  final String author;
  final String text;

  PostTitle({
    Key? key,
    required this.author,
    required this.text,
  }) : super(key: key);

  @override
  State<PostTitle> createState() => _PostTitleState();
}

class _PostTitleState extends State<PostTitle> {
  late AuthService auth;

  late PostsRepository posts;

  late String author_name = "Carregando...";

  @override
  Widget build(BuildContext context) {
    auth = context.watch<AuthService>();
    posts = context.watch<PostsRepository>();
    posts.getAuthorByUid(this.widget.author).then((value) => setState(()=>author_name = value)) ;
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
        child: Column(children: [
          
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 3),
                      child: GestureDetector(
                          onTap: () => {print("Logo")},
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 0, 0, 0),
                            radius: 20,
                            child: Text('AH',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                          ))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      GestureDetector(
                          onTap: () {
                            print("Eae");
                          },
                          child: Text(
                            author_name,
                            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                          )),
                      const Text(
                        "11/11/2022 10:00:00",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 10),
                      )
                    ],
                  )
                ],
              )),
          Text(
            this.widget.text,
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ]));
  }
}
