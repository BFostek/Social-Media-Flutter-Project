
import 'package:flutter/material.dart';

class PostContent extends StatelessWidget {
  const PostContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network('https://picsum.photos/252?image=9',
    width: MediaQuery.of(context).size.width,
    height: 300,
        fit: BoxFit.cover);
  }
}
