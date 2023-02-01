import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:result_type/result_type.dart';
import 'package:time_tracking_app/consts/enums.dart';
import 'package:time_tracking_app/core/models/profile_datamodel.dart';
import 'package:time_tracking_app/core/services/auth_service.dart';
import 'package:time_tracking_app/core/services/profile_service.dart';
import 'package:time_tracking_app/core/viewmodels/base_viewmodel.dart';

class AuthViewModel extends BaseViewModel {
  final AuthService _authService = AuthService();
  final ProfileService _profileService = ProfileService();
  final ProfileDataModel _profileDataModel = ProfileDataModel();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      ageController = TextEditingController(),
      passwordController = TextEditingController();

  Future<Result<UserCredential, Object>> register() async {
    viewState = ViewState.busy;
    final res = await _authService.register(email: emailController.text, password: passwordController.text);
    viewState = ViewState.idle;
    return res;
  }

  Future<void> createBaseProfile() async {
    viewState = ViewState.busy;

    _profileDataModel.uid = _authService.currentUser?.uid;
    _profileDataModel.email = _authService.currentUser?.email;
    _profileDataModel.age = int.parse(ageController.text);

    await _profileService.setProfile(
      userID: _authService.currentUser!.uid,
      profileDataModel: _profileDataModel,
    );

    viewState = ViewState.idle;
  }
}
