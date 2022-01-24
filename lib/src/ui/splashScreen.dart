import 'dart:async';
import 'dart:io';

import 'package:b_sampah/src/pref/preference.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token;

  _authCheckSession() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
          if (token != null) {
            Navigator.pushReplacementNamed(context, '/controller');
          } else {
            Navigator.pushReplacementNamed(context, '/login');
          }
      }
    } on SocketException catch (_) {
      Toast.show("Cek Internet Anda", context,
          duration: 7, gravity: Toast.BOTTOM);
    }
  }
  @override
  void initState() {
    getToken().then((onValue) {
      setState(() {
        token = onValue;
      });
    });
    Timer(Duration(seconds: 2), () {
      _authCheckSession();
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
