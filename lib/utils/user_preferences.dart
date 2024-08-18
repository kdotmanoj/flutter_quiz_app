import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _scoreKey = 'score';

  static Future<int> getScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_scoreKey) ?? 0; // Return 0 if no score is stored
  }

  static Future<void> setScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_scoreKey, score);
  }
}
