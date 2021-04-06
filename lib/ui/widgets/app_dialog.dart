
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'my_button.dart';

class AppDialogContent extends StatefulWidget {

  final String text;

  const AppDialogContent({Key key, @required this.text}) : assert(text != null), super(key: key);

  @override
  State<StatefulWidget> createState() => AppDialogContentState();
}

class AppDialogContentState extends State<AppDialogContent> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.ease);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3.7,
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                    ),
                  ),
                ),
                Text(
                  AppLocalization.of(context).translate(widget.text),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                Row(
                  children: [
                    Expanded(
                      child: myButton(
                        AppLocalization.of(context).translate('ok'),
                        btnColor: mainColor,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
