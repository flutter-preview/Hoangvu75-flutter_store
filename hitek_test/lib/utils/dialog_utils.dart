import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hitek_test/common/theme/app_color.dart';
import 'package:hitek_test/data/models/product.dart';
import 'package:hitek_test/utils/formatter.dart';
import 'package:hitek_test/widgets/animated_circular_indicator.dart';
import 'package:rxdart/rxdart.dart';

import '../common/config/app_constants.dart';
import '../modules/cart/cart_controller.dart';
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

  static void showOptionalDialog(
      {required String title, required String content, required Function onConfirm}) {
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

  static void showOrderDialog({
    required String title,
    required String content,
    required Product product,
  }) {
    BehaviorSubject<int> amount = BehaviorSubject<int>.seeded(1);

    showDialog<void>(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        onDialogContextComplete(context);
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      int currentAmount = amount.value;
                      if (amount.value > 1) {
                        amount.add(currentAmount - 1);
                      }
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      size: 20,
                      color: AppColor.BUTTON_BLUE,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  StreamBuilder<int>(
                    stream: amount.stream,
                    builder: (context, snapshot) {
                      return Text(
                        "Số lượng: ${amount.value}",
                        style: const TextStyle(fontSize: 16),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      int currentAmount = amount.value;
                      amount.add(currentAmount + 1);
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                      size: 20,
                      color: AppColor.BUTTON_BLUE,
                    ),
                  ),
                ],
              )
            ],
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
                product.amountInCart = amount.value;
                CartController.addProduct(product);
                SnackBar snackBar = SnackBar(
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  content: const Text('Thêm hàng thành công, hãy kiểm tra giỏ hàng.'),
                  action: SnackBarAction(
                    label: 'Hoàn tác',
                    onPressed: () {
                      CartController.removeProduct(product);
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                await closeDialog();
              },
            ),
          ],
        );
      },
    );
  }

  static void showConfirmOrderDialog({
    required Product product,
    required int amount,
  }) {
    showDialog<void>(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        onDialogContextComplete(context);
        return AlertDialog(
          title: const Text("Xác nhận đơn hàng."),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Bạn có muốn đặt sản phẩm ",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    TextSpan(
                      text: "${product.title} ",
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: AppColor.DEFAULT_BLUE,
                      ),
                    ),
                    TextSpan(
                      text: "(SL: ${product.amountInCart})",
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: AppColor.DEFAULT_RED,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Tổng giá: ",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    TextSpan(
                      text: Formatter.formatNumber(
                        "${(product.amountInCart! * product.price!)} đ",
                      ),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: AppColor.DEFAULT_RED,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                CartController.addProduct(product);
                SnackBar snackBar = const SnackBar(
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  content: Text('Thêm hàng thành công, hãy kiểm tra giỏ hàng.'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    if (!_dialogContextCompleter!.isCompleted) {
      _dialogContextCompleter!.complete(context);
    }
  }

  static Future<void> closeDialog() async {
    Navigator.pop(await _dialogContextCompleter!.future);
    _dialogContextCompleter = null;
  }
}
