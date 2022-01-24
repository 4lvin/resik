import 'package:flutter/material.dart';
class DetailNotif extends StatefulWidget {
  DetailNotif({this.content,this.index,this.tgl});

  int index;
  String content;
  String tgl;
  @override
  _DetailNotifState createState() => _DetailNotifState();
}

class _DetailNotifState extends State<DetailNotif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Detail Informasi"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                      elevation: 4.0,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(
                                  top: 50, left: 12, right: 12, bottom: 12),
                              width: MediaQuery.of(context).size.width - 30,
                              child: Text(widget.content,style: TextStyle(height: 1.5,wordSpacing: 1.5),)),
                          Container(margin: EdgeInsets.only(left: 12,bottom: 14),
                              child: Text(widget.tgl,style: TextStyle(color: Colors.grey),))
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      width: 70.0,
                      height: 70.0,
                      child: Hero(
                          tag: "notif${widget.index}", child: Image.asset("assets/notif.png")),
//                      decoration: BoxDecoration(
//                          border: Border.all(color: Colors.white, width: 1),
//                          shape: BoxShape.circle,
//                          image: DecorationImage(
//                              image: ExactAssetImage('assets/notif.png'),
//                              fit: BoxFit.cover)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
