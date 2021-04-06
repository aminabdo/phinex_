import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button2.dart';
import 'package:phinex/utils/consts.dart';

class BlockListPage extends StatefulWidget {
  @override
  _BlockListPageState createState() => _BlockListPageState();
}

class _BlockListPageState extends State<BlockListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Block List', context),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.all(
                ScreenUtil().setWidth(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/images/avatar.png'),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mohammed El Rayes',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: myButton2(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.block,
                                            color: Colors.red,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'Unblock',
                                            style: TextStyle(color: Colors.red),
                                          )
                                        ],
                                      ),
                                      onTap: () {},
                                      btnColor: Colors.red.withOpacity(.15),
                                      textStyle: TextStyle(color: mainColor)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
