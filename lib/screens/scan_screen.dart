import 'package:flutter/material.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          '스캔 화면',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
