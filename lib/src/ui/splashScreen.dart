import 'dart:async';

import 'package:b_sampah/src/pref/preference.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token;

  @override
  void initState() {
    getToken().then((onValue) {
      setState(() {
        token = onValue;
      });
    });
    Timer(Duration(seconds: 2), () {
      if (token != null) {
        Navigator.pushReplacementNamed(context, '/controller');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blueGrey, Colors.white])),
        child: Center(
          child: Container(
              width: 200, height: 200, child: Image.asset("assets/logo.png")),
        ),
      ),
    );
  }
}
