
import 'dart:io';

import 'package:b_sampah/src/blocs/listSampahBloc.dart';
import 'package:b_sampah/src/blocs/memberBloc.dart';
import 'package:b_sampah/src/models/getSampahModel.dart';
import 'package:b_sampah/src/ui/utils/dialogAlert/sweetDialog.dart';
import 'package:b_sampah/src/ui/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class ListHargaPage extends StatefulWidget {
  ListHargaPage({this.idAnggota});
  String idAnggota;
  @override
  _ListHargaPageState createState() => _ListHargaPageState();
}

class _ListHargaPageState extends State<ListHargaPage> {

  bool _show = false;
  String idSampah;
  String hrg;
  int qty = 1;
  int totalHarga;

  File bukti;

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 50);
    setState(() {
      bukti = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 50);
    setState(() {
      bukti = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff740e13),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 9.0,
                            ),
                          ]),
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 12),
                      child: Center(
                          child: Text(
                            "Pilih Aksi",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.photo,
                                size: 60,
                                color: Colors.grey,
                              ),
                              Text("Gallery"),
                            ],
                          ),
                        ),
                        onTap: () {
                          _openGallery(context);
                        },
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      GestureDetector(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              ),
                              Text("Kamera"),
                            ],
                          ),
                        ),
                        onTap: () {
                          _openCamera(context);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    blocListSampah.getSampah();
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
      },
      child: Scaffold(
        body: NotificationListener<OverscrollIndicatorNotification>(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SafeArea(child: Container(height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
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
                  child: Center(child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                            child: Icon(Icons.arrow_back,color: Colors.white,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:12.0),
                        child: Text("List Sampah",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                      ),
                    ],
                  )),)),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 18),
                      child: StreamBuilder(
                        stream: blocListSampah.listHarga,
                        builder: (context, AsyncSnapshot<GetSampahModel> snapshot){
                          if(snapshot.hasData){
                            return SingleChildScrollView(child: buildList(snapshot));
                          }else{
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
             _show == true? Container(
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,
               color: Colors.black54,
             ):Container(),
             _show == true? Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14)
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Center(child: Text("Jumlah Sampah"),),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            qty != 1
                                ? InkWell(
                              onTap: () {
                                setState(() {
                                  qty = qty - 1;
                                  totalHarga = int.parse(hrg) * qty;
                                });
                              },
                              child: Icon(
                                Icons.indeterminate_check_box,
                                size: 50,
                                color: Colors.blue,
                              ),
                            )
                                : Icon(
                              Icons.indeterminate_check_box,
                              size: 50,
                              color: Colors.grey,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 12, right: 12),
                                child: Text(qty.toString())),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    qty = qty + 1;
                                    totalHarga = int.parse(hrg) * qty;
                                  });
                                },
                                child: Icon(
                                  Icons.add_box,
                                  size: 50,
                                  color: Colors.blue,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(child: Text("Total"),),
                      SizedBox(height: 8,),
                      Center(child: Text("Rp. $totalHarga",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),
                      SizedBox(height: 20,),
                      Text("Upload bukti sampah"),
                      Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 12, bottom: 8),
                              width: MediaQuery.of(context).size.width - 150,
                              height: 100,
                              decoration: BoxDecoration(
                                //shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: bukti == null
                                          ? AssetImage('assets/tfupload.jpg')
                                          : FileImage(bukti),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _showChoiceDialog(context);
                            },
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 60),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey.withOpacity(0.7),
                                  size: 50,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          if(bukti == null){
                            Toast.show("Bukti harus di upload!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
                          }else{
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
                            blocMember.setorSampah(widget.idAnggota, tgl, idSampah, qty.toString(), hrg, bukti);
                            blocMember.resGetSetor.listen((onData){
                              if(onData.message.success == true){
                                Dialogs.dismiss(context);
                                SweetAlert.show(context,
                                    title: "Success",
                                    subtitle: Center(
                                      child: Text(
                                        "Saldo Anda akan bertambah dan tunggu penjemputan sampah\n terimakasih",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey),textAlign: TextAlign.center,
                                      ),
                                    ),
                                    style:
                                    SweetAlertStyle.success,
                                    showCancelButton: false,
                                    onPress: (bool isConfirm) {
                                      if (isConfirm) {
                                        Navigator.pushReplacementNamed(context, '/home');
                                        return false;
                                      }
                                    });
                              }else{
                                Dialogs.dismiss(context);
                                SweetAlert.show(context,
                                    title: "Gagal",
                                    subtitle: Center(
                                      child: Text(
                                        "upload gagal",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey),textAlign: TextAlign.center,
                                      ),
                                    ),
                                    style:
                                    SweetAlertStyle.success,
                                    showCancelButton: true,);
                              }
                            });
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width/2 + 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(14)
                          ),
                          child: Center(child: Text("KIRIM",style: TextStyle(color: Colors.white),),),
                        ),
                      )
                    ],
                  ),
                ),
              ):Container()
            ],
          ),
        ),
      ),
    );
  }
  Widget buildList(AsyncSnapshot<GetSampahModel> snapshot){
    return Column(
      children: <Widget>[
        SizedBox(height: 2.0),
        GridView.count(
            physics: BouncingScrollPhysics(),
//          childAspectRatio: 300.0 / 350.0,
          crossAxisCount: 2,
          padding: EdgeInsets.only(top: 3),
          primary: false,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
          shrinkWrap: true,
          children: List.generate(snapshot.data.data.length, (i){
            return Container(
               child: _buildCard(snapshot.data.data[i].namaSampah, i, snapshot.data.data[i].image, snapshot.data.data[i].jenisSampah,
                     snapshot.data.data[i].hargaSetor,snapshot.data.data[i].idSampah)
            );
          })
        )
      ],
    );
  }
  Widget _buildCard(String sampah, int cardIndex, String images, String kategori, String harga,String idSmph) {
    return InkWell(
      onTap: (){
        setState(() {
          _show = true;
          idSampah = idSmph;
          hrg = harga;
          totalHarga = int.parse(harga);
        });
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 3.0,
          child: GestureDetector(
//          onTap: (){
//            Navigator.of(context).push(new MaterialPageRoute(
//                builder: (BuildContext context) =>
//                new ListPage(kategori: kategori,)));
//          },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //SizedBox(height: 2.0),
                  Center(
                    child: Container(
                      height: 110.0,
                      width: 190.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                          child: FadeInImage(
                              placeholder: AssetImage('assets/loading.gif'),
                              image: NetworkImage(images),
                              fit: BoxFit.cover)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                      color: Colors.blueGrey,
                      image: DecorationImage(image: NetworkImage(images), fit: BoxFit.cover),
                    ),
                    ),
                  ),
                SizedBox(height: 9.0),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          sampah,
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Container(
                        child: Text("Rp. "+
                          harga,
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.green
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 15.0)
      ),
    );
  }
}
