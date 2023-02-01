class ProfileDataModel {
  ProfileDataModel({
    this.uid,
    this.name,
    this.email,
    this.age,
    this.createdAt,
    this.updatedAt,
  });

  String? uid;
  String? name;
  String? email;
  int? age;
  int? createdAt;
  int? updatedAt;

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] as String;
    email = json['email'] as String;
    name = json['name'] as String;
    age = json['age'] as int;
    createdAt = json['createdAt'] as int;
    updatedAt = json['updatedAt'] as int;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid ?? "";
    data['name'] = name ?? "";
    data['email'] = email ?? "";
    data['age'] = age ?? 0;
    data['createdAt'] = DateTime.now().millisecondsSinceEpoch;
    data['updatedAt'] = DateTime.now().millisecondsSinceEpoch;

    return data;
  }
}
