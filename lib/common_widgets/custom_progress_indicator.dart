import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color? valueColor;
  final Color? color;

  const CustomProgressIndicator({Key? key, this.valueColor, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assignValueColor = valueColor;
    return CircularProgressIndicator(
      color: color,
      valueColor: assignValueColor != null
          ? AlwaysStoppedAnimation<Color>(assignValueColor)
          : null,
    );
  }
}
