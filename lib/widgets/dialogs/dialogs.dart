import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/utils/language_constant.dart';

class Dialogs {
  static final Dialogs _singleton = Dialogs._internal();

  factory Dialogs() {
    return _singleton;
  }

  Dialogs._internal();

  static Widget quizStartDialog({required VoidCallback onTap}) {
    return AlertDialog(
      // title: const Text("Hi.."),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LANG_CONST.HI.toString().tr,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(LANG_CONST.PLEASE_LOGIN_BEFORE_START.toString().tr),
        ],
      ),
      actions: <Widget>[
        TextButton(onPressed: onTap, child: Text(LANG_CONST.OKAY.toString().tr))
      ],
    );
  }

  static Widget quizTimeUpDialog({required VoidCallback onTap}) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LANG_CONST.SORRY.toString().tr,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(LANG_CONST.TIMES_UP_PLEASE_TRY_AGAIN.toString().tr),
          ],
        ),
        actions: <Widget>[
          TextButton(onPressed: onTap, child: const Text('Okay'))
        ],
      ),
    );
  }

  static Future<bool> quizEndDialog() async {
    return (await showDialog(
          context: Get.overlayContext!,
          builder: (context) => AlertDialog(
            title: Text(LANG_CONST.ARE_YOU_SURE.toString().tr),
            content: Text(LANG_CONST.DO_YOU_WANT_TO_EXIT.toString().tr),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.back(result: false),
                child: Text(LANG_CONST.NO.toString().tr),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child:  Text(LANG_CONST.YES.toString().tr),
              ),
            ],
          ),
        )) ??
        false;
  }
}
