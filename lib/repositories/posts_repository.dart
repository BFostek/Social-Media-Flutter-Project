import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media/database/db_firestore.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/services/auth_service.dart';

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
            titulo: doc.get('titulo'),
            descricao: doc.get('descricao'),
            likes: doc.get('likes'),
            photo: doc.get('photo'));
        _posts.add(np);
        notifyListeners();
      }));
    }
  }

  savePost(String uid, Post post) async {
    await db.collection('posts').add({
      'AuthorId': uid,
      'titulo': post.titulo,
      'descricao': post.descricao,
      'likes': post.likes,
      'photo': post.photo,
    });
    _posts.add(post);
    notifyListeners();
  }
}
