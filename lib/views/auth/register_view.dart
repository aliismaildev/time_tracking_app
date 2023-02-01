import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app/consts/colors.dart';
import 'package:time_tracking_app/consts/lang.dart';
import 'package:time_tracking_app/core/viewmodels/auth_viewmodel.dart';
import 'package:time_tracking_app/utils/percentage_size_ext.dart';
import 'package:time_tracking_app/views/base_views/base_views.dart';
import 'package:time_tracking_app/views/home/home_view.dart';
import 'package:time_tracking_app/views/widgets/buttons.dart';
import 'package:time_tracking_app/views/widgets/text.dart';
import 'package:time_tracking_app/views/widgets/text_fields.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);
  static const String routeName = '/registerView';

  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthViewModel>();
    return BaseScaffold(
      showAppBar: false,
      body: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).viewPadding.top),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              headline1(Lang.register),
              SizedBox(
                height: context.percentHeight * 3.0,
              ),
              CustomTxtField(
                  hintTxt: Lang.name,
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return "${Lang.name} ${Lang.isRequired}";
                    }
                    return null;
                  },
                  textEditingController: read.nameController),
              CustomTxtField(
                hintTxt: Lang.age,
                textEditingController: read.ageController,
                textInputType: TextInputType.number,
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return "${Lang.age} ${Lang.isRequired}";
                  }
                  return null;
                },
              ),
              CustomTxtField(
                hintTxt: Lang.email,
                textEditingController: read.emailController,
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return "${Lang.email} ${Lang.isRequired}";
                  }
                  return null;
                },
              ),
              CustomTxtField(
                hintTxt: Lang.password,
                textEditingController: read.passwordController,
                isHiddenPassword: true,
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return "${Lang.password} ${Lang.isRequired}";
                  }
                  return null;
                },
              ),
              AppElevatedButton(
                title: Lang.register,
                onPressed: () async {
                  final result = await read.register();
                  if (result.isSuccess) {
                    await read.createBaseProfile();
                    Navigator.pushNamed(context, HomeView.routeName);
                  } else {
                    //show some error
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: context.percentHeight * 3.5,
                  bottom: context.percentHeight * 1.5,
                ),
                child: subText2('${Lang.alreadyRegisteredUser} ${Lang.questionMark}', fontWeight: FontWeight.w500),
              ),
              AppElevatedButton(
                backgroundColor: AppColors.textColor,
                onPressed: () => Navigator.pop(context),
                title: Lang.logIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
