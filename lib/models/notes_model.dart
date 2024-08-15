class Notes_Model {
  int? id;
  String? name;
  int? pageNumber;
  String? note;
  int? bookId;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Notes_Model(
      {this.id,
        this.name,
        this.pageNumber,
        this.note,
        this.bookId,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Notes_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pageNumber = json['page_number'];
    note = json['note'];
    bookId = json['book_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['page_number'] = this.pageNumber;
    data['note'] = this.note;
    data['book_id'] = this.bookId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
