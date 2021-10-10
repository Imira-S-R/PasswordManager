import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:password_manager/getStartedScreen/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff151922),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ManageMyPasswords',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width < 800
                          ? 24.0
                          : 35.0),
                ),
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Icon(
              Icons.security_rounded,
              color: Colors.white,
              size: MediaQuery.of(context).size.width < 800 ? 150.0 : 200.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Free, Fast, Simple & Secure Password Manager',
              style: TextStyle(
                  color: Colors.white,
                  fontSize:
                      MediaQuery.of(context).size.width < 800 ? 24.0 : 30.0),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Welcome to the best FREE password manager you can download this app is 100% free you can unlimited number of passwords to the app and there are ZERO ADS. Store all of your passwords securely. Enjoy !',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize:
                        MediaQuery.of(context).size.width < 800 ? 14.0 : 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => SecondScreen())),
                  child: Container(
                    height: 60.0,
                    width: MediaQuery.of(context).size.width - 70.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(0xff2d6cdf)),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
