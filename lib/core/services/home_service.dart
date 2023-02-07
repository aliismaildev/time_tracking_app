import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:result_type/result_type.dart';
import 'package:time_tracking_app/core/models/task_datamodel.dart';
import 'package:time_tracking_app/utils/firebase_global_instances.dart';

class HomeService {
  //Add Task

  Future<Result<void, Object>> addTask({
    required String userID,
    required TaskDataModel taskDataModel,
  }) async {
    try {
      final ref = fireBaseDB.ref("tasks/$userID/${taskDataModel.taskId}");
      await ref.set(taskDataModel.toJson());
      return Success(null);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());

      return Failure(e.message.toString());
    } catch (e) {
      debugPrint(e.toString());

      return Failure(e.toString());
    }
  }
}
