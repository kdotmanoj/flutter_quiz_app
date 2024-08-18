import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  final String question;
  final List<String> options;
  final String? hint; // Make hint nullable

  Question({
    required this.question,
    required this.options,
    this.hint, // Initialize hint as nullable
  });

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
