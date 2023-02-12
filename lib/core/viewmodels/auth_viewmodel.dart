import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:result_type/result_type.dart';
import 'package:time_tracking_app/consts/enums.dart';
import 'package:time_tracking_app/core/models/profile_datamodel.dart';
import 'package:time_tracking_app/core/services/auth_service.dart';
import 'package:time_tracking_app/core/services/profile_service.dart';
import 'package:time_tracking_app/core/viewmodels/base_viewmodel.dart';
import 'package:time_tracking_app/utils/firebase_global_instances.dart';

class AuthViewModel extends BaseViewModel {
  final AuthService _authService = AuthService();
  final ProfileService _profileService = ProfileService();
  final ProfileDataModel _profileDataModel = ProfileDataModel();
  final GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  User? get currentUser => fireBaseAuth.currentUser;

  final TextEditingController firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      emailController = TextEditingController(),
      ageController = TextEditingController(),
      passwordController = TextEditingController();

  Future<Result> register() async {
    Result? result;
    viewState = ViewState.busy;
    result = await _authService.register(email: emailController.text.trim(), password: passwordController.text.trim());
    if (result.isSuccess) {
      result = await _createBaseProfile(); //create profile in DB
    }
    viewState = ViewState.idle;
    return result;
  }

  Future<Result<UserCredential, Object>> login() async {
    viewState = ViewState.busy;
    final res = await _authService.login(email: emailController.text, password: passwordController.text);
    if (res.isSuccess) {
      emailController.clear();
      passwordController.clear();
    }
    viewState = ViewState.idle;
    return res;
  }

  Future<void> logOut() async => _authService.logOut();

  Future<Result> _createBaseProfile() async {
    _profileDataModel.uid = currentUser?.uid;
    _profileDataModel.firstName = firstNameController.text;
    _profileDataModel.lastName = lastNameController.text;
    _profileDataModel.email = currentUser?.email?.trim();
    _profileDataModel.age = int.parse(ageController.text);

    Result res = await _profileService.setProfile(
      userID: currentUser!.uid,
      profileDataModel: _profileDataModel,
    );

    if (res.isSuccess) {
      _clearRegisterFormFields();
    }

    return res;
  }

  _clearRegisterFormFields() {
    firstNameController.clear();
    lastNameController.clear();
    ageController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
