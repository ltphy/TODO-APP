
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/common_widgets/toast/fail_toast_notification.dart';
import 'package:todo/common_widgets/toast/success_toast_notification.dart';

class NotificationService {
  static final NotificationService instance = NotificationService._();
  final FToast _fToast = FToast();

  NotificationService._();

  initContext(BuildContext context) {
    _fToast.init(context);
  }

  void showFail(String message) {
    _fToast.showToast(
      child: FailToastNotification(
        message: message,
      ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );
  }

  void showSuccess(String message) {
    _fToast.showToast(
      child: SuccessToastNotification(
        message: message,
      ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );
  }
}