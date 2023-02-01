import 'package:flutter/material.dart';
import 'package:time_tracking_app/consts/colors.dart';
import 'package:time_tracking_app/utils/percentage_size_ext.dart';

class CustomTxtField extends StatelessWidget {
  final String? hintTxt;
  final bool isHiddenPassword;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  final TextEditingController? textEditingController;

  const CustomTxtField(
      {Key? key,
      this.hintTxt,
      this.validator,
      this.textInputType = TextInputType.name,
      this.textInputAction = TextInputAction.next,
      this.textEditingController,
      this.isHiddenPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.percentHeight * 1.5),
      child: Container(
        width: context.percentWidth * 85,
        height: context.percentWidth * 12,
        decoration: BoxDecoration(
          border: Border.all(width: 0.3, color: AppColors.textColor),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 3.0),
          child: TextFormField(
            textInputAction: textInputAction,
            keyboardType: textInputType,
            cursorColor: AppColors.accent,
            controller: textEditingController,
            obscureText: isHiddenPassword,
            validator: validator,
            style: const TextStyle(color: AppColors.textColor, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintTxt,
              hintStyle: TextStyle(color: AppColors.textColor.withOpacity(0.5), fontWeight: FontWeight.w200),
            ),
          ),
        ),
      ),
    );
  }
}
