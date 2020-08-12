import 'package:b_sampah/src/blocs/memberBloc.dart';
import 'package:b_sampah/src/pref/preference.dart';
import 'package:b_sampah/src/ui/utils/dialogAlert/sweetDialog.dart';
import 'package:flutter/material.dart';

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
  var komentar = TextEditingController();
  @override
  void initState() {
    getId().then((onValue){
      setState(() {
        blocMember.getSaldo(onValue);
        id = onValue;
      });
    });
    blocMember.resGetSaldo.listen((onData){
      setState(() {
        _saldo = onData.data[0].saldo;
        _penjualan = onData.data[0].totalSetor;
        _tarik = onData.data[0].totalTukar;
        nama = onData.data[0].namaAnggota;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150.0,
                    color: Colors.blueGrey,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 72.0),
                    child: Center(child: Text("$nama", style: TextStyle(fontSize:18.0),)),
                  ),
//            Row(
//              children: <Widget>[
//                Container(
//                  margin: const EdgeInsets.only(top: 16.0,left: 16.0),
//                  child: Text("Email : ",style: TextStyle(fontSize: 16.0),),
//                ),
//                Container(
//                  margin: const EdgeInsets.only(top: 16.0),
//                  child: Text(widget.user.email, style: TextStyle(fontSize:16.0),),
//                ),
//              ],
//            ),
                  Container(
                    margin: const EdgeInsets.only(top: 16.0) ,
                    height: MediaQuery.of(context).size.height/3,
                    child:ExpansionTile(
                        title: new Text("Total Saldo     Rp $_saldo", style: TextStyle(color: Colors.blueAccent),),
                        backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
                        children: <Widget>[
                          new ListTile(
                            title: Text('total penjualan          Rp $_penjualan'),
                          ),
                          new ListTile(
                            title: Text('tarik saldo                  Rp $_tarik'),
                          ),
                        ]
                    ),
                  ),
                  Text("Kotak Saran"),
                  Container(
                    width: MediaQuery.of(context).size.width-80,
                    color: Colors.grey[200],
                    child: TextField(
                      controller: komentar,
                      maxLines: 4,
                      decoration: InputDecoration.collapsed(hintText: "Masukkan Saran Anda"),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      blocMember.kotakSaran(id, komentar.text.toString());
                      komentar.clear();
                      SweetAlert.show(context,
                        title: "Terkirim",
                        subtitle: Center(
                          child: Text("Terimakasih atas masukan dan saran dari anda.")
                        ),
                        style:
                        SweetAlertStyle.success,);
                    },
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.only(top: 8,bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(child: Text("Kirim")),
                    ),
                  )
                ],
              ),

            ),
            Positioned(
              right: 12,
              child: InkWell(
                onTap: (){
                 _confirmExit();
                },
                child: SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.exit_to_app,color: Colors.red,),
                        Text("Logout",style: TextStyle(fontSize: 12,color: Colors.white),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 100.0),
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                          image: DecorationImage(
                              image: new AssetImage("assets/account.png"),fit: BoxFit.cover)
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  _confirmExit() {
    SweetAlert.show(context,
        title: "Konfirmasi",
        subtitle: Center(child: Text("Apakah Anda yakin akan keluar?")),
        style: SweetAlertStyle.confirm,
//        cancelButtonColor: Color(0xffababab),
        cancelButtonText: "Tidak",
        confirmButtonText: "YA",
        confirmButtonColor: Color(0xff96d873),
        showCancelButton: true, onPress: (bool isConfirm) {
          if (isConfirm) {
            rmvIsLogin();
            rmvNama();
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/login');
            return false;
          }
        });
  }
}
