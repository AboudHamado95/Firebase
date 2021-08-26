import 'package:denizey/authentication_screen.dart';
import 'package:denizey/cache/app_cache.dart';
import 'package:denizey/components.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          languageButton(context, 'English'),
          languageButton(context, 'Deutsch'),
          languageButton(context, 'عربي'),
        ],
      ),
    );
  }
}
