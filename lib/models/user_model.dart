class UserModel {
  String? usersId;
  String? usersEmail;
  String? usersName;
  String? isAdmin;
  String? usersUpdated;
  String? usersCreate;
  String? verifiedAt;


  UserModel(
      {this.usersId,
      this.usersEmail,
      this.usersName,
      this.usersUpdated,
      this.isAdmin,
      this.verifiedAt,
      this.usersCreate,});

  UserModel.fromJson(Map<String, dynamic> json) {
    usersId = json['id'].toString();
    usersEmail = json['email'];
    usersName = json['name'];
    isAdmin = json['is_admin'];
    usersUpdated = json['updated_at'];
    usersCreate = json['created_at'];
    verifiedAt = json['email_verified_at'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = usersId;
    data['email'] = usersEmail;
    data['name'] = usersName;
    data['is_admin'] = isAdmin;
    data['created_at'] = usersCreate;
    data['updated_at'] = usersUpdated;
    data['email_verified_at'] = verifiedAt;


    return data;
  }

}
