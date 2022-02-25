import 'package:new_resik/src/ui/controllerPage.dart';
import 'package:new_resik/src/ui/home_page.dart';
import 'package:new_resik/src/ui/login_page.dart';
import 'package:new_resik/src/ui/splashScreen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(primarySwatch: Colors.blueGrey),
        home: Scaffold(
          body: SplashScreen(),
        ),
        routes: <String, WidgetBuilder>{
          '/controller': (BuildContext context) => new ControllerPage(),
          '/login': (BuildContext context) => new LoginPage(),
        });
  }
}
