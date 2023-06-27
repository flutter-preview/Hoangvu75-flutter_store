import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../config/app_constants.dart';

class NetworkConfig {
  BehaviorSubject<bool?> isInternetAvailable = BehaviorSubject<bool?>.seeded(null);

  NetworkConfig(BuildContext context) {
    isInternetAvailable.listen(
      (value) {
        if (value != null && !value) {
          showAlertDialog(context);
        }
      },
    );
  }

  void handleNativeMethodCall(BuildContext context) {
    if (Platform.isAndroid) {
      NATIVE_ANDROID_CHANNEL.setMethodCallHandler(
        (call) {
          if (call.method == INTERNET_CONNECTION_METHOD) {
            return Future(
              () async {
                isInternetAvailable.add(call.arguments);
              },
            );
          } else {
            return Future(() => null);
          }
        },
      );
    } else if (Platform.isIOS) {
      NATIVE_IOS_CHANNEL.setMethodCallHandler(
        (call) {
          if (call.method == INTERNET_CONNECTION_METHOD) {
            return Future(
              () async {
                isInternetAvailable.add(call.arguments);
              },
            );
          } else {
            return Future(() => null);
          }
        },
      );
    }
  }

  static bool isDialogShowed = false;
  void showAlertDialog(BuildContext context) {
    if (!isDialogShowed) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Network error'),
            content: const Text(
              "Cannot access to the internet. Please try again.",
              style: TextStyle(
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
                onPressed: () {
                  isDialogShowed = false;
                  Navigator.of(context).pop();
                  if (isInternetAvailable.value == false) {
                    showAlertDialog(context);
                  }
                },
              ),
            ],
          );
        },
      );
    }
    isDialogShowed = true;
  }
}
