import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/consts.dart';

class DriverChatPage extends StatefulWidget {
  @override
  _DriverChatPageState createState() => _DriverChatPageState();
}

class _DriverChatPageState extends State<DriverChatPage> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              color: deepBlueColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  AssetImage('assets/images/avatar.png'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Ahmed Magdi',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        FloatingActionButton(
                          mini: true,
                          onPressed: () {},
                          child: Icon(Icons.phone, color: deepBlueColor),
                          backgroundColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                reverse: true,
                controller: listScrollController,
                physics: bouncingScrollPhysics,
                itemBuilder: (context, index) {
                  if (index == 14) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(18),
                          bottom: ScreenUtil().setHeight(10),
                        ),
                        decoration: BoxDecoration(
                          color: mainColor.withOpacity(.15),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(
                          ScreenUtil().setWidth(10),
                        ),
                        child: Text(
                          '4, April 2020',
                          style: TextStyle(color: mainColor),
                        ),
                      ),
                    );
                  }
                  return index % 4 == 0
                      ? myWidget(
                          buildText(
                            "انا بجوار المحطة",
                          ),
                        )
                      : senderWidget();
                },
                itemCount: 2,
              ),
            ),
            Card(
              elevation: 4,
              margin: EdgeInsets.zero,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: translate(context, 'type_your_message'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        textEditingController.clear();
                      },
                      child: Row(
                        children: [
                          Container(
                            width: .5,
                            height: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.close,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget senderWidget() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Localizations.localeOf(context).languageCode == 'ar'
                      ? 0
                      : ScreenUtil().setWidth(10),
                  right: Localizations.localeOf(context).languageCode == 'ar'
                      ? ScreenUtil().setWidth(10)
                      : 0,
                  bottom: ScreenUtil().setHeight(8),
                ),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
              ),
              Expanded(
                child: Bubble(
                  nip: Localizations.localeOf(context).languageCode == 'ar'
                      ? BubbleNip.rightBottom
                      : BubbleNip.leftBottom,
                  nipWidth: 15,
                  nipHeight: 15,
                  margin: BubbleEdges.symmetric(
                    horizontal: ScreenUtil().setWidth(12),
                    vertical: ScreenUtil().setHeight(10),
                  ),
                  color: mainColor,
                  child: Text(
                    "لقد وصلت اين انت ؟",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(40),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Localizations.localeOf(context).languageCode == 'ar'
                  ? 0
                  : ScreenUtil().setWidth(60),
              right: Localizations.localeOf(context).languageCode == 'ar'
                  ? ScreenUtil().setWidth(60)
                  : 0,
            ),
            child: Text(
              '08.27 pm',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildText(String txt) {
    return Text(
      txt,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget myWidget(Widget child) {
    return Padding(
      padding: EdgeInsets.only(
        right: Localizations.localeOf(context).languageCode == 'ar'
            ? 0
            : ScreenUtil().setWidth(10),
        left: Localizations.localeOf(context).languageCode == 'ar'
            ? ScreenUtil().setWidth(10)
            : 0,
        bottom: ScreenUtil().setWidth(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                width: ScreenUtil().setWidth(40),
              ),
              Expanded(
                child: Bubble(
                  nipWidth: 15,
                  nipHeight: 15,
                  nip: Localizations.localeOf(context).languageCode == 'ar'
                      ? BubbleNip.leftBottom
                      : BubbleNip.rightBottom,
                  margin: BubbleEdges.symmetric(
                    horizontal: ScreenUtil().setWidth(12),
                    vertical: ScreenUtil().setHeight(10),
                  ),
                  color: deepBlueColor,
                  child: child,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Localizations.localeOf(context).languageCode == 'ar'
                  ? 0
                  : ScreenUtil().setWidth(10),
              right: Localizations.localeOf(context).languageCode == 'ar'
                  ? ScreenUtil().setWidth(10)
                  : 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '08.27 pm',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(6),
                ),
                CircleAvatar(
                  radius: 7,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
