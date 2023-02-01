import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:result_type/result_type.dart';
import 'package:time_tracking_app/consts/enums.dart';
import 'package:time_tracking_app/core/services/auth_service.dart';
import 'package:time_tracking_app/core/viewmodels/base_viewmodel.dart';

class AuthViewModel extends BaseViewModel {
  final AuthService _authService = AuthService();
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
}
