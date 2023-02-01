import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:result_type/result_type.dart';
import 'package:time_tracking_app/core/models/profile_datamodel.dart';
import 'package:time_tracking_app/utils/firebase_global_instances.dart';

class ProfileService {
  ///Add new or Update profile if exists
  Future<Result<void, Object>> setProfile({
    required String userID,
    required ProfileDataModel profileDataModel,
  }) async {
    try {
      final ref = fireBaseDB.ref("users/$userID");
      await ref.set(profileDataModel.toJson());
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
