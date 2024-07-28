class Book {
  int? id;
  String? title;
  String? category;
  String? author;
  String? description;
  int? rating;
  String? cover;
  String? path;
  int? numberOfPages;
  DateTime? createdAt;
  DateTime? updatedAt;

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
      rating: json['rating'],
      cover: json['cover'],
      path: json['path'],
      numberOfPages: json['number_of_pages'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
