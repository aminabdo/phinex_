import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

class MyUploadImageButton extends StatelessWidget {
  final String title;
  final String result;
  final Function onTap;

  const MyUploadImageButton(
      {Key key, @required this.title, this.result, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xffEEEEEE),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(result ?? ''),
                ),
                FlatButton(
                  onPressed: onTap,
                  child: Text(
                    AppLocalization.of(context).translate('upload'),
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ].where((element) => element != null).toList(),
    );
  }
}
