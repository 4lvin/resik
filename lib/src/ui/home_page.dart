import 'package:new_resik/src/blocs/memberBloc.dart';
import 'package:new_resik/src/models/getInformasiModel.dart';
import 'package:new_resik/src/pref/preference.dart';
import 'package:new_resik/src/ui/cekTransaksi.dart';
import 'package:new_resik/src/ui/detail_notif.dart';
import 'package:new_resik/src/ui/tarikTabunganPage.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:new_resik/src/ui/utils/fadeAnimation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _saldo;
  String? nama;
  String? id;
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

  // FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  void fcmSubscribe() {
    // _firebaseMessaging.subscribeToTopic('all');
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    getId().then((onValue) {
      blocMember.getSaldo(onValue);
      if (this.mounted) {
        setState(() {
          id = onValue;
        });
      }
    });
    getIdDesa().then((value) {
      blocMember.getInformasi(value);
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    getId().then((onValue) {
      blocMember.getSaldo(onValue);
      if (this.mounted) {
        setState(() {
          id = onValue;
        });
      }
    });
    getIdDesa().then((value) {
      blocMember.getInformasi(value);
    });
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    getId().then((onValue) {
      blocMember.getSaldo(onValue);
      if (this.mounted) {
        setState(() {
          id = onValue;
        });
      }
    });
    getIdDesa().then((value) {
      blocMember.getInformasi(value);
    });
    getNama().then((value) {
      if (this.mounted) {
        setState(() {
          nama = value;
        });
      }
    });
    blocMember.resGetSaldo.listen((onData) {
      if (this.mounted) {
        setState(() {
          _saldo = onData.data![0].saldo;
        });
      }
    });
    fcmSubscribe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blueGrey));
    return new Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              color: Colors.blueGrey,
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    greeting(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: WaterDropMaterialHeader(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 3 - 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(40.0),
                                    bottomRight: Radius.circular(40.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 3.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(
                                      3.0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                                gradient: new LinearGradient(
                                    colors: [
                                      Colors.blueGrey,
                                      Colors.grey.shade500
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    tileMode: TileMode.clamp)),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(bottom: 12, top: 0, left: 14),
                          //   child:
                          // ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.only(top: 100.0, left: 18.0),
                              child: Text("Saldo",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center)),
                          Container(
                              margin:
                                  const EdgeInsets.only(top: 125.0, left: 18.0),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "Rp. ${_saldo == null ? "0" : formatter.format(int.parse(_saldo!))}",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 3.0 - 80.0),
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
                              _buildCard('Tarik Saldo', 1, "assets/pos.png",
                                  linkTarik),
                              _buildCard('Cek Transaksi', 2,
                                  "assets/invoice.png", linkCekTrx),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Informasi terbaru"),
                  Text("Lihat semua")
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            StreamBuilder(
                stream: blocMember.resInformasi,
                builder: (context, AsyncSnapshot<GetInformasiModel> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.data!.isNotEmpty
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.data!.length < 3
                                ? snapshot.data!.data!.length
                                : 3,
                            itemBuilder: (BuildContext context, int i) {
                              var formatDate = DateFormat('d MMM yyyy')
                                  .format(snapshot.data!.data![i].tanggal!);
                              var formatTime = DateFormat()
                                  .add_jm()
                                  .format(snapshot.data!.data![i].tanggal!);
                              return Container(
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                duration:
                                                    Duration(milliseconds: 400),
                                                child: DetailNotif(
                                                  content: snapshot.data!
                                                      .data![i].keterangan,
                                                  index: i,
                                                  tgl: formatTime,
                                                )));
                                      },
                                      child: ListTile(
                                        leading: Stack(
                                          children: <Widget>[
                                            Container(
                                              width: 50,
                                              height: 50,
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(top: 5),
                                                width: 40,
                                                height: 40,
                                                child: Hero(
                                                    tag: "notif$i",
                                                    child: Image.asset(
                                                        "assets/notif.png"))),
                                          ],
                                        ),
                                        title: Text(
                                          snapshot.data!.data![i].keterangan!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        trailing: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 7, top: 0),
                                              height: 18,
                                              child: Text(
                                                formatDate,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                formatTime,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
//                              Divider(),
                                  ],
                                ),
                              );
                            })
                        : Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.notifications_off,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                  Text(
                                    "Tidak Ada Notifikasi",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Center(
                      child: new CircularProgressIndicator(
                        backgroundColor: Colors.blueGrey,
                      ),
                    );
                  }
                }),
          ],
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
      0.3,
      Card(
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
                    colors: [Colors.grey.shade200, Colors.white]),
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
