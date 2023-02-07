class TaskDataModel {
  TaskDataModel({
    this.taskId,
    this.taskDescription,
    this.taskStatus,
    this.createdAt,
    this.updatedAt,
  });

  String? taskId;
  String? taskDescription;
  String? taskStatus;
  int? createdAt;
  int? updatedAt;

  TaskDataModel.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'] as String;
    taskDescription = json['task_description'] as String;
    taskStatus = json['task_status'] as String;
    createdAt = json['createdAt'] as int;
    updatedAt = json['updatedAt'] as int;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['task_id'] = taskId ?? "";
    data['task_description'] = taskDescription ?? "";
    data['task_status'] = taskStatus ?? "";
    data['createdAt'] = DateTime.now().millisecondsSinceEpoch;
    data['updatedAt'] = DateTime.now().millisecondsSinceEpoch;

    return data;
  }
}
