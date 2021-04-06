
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/utils/consts.dart';

import 'my_text_form_field.dart';

class MyDropLayoutDestination extends StatefulWidget {

  final Function(String from, String to) onDestinationChange;

  const MyDropLayoutDestination({Key key, this.onDestinationChange}) : super(key: key);

  @override
  _MyDropLayoutDestinationState createState() => _MyDropLayoutDestinationState();
}

class _MyDropLayoutDestinationState extends State<MyDropLayoutDestination> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: ScreenUtil().setWidth(15),
                height: ScreenUtil().setHeight(15),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: deepBlueColor, width: 2),
                ),
              ),
              Expanded(
                child: Container(width: ScreenUtil().setWidth(2), color: deepBlueColor),
              ),
              Container(
                width: ScreenUtil().setWidth(15),
                height: ScreenUtil().setHeight(15),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: deepBlueColor, width: 2),
                ),
                child: Center(
                  child: Container(
                    width: ScreenUtil().setWidth(7),
                    height: ScreenUtil().setHeight(7),
                    decoration: BoxDecoration(
                      color: deepBlueColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Expanded(
            child: Column(
              children: [
                MyTextFormField(
                  titleStyle: TextStyle(fontSize: 0),
                  errorStyle: TextStyle(fontSize: 0),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(8),
                ),
                MyTextFormField(
                  titleStyle: TextStyle(fontSize: 0),
                  errorStyle: TextStyle(fontSize: 0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
