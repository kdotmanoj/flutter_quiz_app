import 'package:flutter/material.dart';

class QuizOption extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onTap;

  const QuizOption({super.key, 
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(option),
      tileColor: isSelected ? Colors.blueAccent : null,
      onTap: onTap,
    );
  }
}
