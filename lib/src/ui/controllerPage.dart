import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_resik/src/ui/account_page.dart';
import 'package:new_resik/src/ui/cekHargaList_page.dart';
import 'package:new_resik/src/ui/home_page.dart';
import 'package:new_resik/src/ui/utils/colors.dart';
import 'package:flutter/material.dart';
// import 'package:toast/toast.dart';

class ControllerPage extends StatefulWidget {
  ControllerPage({this.selected});

  int? selected;

  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  PageController _myPage = PageController(initialPage: 0);
  Color colorHome = Colors.blue;
  Color colorProfil = Colors.black54;
  DateTime? currentBackPressTime;

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Tekan sekali lagi untuk keluar",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
          child: PageView(
            controller: _myPage,
            onPageChanged: (int) {
              if (int == 0) {
                setState(() {
                  colorHome = Colors.blue;
                  colorProfil = Colors.black54;
                });
              } else if (int == 1) {
                setState(() {
                  colorProfil = Colors.blue;
                  colorHome = Colors.black54;
                });
              }
            },
            children: <Widget>[HomePage(), AkunPage()],
            physics:
                NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 64,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    _myPage.jumpToPage(0);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        color: colorHome,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(color: colorHome),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _myPage.jumpToPage(1);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: colorProfil,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(color: colorProfil),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 65.0,
        width: 65.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 2.0,
                spreadRadius: 1.0,
              )
            ],
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: colorses.gradient)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(80),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new ListHargaPage()));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                Text(
                  "Jual",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
