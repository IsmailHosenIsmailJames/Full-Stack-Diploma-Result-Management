import 'package:flutter/material.dart';

class IntituteResultUi extends StatelessWidget {
  final Map result;
  const IntituteResultUi({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(child: Text(result.toString())),
      ),
    );
  }
}
