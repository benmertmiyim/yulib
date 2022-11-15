import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              "Yulib",
              style:
              TextStyle(fontWeight: FontWeight.bold,fontSize: 32),
            ),
            SizedBox(
              height: 16,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
