import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/utils/consts.dart';

class MyTextFormField extends StatefulWidget {
  final int maxLines;
  final TextEditingController controller;
  final validator;
  final onChanged;
  final String title;
  final TextStyle titleStyle;
  final TextStyle errorStyle;
  final String hintText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final double width;
  final double separatorHeight;
  final bool obscureText;
  final keyboardType;
  final String errorMessage;
  final Function onTap;
  final bool enabled;
  final String initialValue;

  const MyTextFormField({
    Key key,
    this.maxLines = 1,
    this.controller,
    this.validator,
    this.onChanged,
    this.hintText,
    this.title = '',
    this.width = double.infinity,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.errorMessage,
    this.titleStyle,
    this.onTap,
    this.enabled, this.initialValue, this.errorStyle, this.separatorHeight,
  }) : super(key: key);

  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: widget.titleStyle ?? TextStyle(color: Colors.grey),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(widget.separatorHeight ?? 5),
        ),
        Container(
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xffEEEEEE),
          ),
          child: TextFormField(
            initialValue: widget.initialValue,
            validator: widget.validator,
            onTap: widget.onTap,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            style: TextStyle(decoration: TextDecoration.none),
            onChanged: widget.onChanged,
            maxLines: widget.maxLines,
            enabled: widget.enabled,
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(12),
                vertical: widget.prefixIcon != null || widget.suffixIcon != null
                    ? ScreenUtil().setHeight(10)
                    : 0,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: mainColor, width: 1),
              ),
              errorStyle: widget.errorStyle,
              border: InputBorder.none,
              hintText: widget.hintText ?? '',
            ),
          ),
        ),
        Text(
          widget.errorMessage ?? '',
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
      ].where((element) => element != null).toList(),
    );
  }
}
