import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/repositories/posts_repository.dart';
import 'package:social_media/services/auth_service.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  late PostsRepository posts;
  late AuthService auth;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final titulo = TextEditingController();
  final descricao = TextEditingController();
  @override
  Widget build(BuildContext context) {
    posts = context.watch<PostsRepository>();
    auth = context.watch<AuthService>();
    return Scaffold(
      appBar: AppBar(title: Text("Crie um novo post!")),
      body: Container(
          child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: titulo,
              decoration: const InputDecoration(
                hintText: 'Digite o título',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Insira algum título!';
                }
                return null;
              },
            ),
            TextFormField(
              controller: descricao,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Digite o conteúdo',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Insira algum conteúdo!';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Post np = Post(
                        titulo: titulo.text,
                        descricao: descricao.text,
                        likes: '0');
                    posts.savePost(auth.usuario!.uid, np);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
