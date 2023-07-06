import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_web_admin/views/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid ? FirebaseOptions(
        apiKey: "AIzaSyBqm0YF2OtpdTNlEWTrWWLY5NNfkUT92Vs",
        appId: "1:734022838895:web:d12ec63d2e5be86150bb9a",
        messagingSenderId: "734022838895",
        projectId: "multi-store-65787",
        storageBucket: "multi-store-65787.appspot.com",) : null
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: const MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}
