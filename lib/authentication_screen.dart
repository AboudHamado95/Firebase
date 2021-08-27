import 'package:denizey/components.dart';
import 'package:denizey/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User user;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SnackBar snackBar;

  // @override
  // void initState() {
  //   _auth.userChanges().listen((event) => setState(() => user = event!));
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
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
  Future<void> _createUserWithEmailAndPassword() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
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
                          controller: _emailController,
                          decoration:
                              InputDecoration(hintText: 'Email Address'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: TextFormField(
                            controller: _passwordController,
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
                                await _signInWithEmailAndPassword();
                                setState(() {});
                                _emailController.clear();
                                _passwordController.clear();
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
                            await _createUserWithEmailAndPassword();
                            _emailController.clear();
                            _passwordController.clear();
                            setState(() {});
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
                        authIcon('assets/google-logo.jpg', 10.0, 10.0),
                        authIcon('assets/Facebook-logo.jpg', 40.0, 40.0),
                        authIcon('assets/Apple.jpg', 40.0, 40.0)
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
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
