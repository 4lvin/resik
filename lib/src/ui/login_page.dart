import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_resik/src/blocs/memberBloc.dart';
import 'package:new_resik/src/ui/cekPinPage.dart';
import 'package:new_resik/src/ui/utils/colors.dart';
import 'package:new_resik/src/ui/utils/loading.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _nik = TextEditingController();
  var _password = TextEditingController();
  bool _validate = false;
  bool passwordVisible = true;
  // FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  String? tokenUser;

  void showInSnackBar(BuildContext context, String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  void initState() {
    // _firebaseMessaging.getToken().then((token) {
    //   setState(() {
    //     tokenUser = token;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blueGrey, Colors.white])),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        margin: EdgeInsets.only(top: 90),
                        child: Image.asset(
                          "assets/logo.png",
                          scale: 5,
                        ))),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Text(
                        "V 1.0.5",
                        style: TextStyle(color: Colors.grey),
                      ))),
              Align(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 4),
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.height / 2 - 130,
                  duration: Duration(milliseconds: 400),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Center(
                                child: Container(
                              margin: EdgeInsets.only(top: 20),
                              width: MediaQuery.of(context).size.width - 100,
                              child: TextField(
                                controller: _nik,
                                cursorColor: Color(0xff740e13),
                                style: TextStyle(fontSize: 16),
                                decoration: InputDecoration(
                                  errorText: _nik.text.length < 3 && _validate
                                      ? 'No KK/kode nasabah harus diisi !'
                                      : null,
                                  labelText: "No KK/kode nasabah",
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            )),
                            // Center(
                            //     child: Container(
                            //   margin: EdgeInsets.only(top: 10),
                            //   width: MediaQuery.of(context).size.width - 100,
                            //   child: TextField(
                            //     obscureText: passwordVisible,
                            //     controller: _password,
                            //     cursorColor: Color(0xff740e13),
                            //     style: TextStyle(fontSize: 16),
                            //     decoration: InputDecoration(
                            //       suffixIcon: IconButton(
                            //         icon: Icon(
                            //           passwordVisible
                            //               ? Icons.visibility_off
                            //               : Icons.visibility,
                            //           color: Theme.of(context).backgroundColor,
                            //         ),
                            //         onPressed: () {
                            //           setState(() {
                            //             passwordVisible = !passwordVisible;
                            //           });
                            //         },
                            //       ),
                            //       errorText:
                            //           _password.text.length < 3 && _validate
                            //               ? 'Password harus diisi !'
                            //               : null,
                            //       labelText: "Password",
                            //     ),
                            //   ),
                            // )),
                            SizedBox(
                              height: 27,
                            ),
                            Material(
                              shadowColor: Colors.grey[50],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              elevation: 9.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorses.hijauDasar,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Material(
                                  type: MaterialType.transparency,
                                  elevation: 9.0,
                                  color: Colors.transparent,
                                  shadowColor: Colors.grey[50],
                                  child: InkWell(
                                    splashColor: Colors.white30,
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    onTap: () {
                                      if (_nik.text.isEmpty) {
                                        setState(() {
                                          _validate = true;
                                        });
                                      } else {
                                        Dialogs.showLoading(context);
                                        _validate = false;
                                        blocMember.checkId(_nik.text);
                                        blocMember.getUser.listen((onData) {
                                          if (onData.status == true) {
                                            Dialogs.dismiss(context);
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    settings:
                                                        const RouteSettings(
                                                            name:
                                                                '/codeCallPage'),
                                                    builder: (context) =>
                                                        CekPinPage(
                                                          noKk: onData.data![0]
                                                              .idAnggota,
                                                          token: tokenUser!,
                                                        )));
                                          } else {
                                            Future.delayed(Duration(seconds: 2))
                                                .then((value) {
                                              Dialogs.dismiss(context);
                                            });
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            Fluttertoast.showToast(
                                              msg: "User tidak ditemukan!",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                            );
                                          }
                                        }).onError((e) {
                                          Future.delayed(Duration(seconds: 2))
                                              .then((value) {
                                            Dialogs.dismiss(context);
                                          });
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          Fluttertoast.showToast(
                                            msg: e.toString(),
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                          );
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          70,
                                      height: 50,
                                      child: Center(
                                          child: Text(
                                        "MASUK",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
