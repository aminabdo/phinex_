import 'package:flutter/material.dart';

import 'my_button.dart';

class DoneDialogContent extends StatefulWidget {
  final String msg;

  const DoneDialogContent({Key key, @required this.msg}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DoneDialogContentState();
}

class DoneDialogContentState extends State<DoneDialogContent>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

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
            height: MediaQuery.of(context).size.height / 1.8,
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
                SizedBox(
                  height: 5,
                ),
                Image.asset(
                  'assets/images/done_image.png',
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.msg,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                myButton(
                  'Done',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
