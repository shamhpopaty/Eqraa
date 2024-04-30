class UserModel {
  String? usersId;
  String? usersEmail;
  String? usersName;
  String? usersUpdated;
  String? usersCreate;

  UserModel(
      {this.usersId,
      this.usersEmail,
      this.usersName,
      this.usersUpdated,
      this.usersCreate});

  UserModel.fromJson(Map<String, dynamic> json) {
    usersId = json['id'];
    usersEmail = json['email'];
    usersName = json['name'];
    usersUpdated = json['updated_at'];
    usersCreate = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = usersId;
    data['email'] = usersEmail;
    data['name'] = usersName;
    data['created_at'] = usersCreate;
    data['updated_at'] = usersUpdated;
    return data;
  }
}
