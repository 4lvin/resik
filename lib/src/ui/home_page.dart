import 'package:b_sampah/src/blocs/memberBloc.dart';
import 'package:b_sampah/src/pref/preference.dart';
import 'package:b_sampah/src/ui/account_page.dart';
import 'package:b_sampah/src/ui/cekHargaList_page.dart';
import 'package:b_sampah/src/ui/cekTransaksi.dart';
import 'package:b_sampah/src/ui/tarikTabunganPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _saldo;
  String nama;
  String id;

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
      setState(() {
        id = onValue;
      });
    });
    getNama().then((value) {
      setState(() {
        nama = value;
      });
    });
    blocMember.resGetSaldo.listen((onData) {
      setState(() {
        _saldo = onData.data[0].saldo;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      height: MediaQuery.of(context).size.height / 4 - 20,
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
                        greeting(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 85.0, left: 18.0),
                        child: Center(
                            child: Text(
                          "Saldo",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ))),
                    Container(
                        margin: const EdgeInsets.only(top: 105.0, left: 18.0),
                        child: Center(
                            child: Text(
                          "Rp. ${_saldo == null ? "0" : _saldo}",
                          style: TextStyle(fontSize: 21, color: Colors.white),
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
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 4.0,
                      shrinkWrap: true,
                      children: <Widget>[
                        _buildCard(
                            'Tarik Saldo', 1, "assets/pos.png", linkTarik),
                        _buildCard('Cek Transaksi', 2, "assets/invoice.png",
                            linkCekTrx),
                        _buildCard(
                            'Jual Sampah', 3, "assets/tag.png", linkListHarga),
                        _buildCard('Akun', 4, "assets/account.png", linkAkun),
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

  void linkListHarga() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new ListHargaPage(idAnggota: id)));
  }

  void linkAkun() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new AkunPage()));
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
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5.0,
        child: GestureDetector(
          onTap: () {
            kategori();
//            Navigator.of(context).push(new MaterialPageRoute(
//                builder: (BuildContext context) =>
//                new ListHargaPage(kategori: kategori,)));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 15.0),
              Stack(children: <Widget>[
                Container(
                  height: 100.0,
                  width: 100.0,
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
        margin: cardIndex.isEven
            ? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0)
            : EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0));
  }
}
