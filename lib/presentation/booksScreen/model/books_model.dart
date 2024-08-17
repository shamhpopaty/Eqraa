class Book {
  int? id;
  String? title;
  String? category;
  String? author;
  String? description;
  double? rating;
  String? cover;
  String? path;
  int? numberOfPages;
  String? createdAt;
  String? updatedAt;

  Book({
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

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      author: json['author'],
      description: json['description'],
      // Safely cast rating to double even if it's provided as an integer
      rating: json['rating'] is int ? (json['rating'] as int).toDouble() : json['rating'],
      cover: json['cover'],
      path: json['path'],
      numberOfPages: json['number_of_pages'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
