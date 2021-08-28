import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/home_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
late SnackBar snackBar;

Future<void> signInWithEmailAndPassword(
    BuildContext context, String email, String password) async {
  try {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // snackBar = SnackBar(content: Text('${user!.email} signed in'));
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  } catch (e) {
    print('${e.toString()}');
    snackBar =
        SnackBar(content: Text('Failed to sign in with Email & Password'));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

// Example code of how to sign in with email and password.
Future<void> createUserWithEmailAndPassword(
    BuildContext context, String email, String password) async {
  try {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // snackBar = SnackBar(content: Text('${user!.email} created'));
    //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  } catch (e) {
    print('${e.toString()}');
    snackBar =
        SnackBar(content: Text('Failed to create with Email & Password'));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

Future<void> signInAnonymously(BuildContext context) async {
  try {
    await _auth.signInAnonymously();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  } catch (e) {
    print('${e.toString()}');
    snackBar = SnackBar(content: Text('Failed to sign in Anonymously'));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    UserCredential userCredential;

    if (kIsWeb) {
      var googleProvider = GoogleAuthProvider();
      userCredential = await _auth.signInWithPopup(googleProvider);
    } else {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
    }
  } catch (e) {
    print(e);
    snackBar = SnackBar(content: Text('Failed to sign in with Google: $e'));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

// Example code of how to sign in with Facebook.
// Future<void> _signInWithFacebook(context, String tokenController) async {
//   try {
//     final AuthCredential credential = FacebookAuthProvider.credential(
//       tokenController,
//     );
//     final User? user = (await _auth.signInWithCredential(credential)).user;
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//       return HomeScreen();
//     }));
//   } catch (e) {
//     print(e);
//     snackBar = SnackBar(content: Text('Failed to sign in with Facebook: $e'));

//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
