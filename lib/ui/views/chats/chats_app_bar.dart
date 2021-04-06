import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/utils/consts.dart';

class ChatsAppBar extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget action;

  const ChatsAppBar(
      {Key key, @required this.title, @required this.subtitle, this.action})
      : super(key: key);

  @override
  _ChatsAppBarState createState() => _ChatsAppBarState();
}

class _ChatsAppBarState extends State<ChatsAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(60),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                  Localizations.localeOf(context).languageCode == 'en' ?  Icons.arrow_back_ios_rounded : Icons.arrow_back_ios,
                    color: deepBlueColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(15),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                   widget.subtitle == '' ? null : Text(
                      widget.subtitle,
                      style: TextStyle(color: mainColor),
                    ),
                  ].where((element) => element != null).toList(),
                ),
              ],
            ),
            widget.action
          ].where((element) => element != null).toList(),
        ),
      ),
    );
  }
}
