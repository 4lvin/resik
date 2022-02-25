import 'package:new_resik/src/blocs/listSampahBloc.dart';
import 'package:new_resik/src/models/getHistoryModel.dart';
import 'package:new_resik/src/pref/preference.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CekTransaksi extends StatefulWidget {
  @override
  _CekTransaksiState createState() => _CekTransaksiState();
}

class _CekTransaksiState extends State<CekTransaksi> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    getId().then((value) {
      blocListSampah.getHistory(value);
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    getId().then((value) {
      blocListSampah.getHistory(value);
    });
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    getId().then((value) {
      blocListSampah.getHistory(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.blueGrey),
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
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "History Transaksi",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: blocListSampah.listHistory,
              builder: (context, AsyncSnapshot<GetHistoryModel> snapshot) {
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
        ],
      ),
    );
  }

  Widget buildList(AsyncSnapshot<GetHistoryModel> snapshot) {
    return snapshot.data!.data!.isNotEmpty
        ? SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropMaterialHeader(),
            // footer: CustomFooter(
            //   builder: (BuildContext context, LoadStatus mode) {
            //     Widget body;
            //     if (mode == LoadStatus.loading) {
            //       body = CupertinoActivityIndicator();
            //     } else if (mode == LoadStatus.failed) {
            //       body = Text("Load Failed!Click retry!");
            //     } else if (mode == LoadStatus.canLoading) {
            //       body = Text("release to load more");
            //     } else {
            //       body = Text("No more Data");
            //     }
            //     return Container(
            //       height: 55.0,
            //       child: Center(child: body),
            //     );
            //   },
            // ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
                padding: EdgeInsets.only(top: 5),
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (BuildContext context, int i) {
                  var tgl = DateFormat('dd/MM/yyyy')
                      .format(snapshot.data!.data![i].tanggal!);
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: snapshot.data!.data![i].kode == "SP"
                                      ? Color(0xff740e13).withOpacity(0.9)
                                      : snapshot.data!.data![i].kode == "PS"
                                          ? Colors.amber.withOpacity(0.9)
                                          : Color(0xff66c75b).withOpacity(0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text("${snapshot.data!.data![i].kode}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                ),
                              ),
                              title: Text(
                                snapshot.data!.data![i].keterangan!,
                                style: TextStyle(fontSize: 16),
                              ),
                              subtitle: Text("${tgl}"),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 7, right: 7, top: 2),
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: snapshot.data!.data![i].status ==
                                                "Belum Diambil"
                                            ? Colors.red[400]
                                            : snapshot.data!.data![i].status ==
                                                    "Sudah Diambil"
                                                ? Colors.green[400]
                                                : snapshot.data!.data![i]
                                                            .status ==
                                                        "Proses"
                                                    ? Colors.red[400]
                                                    : snapshot.data!.data![i]
                                                                .status ==
                                                            "Pending"
                                                        ? Colors.yellow[400]
                                                        : Colors.green[400],
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(3.0, 3.0))
                                        ]),
                                    child: Text(
                                      "${snapshot.data!.data![i].status}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text(
                                                "${snapshot.data!.data![i].tipe}"),
                                          ),
                                          Text(
                                              "Rp. ${snapshot.data!.data![i].harga}"),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            snapshot.data!.data![i].kode == "SP"
                                ? Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {
                                        Alert(
                                            context: context,
                                            title: "Scan me!",
                                            content: Column(
                                              children: <Widget>[
                                                QrImage(
                                                  data: snapshot
                                                      .data!.data![i].id!,
                                                  version: QrVersions.auto,
                                                  size: 200.0,
                                                ),
                                              ],
                                            ),
                                            buttons: [
                                              DialogButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text(
                                                  "Ok",
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              )
                                            ]).show();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 12),
                                        child: Icon(
                                          Icons.fullscreen,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          )
        : Container(
            child: Center(
              child: Lottie.asset(
                'assets/nodata!.json',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
