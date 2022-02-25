import 'dart:io';

import 'package:new_resik/src/blocs/listSampahBloc.dart';
import 'package:new_resik/src/blocs/memberBloc.dart';
import 'package:new_resik/src/models/getSampahModel.dart';
import 'package:new_resik/src/pref/preference.dart';
import 'package:new_resik/src/ui/utils/colors.dart';
import 'package:new_resik/src/ui/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListHargaPage extends StatefulWidget {
  @override
  _ListHargaPageState createState() => _ListHargaPageState();
}

class _ListHargaPageState extends State<ListHargaPage> {
  bool _show = false;
  String? idSampah;
  String? hrg;
  String? token;
  String? idDesa;
  String? idAnggota;
  List qtyList = [];
  List totalHarga = [];
  List postDetail = [];
  List namaSampah = [];
  List hargaSetor = [];
  Color setor = Colors.grey;

  @override
  void initState() {
    getIdDesa().then((value) {
      blocListSampah.getSampah(value);
      setState(() {
        idDesa = value;
      });
    });
    getToken().then((value) {
      setState(() {
        token = value;
      });
    });
    getId().then((value) {
      setState(() {
        idAnggota = value;
      });
    });
    blocListSampah.listHarga.listen((value) {
      for (var i = 0; i < value.data!.length; i++) {
        qtyList.add(0);
        totalHarga.add(0);
        postDetail.add(0);
        namaSampah.add(0);
        hargaSetor.add(0);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_show == false) {
          Navigator.pop(context);
        } else {
          setState(() {
            _show = false;
          });
        }
        return Future.value(false);
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SafeArea(
                    child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
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
                  ),
                  child: Center(
                      child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "List Sampah",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  )),
                )),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 3, bottom: 50),
                    child: StreamBuilder(
                      stream: blocListSampah.listHarga,
                      builder:
                          (context, AsyncSnapshot<GetSampahModel> snapshot) {
                        if (snapshot.hasData) {
                          return buildList(snapshot);
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (totalHarga.reduce((a, b) => a + b) == 0) {
                    } else {
                      _show = true;
                    }
                  });
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: setor,
                  child: Center(
                      child: Text(
                    "SETOR",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
            _show == true
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black54,
                  )
                : Container(),
            _show == true
                ? Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 470,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              "Detail Setor",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            color: Colors.blueGrey,
                            height: 30,
                            margin: EdgeInsets.only(left: 2, right: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  // width: 93,
                                  child: Center(
                                      child: Text(
                                    "Nama Sampah",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                                Container(
                                  // width: 50,
                                  child: Center(
                                      child: Text("Jumlah",
                                          style:
                                              TextStyle(color: Colors.white))),
                                ),
                                Container(
                                  // width: 70,
                                  child: Center(
                                      child: Text("Harga",
                                          style:
                                              TextStyle(color: Colors.white))),
                                ),
                                Container(
                                  // width: 83,
                                  child: Center(
                                      child: Text("Total",
                                          style:
                                              TextStyle(color: Colors.white))),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 250,
                            child: ListView.builder(
                                padding: EdgeInsets.only(top: 0),
                                itemCount: namaSampah.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return namaSampah[i] != 0
                                      ? Container(
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(
                                              left: 2, right: 2),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                //                    <--- top side
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                            ),
                                            color: Colors.grey[200],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                  width: 110,
                                                  height: 30,
                                                  child:
                                                      Text("${namaSampah[i]}")),
                                              Container(
                                                  height: 30,
                                                  child: Text(
                                                    "${qtyList[i]}",
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Container(
                                                  //width: 70,
                                                  height: 30,
                                                  child: Text(
                                                    "Rp. ${hargaSetor[i]}",
                                                    textAlign: TextAlign.right,
                                                  )),
                                              Container(
                                                  //width: 103,
                                                  height: 30,
                                                  child: Text(
                                                    "Rp. ${totalHarga[i]}",
                                                    textAlign: TextAlign.right,
                                                  )),
                                            ],
                                          ),
                                        )
                                      : Container();
                                }),
                          ),
                          Spacer(),
                          Center(
                            child: Text("Total"),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: Text(
                              "Rp. ${totalHarga.reduce((a, b) => a + b)}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Dialogs.showLoading(context);
                              postDetail.removeWhere((value) => value == 0);
                              String tgl = DateTime.now().year.toString() +
                                  "-" +
                                  DateTime.now().month.toString() +
                                  "-" +
                                  DateTime.now().day.toString();
                              blocMember.setorSampah(
                                idDesa!,
                                idAnggota!,
                                tgl,
                                postDetail,
                                token!,
                              );
                              blocMember.resGetSetor.listen((onData) {
                                if (onData.status == true) {
                                  Dialogs.dismiss(context);
                                  Alert(
                                    context: context,
                                    type: AlertType.success,
                                    title: "Success",
                                    desc:
                                        "Saldo Anda akan bertambah dan tunggu penjemputan sampah\n terimakasih",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "YA",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 20),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/controller',
                                                  (Route<dynamic> route) =>
                                                      false);
                                        },
                                        width: 120,
                                      ),
                                    ],
                                  ).show();
                                } else {
                                  Dialogs.dismiss(context);
                                  Alert(
                                    context: context,
                                    type: AlertType.error,
                                    title: "Gagal",
                                    desc: "Upload gagal",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "YA",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 20),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        width: 120,
                                      ),
                                    ],
                                  ).show();
                                }
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 + 50,
                              height: 50,
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(14)),
                              child: Center(
                                child: Text(
                                  "KIRIM",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<GetSampahModel> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 0, bottom: 60),
        itemCount: snapshot.data!.data!.length,
        itemBuilder: (BuildContext context, int i) {
          if (qtyList[i] != 0) {
            postDetail[i] = {
              "id_sampah": snapshot.data!.data![i].idSampah,
              "jumlah": qtyList[i],
              "harga": snapshot.data!.data![i].hargaSetor
            };
            namaSampah[i] = snapshot.data!.data![i].namaSampah;
            hargaSetor[i] = snapshot.data!.data![i].hargaSetor;
          } else {
            postDetail[i] = 0;
            namaSampah[i] = 0;
            hargaSetor[i] = 0;
          }
          return Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
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
            ),
            child: Row(
              children: <Widget>[
                Container(
                  height: 100.0,
                  width: 100.0,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                      child: FadeInImage(
                          placeholder: snapshot.data!.data![i].image ==
                                  "https://banksampahpasuruan.com/banksampah_ws/uploads/sampah/"
                              ? AssetImage("assets/tfupload.jpg")
                              : AssetImage('assets/loading.gif'),
                          image: NetworkImage(snapshot.data!.data![i].image!),
                          fit: BoxFit.cover)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
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
                    color: Colors.blueGrey,
                    image: DecorationImage(
                        image: NetworkImage(snapshot.data!.data![i].image!),
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 130,
                        child: Text(
                          snapshot.data!.data![i].namaSampah!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Text(
                        "Rp. " + snapshot.data!.data![i].hargaSetor!,
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    qtyList[i] != 0
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                qtyList[i] = qtyList[i] - 1;
                                totalHarga[i] = int.parse(
                                        snapshot.data!.data![i].hargaSetor!) *
                                    qtyList[i];
                                if (totalHarga.reduce((a, b) => a + b) == 0) {
                                  setor = Colors.grey;
                                } else {
                                  setor = colorses.hijauDasar;
                                }
                              });
                            },
                            child: Icon(
                              Icons.indeterminate_check_box,
                              size: 40,
                              color: colorses.hijauDasar,
                            ),
                          )
                        : Icon(
                            Icons.indeterminate_check_box,
                            size: 40,
                            color: Colors.grey,
                          ),
                    Container(
                        margin: EdgeInsets.only(left: 12, right: 12),
                        child: Text(qtyList[i].toString())),
                    InkWell(
                        onTap: () {
                          setState(() {
                            qtyList[i] = qtyList[i] + 1;
                            totalHarga[i] =
                                int.parse(snapshot.data!.data![i].hargaSetor!) *
                                    qtyList[i];
                            if (totalHarga.reduce((a, b) => a + b) == 0) {
                              setor = Colors.grey;
                            } else {
                              setor = colorses.hijauDasar;
                            }
                          });
                        },
                        child: Icon(
                          Icons.add_box,
                          size: 40,
                          color: colorses.hijauDasar,
                        ))
                  ],
                ))
              ],
            ),
          );
        });
  }
}
