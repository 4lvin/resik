import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_resik/src/blocs/listSampahBloc.dart';
import 'package:new_resik/src/blocs/memberBloc.dart';
import 'package:new_resik/src/models/getPenukaranModel.dart';
import 'package:new_resik/src/pref/preference.dart';
import 'package:new_resik/src/ui/utils/colors.dart';
import 'package:new_resik/src/ui/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TarikTabunganPage extends StatefulWidget {
  TarikTabunganPage({this.saldo});

  String? saldo;

  @override
  _TarikTabunganPageState createState() => _TarikTabunganPageState();
}

class _TarikTabunganPageState extends State<TarikTabunganPage> {
  bool selected = false;
  String? jenis;
  String? id;
  String? idPenukaran;
  String? idDesa;
  String? kategori;
  String? token;
  bool _validate = false;
  String? _selectedNominal;
  List<String> _nominal = [
    '2000',
    '5000',
    '10000',
    '20000',
    '50000',
    '100000',
  ];
  var _noHp = TextEditingController();
  var _nominalText = TextEditingController();

  @override
  void initState() {
    getId().then((onValue) {
      setState(() {
        getIdDesa().then((desa) {
          idDesa = desa;
          blocListSampah.getPenukaran(desa);
        });
        id = onValue;
      });
    });
    getToken().then((value) {
      token = value;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (selected == false) {
          Navigator.pop(context);
        } else {
          setState(() {
            selected = false;
          });
        }
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tarik Saldo"),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Center(child: Text("Saldo Anda")),
                Center(
                    child: Text(
                  "Rp. ${widget.saldo == null ? "0" : widget.saldo}",
                  style: TextStyle(fontSize: 21),
                )),
                SizedBox(
                  height: 21,
                ),
                Center(child: Text("Tukar Saldo")),
                SizedBox(
                  height: 21,
                ),
                StreamBuilder(
                    stream: blocListSampah.listPenukaran,
                    builder:
                        (context, AsyncSnapshot<GetPenukaranModel> snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: GridView.builder(
                                primary: false,
                                itemCount: snapshot.data!.data!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 8.0,
                                ),
                                itemBuilder: (BuildContext context, int i) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selected = true;
                                        jenis =
                                            snapshot.data!.data![i].keterangan;
                                        kategori =
                                            snapshot.data!.data![i].idKategori;
                                        idPenukaran =
                                            snapshot.data!.data![i].idPenukaran;
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: colorses.gradient),
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
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Container(
                                            height: 50.0,
                                            width: 50.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              image: DecorationImage(
                                                  image: NetworkImage(snapshot
                                                      .data!.data![i].icon!),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              snapshot
                                                  .data!.data![i].keterangan!,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })
              ],
            ),
            selected
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black45,
                  )
                : Container(),
            selected
                ? AnimatedContainer(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2 - 120),
                    duration: Duration(seconds: 2),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: 16, left: 12, right: 12, bottom: 12),
                          width: MediaQuery.of(context).size.width - 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                  3.0, // horizontal, move right 10
                                  3.0, // vertical, move down 10
                                ),
                              )
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text("$jenis"),
                                jenis == "Pulsa"
                                    ? Center(
                                        child: Container(
                                        margin: EdgeInsets.only(top: 5),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                100,
                                        child: TextField(
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          controller: _noHp,
                                          cursorColor: Color(0xff740e13),
                                          style: TextStyle(fontSize: 16),
                                          decoration: InputDecoration(
                                            labelText: "No Hp",
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ))
                                    : Container(),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text("Nominal"),
                                ),
                                jenis == "Pulsa"
                                    ? Container(
                                        margin: EdgeInsets.only(left: 22),
                                        width: 280,
                                        child: DropdownButton(
                                          value: _selectedNominal,
                                          isExpanded: true,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _selectedNominal = newValue;
                                            });
                                          },
                                          items: _nominal.map((location) {
                                            return DropdownMenuItem(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  // Icon(Icons.done),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    location,
                                                  ),
                                                ],
                                              ),
                                              value: location,
                                            );
                                          }).toList(),
                                        ),
                                      )
                                    : Container(),
                                Column(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _nominalText.text = widget.saldo!;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: colorses.merahLight,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Text(
                                          "Tukar semua saldo",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 22),
                                  width: 280,
                                  child: TextField(
                                    controller: _nominalText,
                                    cursorColor: Color(0xff740e13),
                                    style: TextStyle(fontSize: 16),
                                    decoration: InputDecoration(
                                      errorText: _nominalText.text.length < 3 &&
                                              _validate
                                          ? 'Nominal harus diisi !'
                                          : null,
                                      labelText: "Nominal",
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 18.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = false;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 15.0),
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              50,
                                          padding: EdgeInsets.only(
                                              top: 15.0, bottom: 15.0),
                                          decoration: BoxDecoration(
                                            color: Colors.red[300],
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Text(
                                            "BATAL",
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (jenis == "Pulsa") {
                                            if (_selectedNominal == null) {
                                              Fluttertoast.showToast(
                                                msg: "Nominal harus di isi!",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                              );
                                            } else if (int.parse(
                                                    widget.saldo!) <
                                                int.parse(_selectedNominal!)) {
                                              Alert(
                                                context: context,
                                                type: AlertType.warning,
                                                title: "Peringatan",
                                                desc: "Saldo anda kurang",
                                                buttons: [
                                                  DialogButton(
                                                    child: Text(
                                                      "OK",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 20),
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    width: 120,
                                                  ),
                                                ],
                                              ).show();
                                            } else {
                                              Dialogs.showLoading(context);
                                              String tgl = DateTime.now()
                                                      .year
                                                      .toString() +
                                                  "-" +
                                                  DateTime.now()
                                                      .month
                                                      .toString() +
                                                  "-" +
                                                  DateTime.now().day.toString();
                                              blocMember.penukaran(
                                                id!,
                                                idPenukaran!,
                                                idDesa!,
                                                tgl,
                                                int.parse(_selectedNominal!),
                                                _noHp.text.toString(),
                                                token!,
                                              );
                                              blocMember.resGetPenukaran
                                                  .listen((onData) {
                                                if (onData.status == true) {
                                                  Alert(
                                                    context: context,
                                                    type: AlertType.success,
                                                    title: "Success",
                                                    desc:
                                                        "Permintaan anda sedang di proses admin\n terimakasih",
                                                    buttons: [
                                                      DialogButton(
                                                        child: Text(
                                                          "OK",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 20),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pushNamedAndRemoveUntil(
                                                            '/controller',
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false,
                                                          );
                                                        },
                                                        width: 120,
                                                      ),
                                                    ],
                                                  ).show();
                                                }
                                              });
                                            }
                                          } else {
                                            if (_nominalText.text.isEmpty) {
                                              setState(() {
                                                _validate = true;
                                              });
                                            } else if (int.parse(
                                                    widget.saldo!) <
                                                int.parse(_nominalText.text)) {
                                              Alert(
                                                context: context,
                                                type: AlertType.warning,
                                                title: "Peringatan",
                                                desc: "Saldo anda kurang",
                                                buttons: [
                                                  DialogButton(
                                                    child: Text(
                                                      "OK",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 20),
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    width: 120,
                                                  ),
                                                ],
                                              ).show();
                                            } else {
                                              Dialogs.showLoading(context);
                                              String tgl = DateTime.now()
                                                      .year
                                                      .toString() +
                                                  "-" +
                                                  DateTime.now()
                                                      .month
                                                      .toString() +
                                                  "-" +
                                                  DateTime.now().day.toString();
                                              blocMember.penukaran(
                                                id!,
                                                idPenukaran!,
                                                idDesa!,
                                                tgl,
                                                int.parse(_nominalText.text),
                                                _noHp.text.toString(),
                                                token!,
                                              );
                                              blocMember.resGetPenukaran
                                                  .listen((onData) {
                                                if (onData.status == true) {
                                                  Alert(
                                                    context: context,
                                                    type: AlertType.success,
                                                    title: "Success",
                                                    desc:
                                                        "Permintaan anda sedang di proses admin\n terimakasih",
                                                    buttons: [
                                                      DialogButton(
                                                        child: Text(
                                                          "OK",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 20),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pushNamedAndRemoveUntil(
                                                            '/controller',
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false,
                                                          );
                                                        },
                                                        width: 120,
                                                      ),
                                                    ],
                                                  ).show();
                                                }
                                              });
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              50,
                                          padding: EdgeInsets.only(
                                              top: 15.0, bottom: 15.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green[300],
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Text(
                                            "TUKAR",
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
