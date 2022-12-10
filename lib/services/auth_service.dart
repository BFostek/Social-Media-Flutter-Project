import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/database/db_firestore.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late FirebaseFirestore db;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
    _startFirestore();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _startFirestore() async {
    db = DbFirestore.get();
    print(db);
  }

  createUser(String email) async {
    await db.collection('users').add({'AuthorId': usuario!.uid, 'mail': email});
  }

  register(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
      await createUser(email);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw AuthException('A senha é fraca!');
        case 'email-already-in-use':
          throw AuthException('Usuário já cadastrado!');
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }
    }
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  logOut() async {
    await _auth.signOut();
    _getUser();
  }
}
