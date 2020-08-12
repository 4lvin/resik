import 'dart:async';
import 'package:b_sampah/src/blocs/memberBloc.dart';
import 'package:b_sampah/src/pref/preference.dart';
import 'package:b_sampah/src/ui/utils/loading.dart';
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

  void showInSnackBar(BuildContext context, String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height ,
            child: Stack(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height ,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blueGrey, Colors.white])),
                  child: Align(alignment:Alignment.topCenter,child: Container(margin:EdgeInsets.only(top: 50),child: Image.asset("assets/logo.png",scale: 5,))),
                    ),
                Align(
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    margin: EdgeInsets.only(top: 80),
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.height/2 - 70,
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
                                            ? 'NIK harus diisi !'
                                            : null,
                                        labelText: "NIK",
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  )),
                              Center(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: MediaQuery.of(context).size.width - 100,
                                    child: TextField(
                                      obscureText: passwordVisible,
                                      controller: _password,
                                      cursorColor: Color(0xff740e13),
                                      style: TextStyle(fontSize: 16),
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            passwordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Theme.of(context).backgroundColor,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              passwordVisible = !passwordVisible;
                                            });
                                          },
                                        ),
                                        errorText: _password.text.length < 3 && _validate
                                            ? 'Password harus diisi !'
                                            : null,
                                        labelText: "Password",
                                      ),
                                    ),
                                  )),
                             Center(
                                child: InkWell(
                                  onTap: (){
                                    if (_nik.text.isEmpty || _password.text.isEmpty) {
                                      setState(() {
                                        _validate = true;
                                      });
                                    } else {
                                      setState(() {
                                        _validate = false;
                                        Dialogs.showLoading(context);
                                        blocMember.checkId(_nik.text, _password.text);
                                        blocMember.getUser.listen((onData) {
                                          if (onData.status == true) {
                                            Dialogs.dismiss(context);
                                            setIsLogin("1");
                                            setNama(onData.data.namaAnggota);
                                            setId(onData.data.idAnggota);
                                            Navigator.pushReplacementNamed(context, '/home');
                                          } else {
                                            Dialogs.dismiss(context);
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                            showInSnackBar(context, "User atau Password salah!");
                                          }
                                        });
                                      });
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    margin: EdgeInsets.only(top: 40),
                                    padding: EdgeInsets.only(top:10,bottom: 10,left: 50,right: 50),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.blue
                                    ),
                                    child: Text("LOGIN",style: TextStyle(color: Colors.white),),
                                  ),
                                ),
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
      )
    );
  }
}
