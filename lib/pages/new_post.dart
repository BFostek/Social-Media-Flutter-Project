import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    posts = context.watch<PostsRepository>();
    auth = context.watch<AuthService>();
    uploadImage() async {
      final _imagePicker = ImagePicker();
      PickedFile? image;
      //Check Permissions
      await Permission.photos.request();

      var permissionStatus = await Permission.photos.status;
      if (permissionStatus.isGranted) {
        image = await _imagePicker.getImage(source: ImageSource.gallery);
        var file = File(image!.path);
        if (image != null) {
          var result = await posts.uploadImage(file);
          if (result != null) {
            setState(() {
              print(result);
              imageUrl = result;
            });
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Crie um novo post!")),
      body: SingleChildScrollView(
        child: Container(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.white),
                  ),
                  child: (imageUrl != null)
                      ? Image.network(imageUrl!)
                      : Image.network('https://i.imgur.com/sUFH1Aq.png')),
              ElevatedButton(
                child: Text("Upload Image",
                    style: TextStyle(color: Colors.white, fontSize: 13)),
                onPressed: () {
                  uploadImage();
                },
              ),
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
                          authorId: auth.usuario!.uid,
                          titulo: titulo.text,
                          descricao: descricao.text,
                          photo: imageUrl
                          );
                      posts.savePost(np);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
