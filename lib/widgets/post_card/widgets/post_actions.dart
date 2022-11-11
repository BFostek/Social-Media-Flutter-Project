import 'package:flutter/material.dart';

class PostActions extends StatelessWidget {
  const PostActions({
    Key? key,
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
          const Text(
            "32",
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ]));
  }
}
