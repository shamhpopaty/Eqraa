import 'dart:convert';

class BookModel2{
  final String id;         // معرّف الكتاب (يمكن أن يكون رقمي أو نصي)
  final String title;      // عنوان الكتاب
  final String? author;   // مؤلف الكتاب (يمكن أن يكون null إذا لم يتوفر)
  final String? cover;    // رابط صورة غلاف الكتاب (يمكن أن يكون null إذا لم يتوفر)
  final String? description; // وصف الكتاب (يمكن أن يكون null إذا لم يتوفر)

  BookModel2({
    required this.id,
    required this.title,
    this.author,
    this.cover,
    this.description,
  });

  // لتحويل الكائن إلى خريطة (Map) لتخزينه في قاعدة البيانات أو إرسال بيانات JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'cover': cover,
      'description': description,
    };
  }

  // لتحويل خريطة (Map) إلى كائن BookModel
  factory BookModel2.fromMap(Map<String, dynamic> map) {
    return BookModel2(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      author: map['author'],
      cover: map['cover'],
      description: map['description'],
    );
  }

  // لتحويل الكائن إلى JSON (لسهولة النقل عبر الشبكة)
  String toJson() => json.encode(toMap());

  // لتحويل JSON إلى كائن BookModel
  factory BookModel2.fromJson(String source) => BookModel2.fromMap(json.decode(source));
}
