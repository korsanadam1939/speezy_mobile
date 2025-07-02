class User {
  final String? id;
  final String? username;
  final String? email;
  String? profilePictureUrl;
  final String? level;
  final String? rank;
  final int? totalXp;
  final int? gems;
  final int? streakCount;
  final String? lastActiveDate;
  final bool? isPremium;
  final String? accountStatus;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.level,
    required this.rank,
    this.profilePictureUrl ,
    required this.totalXp,
    required this.gems,
    required this.streakCount,
    required this.lastActiveDate,
    required this.isPremium,
    required this.accountStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      level: json['level'] ?? 'Unknown',
      rank: json['rank'] ?? 'Unknown',
      profilePictureUrl: json['profilePictureUrl'],
      totalXp: json['totalXp'] ?? 0,
      gems: json['gems'] ?? 0,
      streakCount: json['streakCount'] ?? 0,
      lastActiveDate: json['lastActiveDate'] ?? '',
      isPremium: json['isPremium'] ?? false,
      accountStatus: json['accountStatus'] ?? 'Unknown',
    );
  }
}
