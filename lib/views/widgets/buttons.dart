import 'package:flutter/material.dart';
import 'package:time_tracking_app/consts/colors.dart';
import 'package:time_tracking_app/utils/percentage_size_ext.dart';
import 'package:time_tracking_app/views/widgets/text.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.onPressed,
    required this.title,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final Function()? onPressed;
  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.percentWidth * 85,
      height: context.percentWidth * 13,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.secondary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: subText2(
            title,
            color: AppColors.btnTxtColor,
          ),
        ),
      ),
    );
  }
}
