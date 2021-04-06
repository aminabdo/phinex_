import 'package:flutter/material.dart';

Widget myAppBar(
  String title,
  BuildContext context, {
  bool withLeading = true,
  Function onBackBtnClicked,
  List<Widget> actions,
  String subtitle,
  TextStyle subtitleStyle,
  Widget leadingIcon,
  double elevation,
}) {
  return AppBar(
    elevation: elevation,
    title: Column(
      children: [
        Text(
          title,
          textAlign: Localizations.localeOf(context).languageCode == 'ar'
              ? TextAlign.right
              : TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle == null
            ? SizedBox.shrink()
            : Text(subtitle, style: subtitleStyle),
      ],
    ),
    backgroundColor: Colors.white,
    centerTitle: true,
    actions: actions,
    leading: withLeading
        ? leadingIcon ??
            IconButton(
              icon: Icon(
                Localizations.localeOf(context).languageCode == 'ar'
                    ? Icons.arrow_forward_ios_outlined
                    : Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
              onPressed: onBackBtnClicked ??
                  () {
                    Navigator.of(context).pop();
                  },
            )
        : SizedBox.shrink(),
  );
}
