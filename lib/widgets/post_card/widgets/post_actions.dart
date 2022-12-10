import 'package:flutter/material.dart';

class PostActions extends StatelessWidget {
  late String likes;
  PostActions({
    Key? key,
    required this.likes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        
        child: Row(children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.thumb_up,
                color: Colors.white,
                size: 13,
              )),
          Text(
            likes,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ]));
  }
}
