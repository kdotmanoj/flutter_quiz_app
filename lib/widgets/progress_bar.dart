import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double value;

  ProgressBar({required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: Colors.grey[300],
        color: Colors.blue,
        minHeight: 8,
      ),
    );
  }
}
