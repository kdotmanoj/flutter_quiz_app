import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8080'; // Adjust as needed

  static Future<List<Question>> getQuestions(String difficulty) async {
    final url = '$baseUrl/questions?difficulty=$difficulty';
    print('Making request to: $url'); // Debug print

    final response = await http.get(Uri.parse(url));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); // Debug print

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((q) => Question.fromJson(q)).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }

  static Future<void> submitAnswers(String difficulty, List<String> answers) async {
    final response = await http.post(
      Uri.parse('$baseUrl/submit'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'difficulty': difficulty, 'answers': answers}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit answers');
    }
  }
}
