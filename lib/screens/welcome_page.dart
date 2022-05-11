import 'package:email_password_authentication/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Page"),
      ),
      body: Column(
        children: <Widget>[
          const ListTile(
            title: Text("Camera"),
            leading: Icon(Icons.camera_alt),
          ),
          const ListTile(
            title: Text("Books"),
            leading: Icon(Icons.book),
          ),
          const ListTile(
            title: Text("Women"),
            leading: Icon(Icons.woman),
          ),
          const ListTile(
            title: Text("Men"),
            leading: Icon(Icons.man),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                logOut();
              },
              child: Text("Log Out"))
        ],
      ),
    );
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignIn()), (route) => false);
  }
}
