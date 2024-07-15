import 'package:flutter/material.dart';

class IndividualResultUi extends StatelessWidget {
  final Map result;
  const IndividualResultUi({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(result.toString()),
      ),
    );
  }
}
