import 'package:flutter/material.dart';

import 'toast.dart';

class FailToastNotification extends Toast {
  final String message;

  FailToastNotification({required this.message, Key? key})
      : super(
          key: key,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.close,
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
          color: Colors.redAccent,
        );
}
