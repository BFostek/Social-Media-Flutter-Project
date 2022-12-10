import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media/database/db_firestore.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/services/auth_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;
class PostsRepository extends ChangeNotifier {
  List<Post> _posts = [];

  late FirebaseFirestore db;
  late AuthService auth;

  PostsRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _getPosts();
  }

  _startFirestore() {
    db = DbFirestore.get();
  }

  UnmodifiableListView<Post> get posts => UnmodifiableListView(_posts);

  _getPosts() async {
    if (auth.usuario != null && _posts.isEmpty) {
      final snapshot = await db.collection('posts').get();

      snapshot.docs.forEach(((doc) {
        Post np = Post(
            authorId: doc.get('AuthorId'),
            titulo: doc.get('titulo'),
            descricao: doc.get('descricao'),
            photo: doc.get('photo'));
        _posts.add(np);
        notifyListeners();
      }));
    }
  }

  savePost(Post post) async {
    await db.collection('posts').add({
      'AuthorId': post.authorId,
      'titulo': post.titulo,
      'descricao': post.descricao,
      'photo': post.photo,
    });
    _posts.add(post);
    notifyListeners();
  }

  Future<String> getAuthorByUid(String author) async {
    final snapshot =
        await db.collection('users').where("AuthorId", isEqualTo: author).get();
    try {
      var user_name = snapshot.docs.first.get("mail") as String;
      if (user_name != null) {
        return user_name as String;
      }
    } catch (e) {
      return "Usuario nao encontrado";
    }
    return "Usuario nao encontrado";
  }

  Future<String> uploadImage(var file) async {
    final _firebaseStorage = FirebaseStorage.instance;
    String extension = file.toString().split('.').last;
    extension = extension.substring(0, extension.length - 1);
    
    var snapshot = await _firebaseStorage.ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.${extension}')
        .putFile(file).then((result) async {
          var downloadUrl = await result.ref.getDownloadURL();
          return downloadUrl;
        });
    return snapshot;
  }
}
