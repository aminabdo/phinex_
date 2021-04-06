import 'package:flutter/material.dart';
import 'package:phinex/utils/consts.dart';

class SecondFilterOption extends StatefulWidget {
  final String title;
  final bool isSelected;

  const SecondFilterOption({Key key, @required this.title, this.isSelected}) : super(key: key);

  @override
  _SecondFilterOptionState createState() => _SecondFilterOptionState();
}

class _SecondFilterOptionState extends State<SecondFilterOption> {
  Duration animationDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: widget.isSelected ? mainColor.withOpacity(.1) : Colors.white,
        border: Border.all(
          color: widget.isSelected ? mainColor : Colors.grey[300],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Text(widget.title)),
    );
  }
}
