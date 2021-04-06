import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/utils/consts.dart';

class MyDropLayout extends StatefulWidget {
  final String to, from;

  const MyDropLayout({Key key, @required this.to, @required this.from})
      : super(key: key);

  @override
  _MyDropLayoutState createState() => _MyDropLayoutState();
}

class _MyDropLayoutState extends State<MyDropLayout> {
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
                child: Container(
                    width: ScreenUtil().setWidth(2), color: deepBlueColor),
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
          Column(
            children: [
              Text(
                widget.from,
                style: TextStyle(
                  color: Colors.grey,
                  // fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(8),
              ),
              Text(
                widget.to,
                style: TextStyle(
                  color: Colors.grey,
                  // fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
