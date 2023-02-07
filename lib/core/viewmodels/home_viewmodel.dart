import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:result_type/result_type.dart';
import 'package:time_tracking_app/core/models/task_datamodel.dart';
import 'package:time_tracking_app/core/services/home_service.dart';
import 'package:time_tracking_app/core/viewmodels/base_viewmodel.dart';
import 'package:time_tracking_app/utils/firebase_global_instances.dart';

class HomeViewModel extends BaseViewModel {
  final HomeService _homeService = HomeService();
  final TaskDataModel _taskDataModel = TaskDataModel();

  User? get currentUser => fireBaseAuth.currentUser;

  final TextEditingController addTaskController = TextEditingController();

  Future<Result> addTask() async {
    _taskDataModel.taskDescription = addTaskController.text;
    Result res = await _homeService.addTask(userID: currentUser!.uid, taskDataModel: _taskDataModel);
    return res;
  }
}
