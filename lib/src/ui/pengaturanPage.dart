import 'package:b_sampah/src/pref/preference.dart';
import 'package:b_sampah/src/ui/ubahPinPage.dart';
import 'package:b_sampah/src/ui/utils/dialogAlert/sweetDialog.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share/share.dart';

class PengaturanPage extends StatefulWidget {
  @override
  _PengaturanPageState createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Pengaturan"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color:
                          Colors.grey[200]))),
              margin: EdgeInsets.only(top: 12),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 400),
                          child: UbahPinPage()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.vpn_key,
                    size: 20,
                    color: Colors.blue,
                  ),
                  title: Text("Ganti pin"),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color:
                          Colors.grey[200]))),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     SlideLeftRoute(
                  //         page:
                  //         CallCenterPage()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.contacts,
                    size: 20,
                    color: Colors.blue,
                  ),
                  title: Text("Kontak"),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color:
                          Colors.grey[200]))),
              child: InkWell(
                onTap: () {
                  final RenderBox box =
                  context.findRenderObject();
                  Share.share(
                      'Download aplikasi Resik disini https://bit.ly/bsampah',
                      sharePositionOrigin:
                      box.localToGlobal(
                          Offset.zero) &
                      box.size);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.share,
                    size: 20,
                    color: Colors.blue,
                  ),
                  title: Text("Bagikan"),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color:
                          Colors.grey[200]))),
              child: InkWell(
                onTap: () {
                  _confirmExit();
                },
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(child: Text("Keluar")),
                      IconButton(
                        icon: Icon(
                          Icons.exit_to_app,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
                  "versi 1.0.1",
                  style:
                  TextStyle(color: Colors.grey),
                ))
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
            rmvToken();
            rmvNama();
            rmvIdDesa();
            rmvId();
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/login');
            return false;
          }
        });
  }
}
