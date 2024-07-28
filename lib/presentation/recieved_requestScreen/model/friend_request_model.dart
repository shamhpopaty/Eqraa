class FriendRequest {
  final int? id;
  final int? userId;
  final int? friendId;
  final int? accepted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FriendRequest({
    this.id,
    this.userId,
    this.friendId,
    this.accepted,
    this.createdAt,
    this.updatedAt,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      id: json['id'],
      userId: json['user_id'],
      friendId: json['friend_id'],
      accepted: json['accepted'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }
}

class User {
  final int? id;
  final String? name;

  User({this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }
}
