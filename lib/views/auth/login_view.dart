import 'package:flutter/material.dart';
import 'package:time_tracking_app/consts/colors.dart';
import 'package:time_tracking_app/consts/lang.dart';
import 'package:time_tracking_app/utils/percentage_size_ext.dart';
import 'package:time_tracking_app/views/auth/register_view.dart';
import 'package:time_tracking_app/views/base_views/base_views.dart';
import 'package:time_tracking_app/views/home/home_view.dart';
import 'package:time_tracking_app/views/widgets/buttons.dart';
import 'package:time_tracking_app/views/widgets/text.dart';
import 'package:time_tracking_app/views/widgets/text_fields.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  static const String routeName = '/loginView';

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showAppBar: false,
      body: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).viewPadding.top),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              headline1(Lang.logIn),
              SizedBox(
                height: context.percentHeight * 3.0,
              ),
              CustomTxtField(
                hintTxt: Lang.email,
                textEditingController: TextEditingController(),
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return 'Please enter Email';
                  }
                  return null;
                },
              ),
              CustomTxtField(
                hintTxt: Lang.password,
                textEditingController: TextEditingController(),
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return 'Please enter Password';
                  }
                  return null;
                },
              ),
              AppElevatedButton(
                title: Lang.logIn,
                onPressed: () {
                  Navigator.pushNamed(context, HomeView.routeName);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.percentHeight * 3.0),
                child: subText2('${Lang.newUser} ${Lang.questionMark}', fontWeight: FontWeight.w500),
              ),
              AppElevatedButton(
                backgroundColor: AppColors.textColor,
                onPressed: () => Navigator.pushNamed(context, RegisterView.routeName),
                title: Lang.register,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
