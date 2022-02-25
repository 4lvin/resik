import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_resik/src/blocs/memberBloc.dart';
import 'package:new_resik/src/pref/preference.dart';
import 'package:new_resik/src/ui/utils/colors.dart';
import 'package:new_resik/src/ui/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UbahPinPage extends StatefulWidget {
  @override
  _UbahPinPageState createState() => _UbahPinPageState();
}

class _UbahPinPageState extends State<UbahPinPage> {
  var _pinLama = TextEditingController();
  var _pinBaru = TextEditingController();
  bool _validate = false;
  bool passwordVisible = true;
  bool passwordBaruVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Ganti Pin"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              width: MediaQuery.of(context).size.width - 70,
              child: TextFormField(
                style: TextStyle(height: 1),
                obscureText: passwordVisible,
                // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    prefixIcon: Icon(Icons.vpn_key),
                    labelText: 'Masukkan Pin Lama',
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan Pin Lama Anda',
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 12.0),
                    errorText: _pinLama.text.length < 6 && _validate
                        ? 'Pin lama harus diisi dan mengandung 6 angka!'
                        : null),
                keyboardType: TextInputType.phone,
                maxLength: 6,
                controller: _pinLama,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              width: MediaQuery.of(context).size.width - 70,
              child: TextFormField(
                style: TextStyle(height: 1),
                obscureText: passwordBaruVisible,
                // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordBaruVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordBaruVisible = !passwordBaruVisible;
                        });
                      },
                    ),
                    prefixIcon: Icon(Icons.vpn_key),
                    labelText: 'Masukkan Pin Baru',
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan Pin Baru Anda',
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 12.0),
                    errorText: _pinBaru.text.length < 6 && _validate
                        ? 'Pin baru harus diisi dan mengandung 6 angka!'
                        : null),
                keyboardType: TextInputType.phone,
                maxLength: 6,
                controller: _pinBaru,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              width: MediaQuery.of(context).size.width - 70,
              decoration: BoxDecoration(
                color: colorses.hijauDasar,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              //color: Colors.white,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  setState(() {
                    if (_pinBaru.text.isEmpty || _pinLama.text.isEmpty) {
                      _validate = true;
                    } else {
                      _validate = false;
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _confirmSave();
                    }
                  });
                },
                child: Text("Simpan",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xffffffff), fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  _saveChangePin() {
    Dialogs.showLoading(context);
    getId().then((onValue) {
      getToken().then((token) {
        setState(() {
          blocMember.ubahPin(onValue, token, _pinLama.text, _pinBaru.text);
          blocMember.resUbahPin.listen((data) {
            if (data.status == true) {
              Future.delayed(Duration(seconds: 2)).then((value) {
                Dialogs.dismiss(context);
              });
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/controllPage', (Route<dynamic> route) => false);
            } else {
              Future.delayed(Duration(seconds: 2)).then((value) {
                Dialogs.dismiss(context);
              });
              Fluttertoast.showToast(
                msg: data.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
            }
          }).onError((e) {
            Future.delayed(Duration(seconds: 2)).then((value) {
              Dialogs.dismiss(context);
            });
            Fluttertoast.showToast(
              msg: e.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
          });
        });
      });
    });
  }

  _confirmSave() {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Konfirmasi",
      desc: "Apakah anda yakin mengganti pin?",
      buttons: [
        DialogButton(
          child: Text(
            "YA",
            style: TextStyle(color: Colors.green, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
        DialogButton(
          child: Text(
            "Tidak",
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}
