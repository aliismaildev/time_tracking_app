import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app/consts/colors.dart';
import 'package:time_tracking_app/consts/enums.dart';
import 'package:time_tracking_app/consts/lang.dart';
import 'package:time_tracking_app/core/viewmodels/auth_viewmodel.dart';
import 'package:time_tracking_app/utils/percentage_size_ext.dart';
import 'package:time_tracking_app/views/auth/register_view.dart';
import 'package:time_tracking_app/views/base_views/base_views.dart';
import 'package:time_tracking_app/views/home/home_view.dart';
import 'package:time_tracking_app/views/widgets/buttons.dart';
import 'package:time_tracking_app/views/widgets/text.dart';
import 'package:time_tracking_app/views/widgets/text_fields.dart';
import 'package:time_tracking_app/views/widgets/toast.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  static const String routeName = '/loginView';

  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthViewModel>();
    final watch = context.watch<AuthViewModel>();
    return BaseScaffold(
      showAppBar: false,
      body: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).viewPadding.top),
        child: Center(
          child: Form(
            key: read.logInFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                headline1(Lang.logIn),
                SizedBox(
                  height: context.percentHeight * 3.0,
                ),
                CustomTxtField(
                  hintTxt: Lang.email,
                  textEditingController: read.emailController,
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return '${Lang.email} ${Lang.isRequired}';
                    }
                    return null;
                  },
                ),
                CustomTxtField(
                  hintTxt: Lang.password,
                  isHiddenPassword: true,
                  textEditingController: read.passwordController,
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return '${Lang.password} ${Lang.isRequired}';
                    }
                    return null;
                  },
                ),
                watch.viewState == ViewState.busy
                    ? const CircularProgressIndicator()
                    : AppElevatedButton(
                        title: Lang.logIn,
                        onPressed: () async {
                          if (read.logInFormKey.currentState!.validate()) {
                            final result = await read.login();

                            if (result.isSuccess) {
                              if (context.mounted) Navigator.pushNamed(context, HomeView.routeName);
                            } else {
                              showToast(msg: result.toString());
                            }
                          }
                        }),
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
      ),
    );
  }
}
