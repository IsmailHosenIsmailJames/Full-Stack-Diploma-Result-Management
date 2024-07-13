import 'package:flutter/material.dart';

Widget getStepWidget(String steap) {
  return CircleAvatar(
    backgroundColor: Colors.blue.shade900,
    radius: 20,
    child: Text(
      steap,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
      ),
    ),
  );
}
