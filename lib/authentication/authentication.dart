import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

Future<void> signInWithGoogle(context) async {
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

Future<void> signInWithFacebook(context) async {
  try {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;

      final AuthCredential credential = FacebookAuthProvider.credential(
        accessToken.token,
      );
      final User? user = (await _auth.signInWithCredential(credential)).user;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
    }
  } catch (e) {
    print(e);
    // snackBar = SnackBar(content: Text('Failed to sign in with Facebook: $e'));

    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
