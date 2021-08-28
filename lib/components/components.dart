import 'package:denizey/authentication/authentication.dart';
import 'package:denizey/screens/authentication_screen.dart';
import 'package:denizey/cache/app_cache.dart';
import 'package:flutter/material.dart';

Widget languageButton(BuildContext context, String language) {
  AppCache.init();
  return Padding(
    padding:
        const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0, top: 48),
    child: MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      onPressed: () {
        AppCache.prefs.setString('language', language);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return AuthenticationScreen();
        }));
      },
      minWidth: double.infinity,
      height: 50.0,
      child: Text(
        language,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      ),
    ),
  );
}

Widget authIcon(String imagePath, context, Future<void> authentication) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () => authentication,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          shape: BoxShape.rectangle,
        ),
        height: 40.0,
        width: 40.0,
        child: Image.asset(
          imagePath,
        ),
      ),
    ),
  );
}

Widget searchFormField() {
  return Padding(
    padding: const EdgeInsets.only(top: 40.0),
    child: Container(
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.details),
          hintText: 'What are you looking for?',
          contentPadding: EdgeInsets.only(left: 0.0),
          fillColor: Colors.white54,
          filled: true,
          border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide.none),
        ),
      ),
    ),
  );
}
