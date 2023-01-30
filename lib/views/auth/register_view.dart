import 'package:flutter/material.dart';
import 'package:time_tracking_app/consts/colors.dart';
import 'package:time_tracking_app/consts/lang.dart';
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
                      return 'Please enter Name';
                    }
                    return null;
                  },
                  textEditingController: TextEditingController()),
              CustomTxtField(hintTxt: Lang.age, textEditingController: TextEditingController()),
              CustomTxtField(
                textEditingController: TextEditingController(),
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return 'Please enter Age';
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
                title: Lang.register,
                onPressed: () {
                  Navigator.pushNamed(context, HomeView.routeName);
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: context.percentHeight * 3.5,
                  bottom: context.percentHeight * 1.5,
                ),
                child: subText2(
                    '${Lang.alreadyRegisteredUser} ${Lang.questionMark}',
                    fontWeight: FontWeight.w500),
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
