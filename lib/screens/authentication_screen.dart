import 'package:denizey/authentication/authentication.dart';
import 'package:denizey/components/components.dart';
// import 'package:denizey/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  late User user;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SnackBar snackBar;

  // Future<void> _signInWithGoogle() async {
  //   try {
  //     UserCredential userCredential;

  //     if (kIsWeb) {
  //       var googleProvider = GoogleAuthProvider();
  //       userCredential = await _auth.signInWithPopup(googleProvider);
  //     } else {
  //       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser!.authentication;
  //       final googleAuthCredential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       userCredential = await _auth.signInWithCredential(googleAuthCredential);
  //     }
  //   } catch (e) {
  //     print(e);
  //     snackBar = SnackBar(content: Text('Failed to sign in with Google: $e'));

  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32.0),
                bottomRight: Radius.circular(32.0),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 0.0),
                child: Image.asset(
                  'assets/photo1.jpg',
                  fit: BoxFit.cover,
                  width: width,
                  height: height / 3.5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign in',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 24.0),
                    child: Text(
                      'Please login to your account',
                      style: TextStyle(color: Colors.grey[350]),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please enter your Email!';
                          },
                          controller: emailController,
                          decoration:
                              InputDecoration(hintText: 'Email Address'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Please enter your Password!';
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon:
                                  InkWell(onTap: () {}, child: Text('Forgot?')),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 40.0, bottom: 16.0),
                          child: MaterialButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await signInWithEmailAndPassword(
                                    context,
                                    emailController.text,
                                    passwordController.text);
                                setState(() {});
                                emailController.clear();
                                passwordController.clear();
                              }
                            },
                            child: Text('Login'),
                            color: Colors.purple[300],
                            minWidth: double.infinity,
                            height: 50.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await createUserWithEmailAndPassword(context,
                                emailController.text, passwordController.text);
                            setState(() {});
                            emailController.clear();
                            passwordController.clear();
                          }
                        },
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthIcon(
                            imagePath: 'assets/google-logo.jpg',
                            authentication: signInWithGoogle),
                        AuthIcon(
                            imagePath: 'assets/Facebook-logo.jpg',
                            authentication: signInWithFacebook),
                        AuthIcon(
                            imagePath: 'assets/Apple.jpg',
                            authentication: signInWithFacebook),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => signInAnonymously(context),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                color: Colors.purple,
                                width: 1.5,
                              ),
                            )),
                            child: Text(
                              'Continue as Guest',
                              style: TextStyle(
                                  color: Colors.purple[300],
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
