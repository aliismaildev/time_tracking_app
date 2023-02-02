import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app/core/viewmodels/auth_viewmodel.dart';
import 'package:time_tracking_app/views/auth/login_view.dart';
import 'package:time_tracking_app/views/base_views/base_views.dart';
import 'package:time_tracking_app/views/home/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);
  static const String routeName = '/splashView';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AuthViewModel read = AuthViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      read = context.read<AuthViewModel>();
      Future.delayed(const Duration(seconds: 2))
          .then((value) => Navigator.pushReplacementNamed(context, read.currentUser != null ? HomeView.routeName : LoginView.routeName));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(body: Container());
  }
}
