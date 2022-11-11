import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_media/repositories/posts_repository.dart';
import 'package:social_media/services/auth_service.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
      ChangeNotifierProvider(create: (context) => PostsRepository(auth: context.read<AuthService>())),
    ],
    child: const MainApp(),
  ));
}
