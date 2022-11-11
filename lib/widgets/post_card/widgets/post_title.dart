import 'package:flutter/material.dart';

class PostTitle extends StatelessWidget {
  final String author;
  final String text;
  const PostTitle({
    Key? key,
    required this.author,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
        child: Column(children: [
          // ignore: prefer_const_literals_to_create_immutables
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            const Chip(
              padding: EdgeInsets.all(0),
              backgroundColor: Color.fromARGB(225, 255, 0, 0),
              label: Text('Computadores',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
            )
          ]),
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 3),
                      child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 255, 47, 0),
                        radius: 20,
                        child: Text('AH'),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        this.author,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const Text(
                        "11/11/2022 10:00:00",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      )
                    ],
                  )
                ],
              )),
          Text(
            this.text,
            style: TextStyle(color: Colors.white),
          ),
        ]));
  }
}
