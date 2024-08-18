import 'package:flutter/material.dart';

class AnswerFeedback extends StatelessWidget {
  final String message;
  final Function onNext;

  AnswerFeedback({required this.message, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message, style: TextStyle(fontSize: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // show explanation
                },
                child: Text('Explanation'),
              ),
              ElevatedButton(
                onPressed: () => onNext(),
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
