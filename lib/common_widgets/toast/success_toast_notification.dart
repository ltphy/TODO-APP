import 'package:flutter/material.dart';

import 'toast.dart';

class SuccessToastNotification extends Toast {
  final String message;

  SuccessToastNotification({required this.message, Key? key})
      : super(
          key: key,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check,
                color: Colors.white,
              ),
              const SizedBox(
                width: 12.0,
              ),
              Text(
                message,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
          color: Colors.green,
        );
}
