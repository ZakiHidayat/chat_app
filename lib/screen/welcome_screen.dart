import 'package:chat_app/screen/login_screen.dart';
import 'package:chat_app/screen/ragistration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "WELCOME_SCREEN";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                      child: Image.asset('gambar/robochat.png')),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 30.0),
                //   child: Text(
                //     '️Blue Chat',
                //     style: TextStyle(
                //       color: Colors.lightBlue,
                //       fontSize: 40.0,
                //       fontWeight: FontWeight.w900,
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Material(
                elevation: 6.0,
                color: Color(0xffFFC727),
                borderRadius: BorderRadius.circular(12.0),
                child: MaterialButton(
                  onPressed: (){
                    // go to login screen
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 60.0,
                  child: Text(
                    'Login', style: TextStyle(fontSize: 16, fontFamily: 'futura'),
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Material(
                color: Color(0xffE2A904),
                borderRadius: BorderRadius.circular(12.0),
                elevation: 6.0,
                child: MaterialButton(
                  onPressed: (){
                    //Go to Registration screen
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 60.0,
                  child: Text(
                    'Register', style: TextStyle(fontSize: 16, fontFamily: 'futura')
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
