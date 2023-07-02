import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hitek_test/common/theme/app_color.dart';
import 'package:hitek_test/widgets/animated_circular_indicator.dart';

import '../common/config/app_constants.dart';
import '../widgets/type_writer_text.dart';

class DialogUtils {
  static Completer<BuildContext>? _dialogContextCompleter;

  static void showNotificationDialog({required String title, required String content}) {
    showDialog<void>(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        onDialogContextComplete(context);
        return AlertDialog(
          title: Text(title),
          content: Text(
            content,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              onPressed: () async {
                await closeDialog();
              },
            ),
          ],
        );
      },
    );
  }

  static void showLoadingDialog() {
    AlertDialog alert = const AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 25),
          AnimatedColorCircularIndicator(
            beginColor: AppColor.DEFAULT_BLUE,
            endColor: AppColor.DEFAULT_RED,
            width: 50,
            height: 50,
            animationDuration: Duration(milliseconds: 1500),
          ),
          SizedBox(height: 25),
          TypeWriterText(
            listOfText: ["Loading..."],
          ),
          SizedBox(height: 5),
          Text(
            "Please wait few seconds",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );

    showDialog<void>(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        onDialogContextComplete(context);
        return alert;
      },
    );
  }

  static void showOptionalDialog({required String title, required String content, required Function onConfirm}) {
    showDialog<void>(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        onDialogContextComplete(context);
        return AlertDialog(
          title: Text(title),
          content: Text(
            content,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              onPressed: () async {
                await closeDialog();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              onPressed: () async {
                onConfirm();
                await closeDialog();
              },
            ),
          ],
        );
      },
    );
  }

  static void onDialogContextComplete(BuildContext context) {
    _dialogContextCompleter = Completer<BuildContext>();
    if(!_dialogContextCompleter!.isCompleted) {
      _dialogContextCompleter!.complete(context);
    }
  }

  static Future<void> closeDialog() async {
    Navigator.pop(await _dialogContextCompleter!.future);
    _dialogContextCompleter = null;
  }
}
