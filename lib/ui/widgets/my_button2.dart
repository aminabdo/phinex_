import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/utils/consts.dart';

Widget myButton2(
  Widget child, {
  Function onTap,
  Color btnColor,
  BoxDecoration decoration,
  double width,
  TextStyle textStyle,
  double height,
  EdgeInsets margin,
}) {
  return Container(
    width: width ?? double.infinity,
    margin: margin,
    height: ScreenUtil().setHeight(height ?? 45),
    decoration: decoration ??
        BoxDecoration(
          color: btnColor ?? deepBlueColor,
          borderRadius: BorderRadius.circular(5),
        ),
    child: FlatButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(12),
        ),
        child: child,
      ),
    ),
  );
}
