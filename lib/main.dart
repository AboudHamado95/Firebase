import 'package:denizey/authentication_screen.dart';
import 'package:denizey/cache/app_cache.dart';
import 'package:denizey/language_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppCache.init();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple,
      ),
      home: AppCache.prefs.containsKey('language')
          ? AuthenticationScreen()
          : LanguageScreen(),
    ),
  );
}
