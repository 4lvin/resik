import 'package:b_sampah/src/blocs/memberBloc.dart';
import 'package:b_sampah/src/pref/preference.dart';
import 'package:b_sampah/src/ui/account_page.dart';
import 'package:b_sampah/src/ui/cekHargaList_page.dart';
import 'package:b_sampah/src/ui/cekTransaksi.dart';
import 'package:b_sampah/src/ui/tarikTabunganPage.dart';
import 'package:b_sampah/src/ui/utils/colors.dart';
import 'package:b_sampah/src/ui/utils/fadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _saldo;
  String nama;
  String id;
  var formatter = NumberFormat('#,###,###', 'en_US');

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 11) {
      return 'Selamat pagi $nama';
    }
    if (hour < 15) {
      return 'Selamat siang $nama';
    }
    if (hour < 18) {
      return 'Selamat sore $nama';
    }
    return 'Selamat malam $nama';
  }

  @override
  void initState() {
    getId().then((onValue) {
      blocMember.getSaldo(onValue);
      if (this.mounted){
        setState(() {
          id = onValue;
        });
      }
    });
    getNama().then((value) {
      if (this.mounted){
        setState(() {
          nama = value;
        });
      }
    });
    blocMember.resGetSaldo.listen((onData) {
      if (this.mounted){
        setState(() {
          _saldo = onData.data[0].saldo;
        });
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blueGrey));
    return new Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          reverse: true,
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 3 - 20,
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
                    Container(
                      margin: EdgeInsets.only(bottom: 12, top: 40, left: 14),
                      child: Text(
                        greeting()??"",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 135.0, left: 18.0),
                        child: Center(
                            child: Text(
                          "Saldo",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ))),
                    Container(
                        margin: const EdgeInsets.only(top: 155.0, left: 18.0),
                        child: Center(
                            child: Text(
                          "Rp. ${_saldo == null ? "0" : formatter.format(int.parse(_saldo))}",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ))),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3.0 - 60.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    GridView.count(
                      crossAxisCount: 2,
                      primary: false,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 4.0,
                      shrinkWrap: true,
                      children: <Widget>[
                        _buildCard(
                            'Tarik Saldo', 1, "assets/pos.png", linkTarik),
                        _buildCard('Cek Transaksi', 2, "assets/invoice.png",
                            linkCekTrx),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void linkTarik() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new TarikTabunganPage(
              saldo: _saldo,
            )));
  }

  void linkCekTrx() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new CekTransaksi()));
  }

  Widget _buildCard(
      String name, int cardIndex, String images, dynamic kategori) {
    return FadeAnimation(
      0.3,Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          elevation: 5.0,
          child: InkWell(
            onTap: () {
              kategori();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.grey[200],Colors.white]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15.0),
                  Stack(children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(image: AssetImage(images)),
                      ),
                    ),
                  ]),
                  SizedBox(height: 9.0),
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          margin: cardIndex.isEven
              ? EdgeInsets.fromLTRB(15.0, 50.0, 30.0, 15.0)
              : EdgeInsets.fromLTRB(30.0, 50.0, 15.0, 15.0)),
    );
  }
}
