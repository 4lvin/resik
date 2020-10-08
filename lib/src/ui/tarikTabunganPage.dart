import 'package:b_sampah/src/blocs/listSampahBloc.dart';
import 'package:b_sampah/src/blocs/memberBloc.dart';
import 'package:b_sampah/src/models/getPenukaranModel.dart';
import 'package:b_sampah/src/pref/preference.dart';
import 'package:b_sampah/src/ui/utils/colors.dart';
import 'package:b_sampah/src/ui/utils/dialogAlert/sweetDialog.dart';
import 'package:b_sampah/src/ui/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class TarikTabunganPage extends StatefulWidget {
  TarikTabunganPage({this.saldo});

  String saldo;

  @override
  _TarikTabunganPageState createState() => _TarikTabunganPageState();
}

class _TarikTabunganPageState extends State<TarikTabunganPage> {
  bool selected = false;
  String jenis;
  String id;
  String idPenukaran;
  String idDesa;
  String kategori;
  String token;
  List<String> _nominal = [
    '2000',
    '5000',
    '10000',
    '20000',
    '50000',
    '100000',
  ];
  String _selectedNominal;
  var _noHp = TextEditingController();

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
                    builder: (context, AsyncSnapshot<GetPenukaranModel> snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: GridView.builder(
                                primary: false,
                                itemCount: snapshot.data.data.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 8.0,
                                ),
                                itemBuilder: (BuildContext context, int i) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selected = true;
                                        jenis = snapshot.data.data[i].keterangan;
                                        kategori = snapshot.data.data[i].idKategori;
                                        idPenukaran = snapshot.data.data[i].idPenukaran;
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: colorses.gradient),
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
                                              borderRadius: BorderRadius.circular(8.0),
                                              image: DecorationImage(
                                                  image: NetworkImage(snapshot.data.data[i].icon), fit: BoxFit.cover),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              snapshot.data.data[i].keterangan,
                                              style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2 - 120),
                    duration: Duration(seconds: 2),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 16, left: 12, right: 12, bottom: 12),
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
                                        width: MediaQuery.of(context).size.width - 100,
                                        child: TextField(
                                          textCapitalization: TextCapitalization.sentences,
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
                                Container(
                                  margin: EdgeInsets.only(left: 22),
                                  width: 280,
                                  child: DropdownButton(
                                    value: _selectedNominal,
                                    isExpanded: true,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedNominal = newValue;
                                      });
                                    },
                                    items: _nominal.map((location) {
                                      return DropdownMenuItem(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 18.0),
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
                                          width: MediaQuery.of(context).size.width / 2 - 50,
                                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          decoration: BoxDecoration(
                                            color: Colors.red[300],
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          child: Text(
                                            "BATAL",
                                            style: TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (_selectedNominal == null) {
                                            Toast.show("Nominal harus di isi!", context,
                                                duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                                          } else if (int.parse(widget.saldo) < int.parse(_selectedNominal)) {
                                            SweetAlert.show(
                                              context,
                                              title: "Peringatan",
                                              subtitle: Text(
                                                "Saldo anda kurang",
                                                style: TextStyle(fontSize: 16, color: Colors.grey),
                                              ),
                                              style: SweetAlertStyle.confirm,
                                            );
                                          } else {
                                            Dialogs.showLoading(context);
                                            String tgl = DateTime.now().year.toString() +
                                                "-" +
                                                DateTime.now().month.toString() +
                                                "-" +
                                                DateTime.now().day.toString();
                                            blocMember.penukaran(id, idPenukaran, idDesa, tgl, int.parse(_selectedNominal),
                                                _noHp.text.toString(), token);
                                            blocMember.resGetPenukaran.listen((onData) {
                                              if (onData.status == true) {
                                                SweetAlert.show(context,
                                                    title: "Success",
                                                    subtitle: Center(
                                                      child: Text(
                                                        "Permintaan anda sedang di proses admin\n terimakasih",
                                                        style: TextStyle(fontSize: 16, color: Colors.grey),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                    style: SweetAlertStyle.success,
                                                    showCancelButton: false, onPress: (bool isConfirm) {
                                                  if (isConfirm) {
                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil('/controller', (Route<dynamic> route) => false);
                                                    return false;
                                                  }
                                                });
                                              }
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 2 - 50,
                                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green[300],
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          child: Text(
                                            "TUKAR",
                                            style: TextStyle(color: Colors.white),
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
