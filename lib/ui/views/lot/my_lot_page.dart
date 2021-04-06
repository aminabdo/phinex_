import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/more/more_page.dart';
import 'package:phinex/ui/widgets/coming_soon.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/utils/app_localization.dart';

class MyLotsPage extends StatefulWidget {
  static final int pageIndex = 4;

  @override
  _MyLotsPageState createState() => _MyLotsPageState();
}

class _MyLotsPageState extends State<MyLotsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        AppLocalization.of(context).translate('my_lots'),
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(MorePage.pageIndex, MorePage());
        },
      ),
      body: WillPopScope(
        child: ComingSoon(),
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(MorePage.pageIndex, MorePage());
          return false;
        },
      ),
      // ListView.separated(
      //   physics: bouncingScrollPhysics,
      //   itemBuilder: (context, index) {
      //     return Container(
      //       width: double.infinity,
      //       color: Colors.white,
      //       child: Padding(
      //         padding: EdgeInsets.all(
      //           ScreenUtil().setWidth(10),
      //         ),
      //         child: Column(
      //           children: [
      //             Row(
      //               children: [
      //                 Expanded(
      //                   child: Container(
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text(
      //                           AppLocalization.of(context)
      //                               .translate('auction'),
      //                           style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 13,
      //                           ),
      //                         ),
      //                         Text(
      //                           AppLocalization.of(context)
      //                               .translate('end_date'),
      //                           style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 13,
      //                           ),
      //                         ),
      //                         Text(
      //                           AppLocalization.of(context)
      //                               .translate('open_price'),
      //                           style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 13,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   width: ScreenUtil().setWidth(15),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text(
      //                           'Canvenls',
      //                           style: TextStyle(
      //                             color: Colors.black,
      //                             fontWeight: FontWeight.bold,
      //                             fontSize: 13,
      //                           ),
      //                         ),
      //                         Text(
      //                           '4 April, 2020',
      //                           style: TextStyle(
      //                             color: Colors.black,
      //                             fontWeight: FontWeight.bold,
      //                             fontSize: 13,
      //                           ),
      //                         ),
      //                         Text(
      //                           '2000 EGY',
      //                           style: TextStyle(
      //                             color: Colors.black,
      //                             fontWeight: FontWeight.bold,
      //                             fontSize: 13,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   width: ScreenUtil().setWidth(15),
      //                 ),
      //                 Expanded(
      //                   flex: 2,
      //                   child: Container(
      //                     child: Center(
      //                       child: Container(
      //                         width: double.infinity,
      //                         height: ScreenUtil().setHeight(90),
      //                         decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(12),
      //                           color: greenColor.withOpacity(.3),
      //                         ),
      //                         child: Column(
      //                           mainAxisAlignment: MainAxisAlignment.center,
      //                           children: [
      //                             Text(
      //                               '${AppLocalization.of(context).translate('you_pay')} & ${AppLocalization.of(context).translate('date')}',
      //                               style: TextStyle(
      //                                 color: deepBlueColor,
      //                                 fontWeight: FontWeight.bold,
      //                                 fontSize: 13,
      //                               ),
      //                             ),
      //                             SizedBox(
      //                               height: ScreenUtil().setHeight(5),
      //                             ),
      //                             Text(
      //                               '\$55.000.000',
      //                               style: TextStyle(
      //                                 color: greenColor,
      //                                 fontWeight: FontWeight.bold,
      //                                 fontSize: 15,
      //                               ),
      //                             ),
      //                             SizedBox(
      //                               height: ScreenUtil().setHeight(5),
      //                             ),
      //                             Text(
      //                               'Apr 4, 2020 - 23:00 PM',
      //                               style: TextStyle(
      //                                 color: greenColor.withOpacity(.5),
      //                                 fontWeight: FontWeight.bold,
      //                                 fontSize: 12,
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      //   itemCount: 5,
      //   separatorBuilder: (BuildContext context, int index) {
      //     return Divider(
      //       thickness: 1,
      //       color: Colors.grey[350],
      //     );
      //   },
      // ),
    );
  }
}
