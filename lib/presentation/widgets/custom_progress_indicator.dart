import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({Key? key, this.strokeWidth = 4}) : super(key: key);

  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
