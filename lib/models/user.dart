class User {
  final int totalPoints;
  final Map<String, bool> unlockedLevels;

  User({required this.totalPoints, required this.unlockedLevels});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      totalPoints: json['totalPoints'],
      unlockedLevels: Map<String, bool>.from(json['unlockedLevels']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPoints': totalPoints,
      'unlockedLevels': unlockedLevels,
    };
  }
}
