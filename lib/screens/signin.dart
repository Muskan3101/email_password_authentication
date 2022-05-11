import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'welcome_page.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //form Key
  final _globalFormKey = GlobalKey<FormState>();
  var email = " ";
  var password = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Email and Password Authentication"),
        ),
        body: Form(
            key: _globalFormKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "email Id",
                    ),
                    validator: (value) {
                      email = value!;
                      if (value.isEmpty) {
                        return "Please fill valid email Id";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "password",
                    ),
                    validator: (value) {
                      password = value!;
                      if (value.isEmpty) {
                        return "Please fill correct password";
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var valid = _globalFormKey.currentState!.validate();
                      if (!valid) {
                        return;
                      }
                      print(email + password);
                      //trim() is use to avoid any unwanted space or character in text
                      SigninUser(email.toString().trim(), password.toString().trim());
                    },
                    child: const Text("SignIn User"),
                  ),
                ],
              ),
            )));
  }

  //SignIn is used for login user
  void SigninUser(String emails, String passwords) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emails, password: passwords);
      print("SignInTest${credential.toString()}");
      if (credential.user != null) {
        print("move to next page");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomePage()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      }
    }
  }
}
