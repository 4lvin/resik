import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_resik/src/blocs/memberBloc.dart';
import 'package:new_resik/src/pref/preference.dart';
import 'package:new_resik/src/ui/utils/colors.dart';
import 'package:new_resik/src/ui/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

class CekPinPage extends StatefulWidget {
  CekPinPage({this.noKk, this.token});
  String? noKk;
  String? token;
  @override
  _CekPinPageState createState() => _CekPinPageState();
}

class _CekPinPageState extends State<CekPinPage> {
  int _counter = 0;
  DateTime? parsedDate;

  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  Future _onPasscodeEntered(String enteredPasscode) async {
    Dialogs.showLoading(context);
    blocMember.checkPin(widget.noKk!, enteredPasscode, widget.token!);
    blocMember.getPin.listen((onData) {
      if (onData.status == true) {
        setToken(onData.data!.idToken!);
        setNama(onData.data!.namaAnggota!);
        setId(onData.data!.idAnggota!);
        setIdDesa(onData.data!.idDesa!);
      }
      if (onData.status == false) {
        setState(() {
          _counter++;
        });
        Future.delayed(Duration(seconds: 2)).then((value) {
          Dialogs.dismiss(context);
        });
        if (_counter >= 4) {
          Fluttertoast.showToast(
            msg: "Anda salah memasukkan pin 3x harap hubungi CS kami",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Pin yang anda masukkan salah!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      }
      _verificationNotifier.add(onData.status!);
    }).onError((error) {
      Dialogs.dismiss(context);
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    });
    //bool isValid = '123456' == enteredPasscode;
  }

  _authenticationPassed() {
    Dialogs.dismiss(context);
    Navigator.pushNamedAndRemoveUntil(
        context, '/controller', (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blueGrey));
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PasscodeScreen(
            title: Text(
              'Masukkan Kode Keamanan Anda',
              style: TextStyle(color: Colors.white),
            ),
            circleUIConfig: CircleUIConfig(
                fillColor: colorses.hijauDasar, borderColor: Colors.blueGrey),
            keyboardUIConfig:
                KeyboardUIConfig(primaryColor: colorses.hijauDasar),
            passwordEnteredCallback: _onPasscodeEntered,
            isValidCallback: _authenticationPassed,
            cancelButton: Text("Cancel"),
            deleteButton: Text("Delete"),
            shouldTriggerVerification: _verificationNotifier.stream,
          ),
        ),
      ],
    ));
  }
}
