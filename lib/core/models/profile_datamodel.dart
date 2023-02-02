class ProfileDataModel {
  ProfileDataModel({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.age,
    this.createdAt,
    this.updatedAt,
  });

  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  int? age;
  int? createdAt;
  int? updatedAt;

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] as String;
    email = json['email'] as String;
    firstName = json['first_name'] as String;
    lastName = json['last_name'] as String;
    age = json['age'] as int;
    createdAt = json['createdAt'] as int;
    updatedAt = json['updatedAt'] as int;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid ?? "";
    data['first_name'] = firstName ?? "";
    data['last_name'] = lastName ?? "";
    data['email'] = email ?? "";
    data['age'] = age ?? 0;
    data['createdAt'] = DateTime.now().millisecondsSinceEpoch;
    data['updatedAt'] = DateTime.now().millisecondsSinceEpoch;

    return data;
  }
}
