import 'package:new_resik/src/pref/preference.dart';
import 'package:new_resik/src/ui/ubahPinPage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade200))),
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
                    onPressed: () {},
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
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade200))),
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
                    onPressed: () {},
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
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade200))),
              child: InkWell(
                onTap: () {
                  final RenderObject? box = context.findRenderObject();
                  Share.share(
                    'Download aplikasi Resik disini https://play.google.com/store/apps/details?id=com.jongjava.new_resik',
                    // sharePositionOrigin:
                    //     box.localToGlobal(Offset.zero) & box.size,
                  );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.share,
                    size: 20,
                    color: Colors.blue,
                  ),
                  title: Text("Bagikan"),
                  trailing: IconButton(
                    onPressed: () {},
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
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade200))),
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
                        onPressed: () {},
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
              "versi 1.0.5",
              style: TextStyle(color: Colors.grey),
            ))
          ],
        ),
      ),
    );
  }

  _confirmExit() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Konfirmasi",
      desc: "Apakah Anda yakin akan keluar?",
      buttons: [
        DialogButton(
          child: Text(
            "YA",
            style: TextStyle(color: Colors.green, fontSize: 20),
          ),
          onPressed: () {
            rmvToken();
            rmvNama();
            rmvIdDesa();
            rmvId();
            Navigator.of(context).pop();
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (Route<dynamic> route) => false);
          },
          width: 120,
        ),
        DialogButton(
          child: Text(
            "Tidak",
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}
