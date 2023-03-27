import 'package:agriapp/presentation/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(bottom: 50.0),
        child: CustomProgressIndicator(),
      ),
    );
  }
}
