import 'package:flutter/material.dart';
import 'package:time_tracking_app/views/base_views/base_views.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  static const String routeName = '/loginView';

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showAppBar: false,
      body: Column(
        children: [],
      ),
    );
  }
}
