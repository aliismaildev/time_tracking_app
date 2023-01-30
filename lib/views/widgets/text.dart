import 'package:flutter/material.dart';
import 'package:time_tracking_app/consts/colors.dart';

///Fontsize 24 bold
Text headline1(String title, {Color color = AppColors.textColor}) => Text(
      title,
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
//fontsize 30
Text headline0(String title, {Color color = AppColors.textColor, TextAlign? textAlign, FontWeight fontWeight = FontWeight.normal}) => Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        fontSize: 28.0,
        fontWeight: fontWeight,
        color: color,
      ),
    );

///Fontsize 24
Text headline2(String title, {Color color = AppColors.textColor, TextAlign? textAlign, FontWeight fontWeight = FontWeight.normal}) => Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: fontWeight,
        color: color,
      ),
    );

///Fontsize 22 bold
Text headline3(String title, {Color color = AppColors.textColor, TextAlign? textAlign}) => Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );

///Fontsize 22
Text headline4(String title, {Color color = AppColors.textColor}) => Text(
      title,
      style: TextStyle(fontSize: 22.0, color: color),
    );

///Fontsize 20
Text headline5(String title, {TextAlign? align, Color? color = AppColors.textColor, TextDecoration? txtDecoration}) => Text(
      title,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(decoration: txtDecoration ?? TextDecoration.none, fontSize: 20.0, color: color),
    );

///Fontsize 18 grey
Text subText1(
  String title, {
  TextAlign? align,
  double? fontSize,
  Color color = AppColors.textColor,
}) =>
    Text(
      title,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
        fontSize: fontSize ?? 18.0,
        color: color,
      ),
    );

///Fontsize 18 grey bold
Text subText2(
  String title, {
  TextAlign? align,
  Color color = AppColors.textColor,
  FontWeight? fontWeight,
}) =>
    Text(
      title,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
        fontSize: 18.0,
        color: color,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
//fontSize 26
Text subText5(
  String title, {
  TextAlign? align,
  Color color = AppColors.textColor,
  double? fontSize,
  FontWeight? fontWeight,
  TextOverflow? textOverflow,
}) =>
    Text(
      title,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
        fontSize: fontSize ?? 16.0,
        color: color,
        overflow: textOverflow,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
//fontSize 14
Text subText4(
  String title, {
  TextAlign? align,
  Color color = AppColors.textColor,
  FontWeight? fontWeight,
}) =>
    Text(
      title,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
        fontSize: 14.0,
        color: color,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );

///Fontsize 12 grey
Text subText3(
  String title, {
  TextAlign? align,
  Color color = AppColors.textColor,
  FontWeight? fontWeight,
  TextOverflow? textOverflow,
}) =>
    Text(
      title,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(fontSize: 14.0, overflow: textOverflow, color: color, fontWeight: fontWeight),
    );
//Fontsize 8
Text subText6(
  String title, {
  TextAlign? align,
  Color color = Colors.black45,
}) =>
    Text(
      title,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
        fontSize: 8.0,
        color: color,
      ),
    );
