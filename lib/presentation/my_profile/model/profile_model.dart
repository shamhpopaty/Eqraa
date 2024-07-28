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

class UserBooks {
  final int? id;
  final String? title;
  final String? category;
  final String? author;
  final String? description;
  final int? rating;
  final String? cover;
  final String? path;
  final int? numberOfPages;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserBooks({
    this.id,
    this.title,
    this.category,
    this.author,
    this.description,
    this.rating,
    this.cover,
    this.path,
    this.numberOfPages,
    this.createdAt,
    this.updatedAt,
  });

  factory UserBooks.fromJson(Map<String, dynamic> json) {
    return UserBooks(
      id: json['id'],
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      rating: json['rating'] ?? 0,
      cover: json['cover'] ?? '',
      path: json['path'] ?? '',
      numberOfPages: json['number_of_pages'] ?? 0,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }
}

class UserProfileResponse {
  final User? user;
  final List<UserBooks>? userBooks;

  UserProfileResponse({
    this.user,
    this.userBooks,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      userBooks: json['user_books'] != null
          ? (json['user_books'] as List)
          .map((i) => UserBooks.fromJson(i))
          .toList()
          : [],
    );
  }
}
