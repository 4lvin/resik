import 'package:b_sampah/src/blocs/memberBloc.dart';
import 'package:b_sampah/src/pref/preference.dart';
import 'package:b_sampah/src/ui/pengaturanPage.dart';
import 'package:b_sampah/src/ui/utils/colors.dart';
import 'package:b_sampah/src/ui/utils/dialogAlert/sweetDialog.dart';
import 'package:b_sampah/src/ui/utils/fadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class AkunPage extends StatefulWidget {
  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  String nama;
  String _saldo;
  String _penjualan;
  String _tarik;
  String id;
  String berat;
  var komentar = TextEditingController();
  @override
  void initState() {
    getId().then((onValue){
        setState(() {
          blocMember.getSaldo(onValue);
          id = onValue;
        });
    });
    getNama().then((value){
      setState(() {
        nama = value;
      });
    });
    blocMember.resGetSaldo.listen((onData){
      if(this.mounted){
        setState(() {
          _saldo = onData.data[0].saldo;
          _penjualan = onData.data[0].totalSetor;
          _tarik = onData.data[0].totalTukar;
          berat = onData.data[0].totalBerat;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blueGrey));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2-50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 3.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                            3.0, // horizontal, move right 10
                            5.0, // vertical, move down 10
                          ),
                        )
                      ],
                      gradient: new LinearGradient(
                          colors: [Colors.blueGrey, Colors.grey],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp)),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        duration: Duration(milliseconds: 400),
                                        child: PengaturanPage()));
                              },
                              child: Container(
                                  margin: EdgeInsets.only(right: 14),
                                  child: Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                  )),
                            )),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FadeAnimation(
                              0.1,
                              Stack(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 18.0),
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                        border: Border.all(
                                            color: Colors.white, width: 1),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/account.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FadeAnimation(
                                    0.3,
                                    Container(
                                        width: 210,
                                        margin: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Text(
                                          nama == null ? "" : nama,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ))),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 10),
                                    child: Text(
                                      id == null ? "" : id,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        FadeAnimation(
                            0.3,
                            Center(
                              child: Card(
                                margin:
                                EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                                ),
                                elevation: 4.0,
                                color: Colors.white,
                                child: Container(
                                    width:
                                    MediaQuery.of(context).size.width - 40,
                                    height: 70,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text("Penjualan",
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                              Row(
                                                children: <Widget>[
                                                  Text("Rp. ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                  Text(_penjualan ?? 0.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                ],
                                              )
                                            ],
                                          ),
                                          Container(
                                            height: 50,
                                            width: 1,
                                            color: Colors.grey[300],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "Tarik Saldo",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text("Rp. ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                  Text(
                                                    _tarik ?? 0.toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            )),
                        FadeAnimation(
                            0.4,
                            Center(
                              child: Card(
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                                ),
                                elevation: 4.0,
                                color: Colors.white,
                                child: Container(
                                    width:
                                    MediaQuery.of(context).size.width - 40,
                                    height: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text("Berat/Kg",
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                              Text("${berat??"0"}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold))
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 12),
                                            height: 60,
                                            width: 1,
                                            color: Colors.grey[300],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      2 -
                                                      40,
                                                  child: Text(
                                                    "Saldo",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  )),
                                              Row(
                                                children: <Widget>[
                                                  Text("Rp. ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 16)),
                                                  Text(
                                                    _saldo ?? 0.toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 21),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
