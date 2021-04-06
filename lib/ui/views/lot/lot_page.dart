import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/auctions/AuctionLandingResponse.dart';
import 'package:phinex/Bles/bloc/auction/HighestPriceBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'add_lot_page.dart';
import 'lot_category_page.dart';

class LotPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _LotPageState createState() => _LotPageState();
}

class _LotPageState extends State<LotPage> {
  @override
  void initState() {
    super.initState();

    highestPriceBloc.getLanding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: myAppBar(
        AppLocalization.of(context).translate('lot'),
        context,
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddLotPage(),
                  ),
                );
              },),
        ],
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, HomeContents());
        },
      ),
      body: WillPopScope(
        child: StreamBuilder<AuctionLandingResponse>(
            stream: highestPriceBloc.landing.stream,
            builder: (context, snapshot) {
              if (highestPriceBloc.loading.value) {
                return Loader();
              } else {
                return SingleChildScrollView(
                  physics: bouncingScrollPhysics,
                  child: Padding(
                    padding: EdgeInsets.all(
                      ScreenUtil().setWidth(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalization.of(context)
                              .translate('popular_categories'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: snapshot.data.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => LotCategoryPage(
                                      id: snapshot.data.data[index].id,
                                      name: snapshot.data.data[index].name,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(
                                  ScreenUtil().setWidth(3),
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                  elevation: 4,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot
                                                .data.data[index].imageUrl,
                                            placeholder: (_, __) {
                                              return Loader(
                                                size: 40,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      myButton(
                                        snapshot.data.data[index].name,
                                        decoration: BoxDecoration(
                                          color: mainColor,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, HomeContents());
          return false;
        },
      ),
    );
  }
}
