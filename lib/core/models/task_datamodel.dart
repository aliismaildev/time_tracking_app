class TaskDataModel {
  TaskDataModel({
    this.taskDescription,
    this.taskStatus,
    this.createdAt,
    this.updatedAt,
  });

  String? taskDescription;
  String? taskStatus;
  int? createdAt;
  int? updatedAt;

  TaskDataModel.fromJson(Map<String, dynamic> json) {
    taskDescription = json['task_description'] as String;
    taskStatus = json['task_status'] as String;
    createdAt = json['createdAt'] as int;
    updatedAt = json['updatedAt'] as int;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['task_description'] = taskDescription ?? "";
    data['task_status'] = taskStatus ?? "";
    data['createdAt'] = DateTime.now().millisecondsSinceEpoch;
    data['updatedAt'] = DateTime.now().millisecondsSinceEpoch;

    return data;
  }
}
