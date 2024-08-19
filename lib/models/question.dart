import 'package:flutter/material.dart';

class Question {
  final String text;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  final String? imageUrl; // Optional image URL

  Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    this.imageUrl,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['question'] ?? 'No question available',
      options: List<String>.from(json['options'] ?? []),
      correctAnswer: json['answer'] ?? 'No correct answer',
      explanation: json['explanation'] ?? 'No explanation available',
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': text,
      'options': options,
      'answer': correctAnswer,
      'explanation': explanation,
    };
  }
}
