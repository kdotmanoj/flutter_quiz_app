import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final Function(String) onOptionSelected;

  QuestionWidget({required this.question, required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.text,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          for (String option in question.options)
            ListTile(
              title: Text(option),
              leading: Radio<String>(
                value: option,
                groupValue: null,  // manage state outside for selected value
                onChanged: (value) {
                  onOptionSelected(option);
                },
              ),
            ),
        ],
      ),
    );
  }
}
