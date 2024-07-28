class User {
  final int? id;
  final String? name;
  final int? numberOfFriends;
  final String? bio;
  final String? socialLinks;
  final String? avatar;
  final int? isAdmin;
  final String? email;
  final DateTime? emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.numberOfFriends,
    this.bio,
    this.socialLinks,
    this.avatar,
    this.isAdmin,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? '',
      numberOfFriends: json['number_of_friends'] ?? 0,
      bio: json['bio'] ?? '',
      socialLinks: json['social_links'] ?? '',
      avatar: json['avatar'] ?? '',
      isAdmin: json['is_admin'] ?? 0,
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'] != null ? DateTime.parse(json['email_verified_at']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }
}
