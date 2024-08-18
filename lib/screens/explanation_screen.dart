import 'package:flutter/material.dart';

class ExplanationScreen extends StatelessWidget {
  final String explanation;

  ExplanationScreen({required this.explanation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explanation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Explanation:', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 16.0),
            Text(explanation),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
