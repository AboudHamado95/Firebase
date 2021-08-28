import 'package:flutter/material.dart';

import 'package:denizey/components/components.dart';

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
