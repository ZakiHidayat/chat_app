import 'package:chat_app/screen/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "LOGIN_SCREEN";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200.0,
              child: Image.asset('gambar/robologin.png'),
            ),
            SizedBox(
              height: 0.0,
            ),
            TextField(
              style: TextStyle(color: Colors.black),
              onChanged: (value){
                email = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your Email',
                hintStyle: TextStyle(color: Colors.grey, fontFamily: 'futura'),
                contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                    BorderSide(color: Color(0xffFFC727),width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                    BorderSide(color: Color(0xffFFC727), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              onChanged: (value){
                password = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your Password',
                  hintStyle: TextStyle(color: Colors.grey, fontFamily: 'futura'),
                contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                    BorderSide(color: Color(0xffFFC727), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                    BorderSide(color: Color(0xffFFC727), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0))
                )
              ),
            ),
            SizedBox(
              height: 3.0,
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Color(0xffFFC727),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    try {
                      var loginUser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                      if (loginUser != null){
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    }catch (e){
                      print (e);
                    }
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log in',
                    style: TextStyle(fontFamily: 'futura', fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
