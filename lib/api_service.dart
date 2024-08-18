import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/question.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:35971';

  static Future<Question> fetchQuestion() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/question'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Question.fromJson(data);
      } else {
        throw Exception('Failed to load question. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching question: $e');
    }
  }

  static Future<int> fetchTotalQuestions() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/total-questions'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('total')) {
          return data['total'];
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load total questions. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching total questions: $e');
    }
  }

  static Future<Map<String, dynamic>> submitAnswer(String answer) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/submit'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'answer': answer,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to submit answer. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error submitting answer: $e');
    }
  }
}
