import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class Dialogs {
  static ProgressDialog? pr;
  static Future showLoading(BuildContext context) async {
    pr = ProgressDialog(context: context);
    // pr = ProgressDialog(context: context,
    //     type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    pr!.show(
      max: 100,
      msg: 'Tunggu Sebentar...',
      borderRadius: 10.0,
      backgroundColor: Colors.black45,
      elevation: 10.0,

      // progressWidget: Lottie.asset(
      //   'assets/loading.json',
      //   width: 200,
      //   height: 200,
      //   fit: BoxFit.fill,
      // ),
    );
  }

  static Future dismiss(BuildContext context) async {
    pr = ProgressDialog(context: context);
    pr!.close();
    // pr = new ProgressDialog(context,
    //     type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    // return pr!.hide().whenComplete(() {
    //   print("hide success");
    // });
  }
}
