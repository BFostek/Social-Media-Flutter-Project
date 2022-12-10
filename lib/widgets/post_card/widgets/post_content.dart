import 'package:flutter/material.dart';

class PostContent extends StatelessWidget {
  final String photo;
  const PostContent({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("Abrir imagem!");
        },
        child: Image.network(photo,
            width: MediaQuery.of(context).size.width,
            height: 300,
            fit: BoxFit.cover));
  }
}
