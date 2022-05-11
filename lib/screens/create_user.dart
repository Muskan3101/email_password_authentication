import 'package:email_password_authentication/screens/signin.dart';
import 'package:email_password_authentication/screens/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  //form Key
  final _globalFormKey = GlobalKey<FormState>();
  var name = " ";
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
                      hintText: "Name",
                    ),
                    validator: (value) {
                      name = value!;
                      if (value.isEmpty) {
                        return "Please enter the user name";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "email Id",
                    ),
                    validator: (value){
                      email = value!;
                      if(value.isEmpty){
                        return "Please fill valid email Id";
                      }return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "password",
                    ),
                    validator: (value){
                      password = value!;
                      if(value.isEmpty){
                        return "Please fill correct password";
                      }return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: (){
                      var valid = _globalFormKey.currentState!.validate();
                      if(!valid){
                        return ;
                      }
                      print(email + password);
                      //trim() is use to avoid any unwanted space or character in text
                      createUser(email.toString().trim(),password.toString().trim());
                    },
                    child: const Text("Create User"),
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
                      },
                      child: const Text("SignIn")
                  )
                ],
              ),
            )
        )
    );
  }

  //createUser is use to Sign Up the User.

  void createUser(String emails, String passwords) async {
    try {
      //reference variable ko tabhi call karte hai jab humko uss se koi value print karana ho.
      final credential=   await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emails, password: passwords);
      print("CreateUserTest${credential.toString()}");
      if(credential.user!=null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
      }
    }on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        print('The password provided is too weak.');
        Fluttertoast.showToast(msg: "The password provided is too weak.");
      }else if(e.code == 'email-already-in-use'){
        print('The account already exists for that email.');
        Fluttertoast.showToast(msg: "The account already exists for that email.");
      }
    }catch (e){
      print(e);
    }
  }
}