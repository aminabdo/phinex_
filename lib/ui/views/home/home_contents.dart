
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/bloc/admin_chat/AdminChatBloc.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/animations/delayed_reveal_animation.dart';
import 'package:phinex/ui/views/auctions/auctions_page.dart';
import 'package:phinex/ui/views/bank_idea/bank_idea_page.dart';
import 'package:phinex/ui/views/buy_and_sell/buy_and_sell_page.dart';
import 'package:phinex/ui/views/chats/main_chat_page.dart';
import 'package:phinex/ui/views/companies_index/companie_index_page.dart';
import 'package:phinex/ui/views/custom_support/custom_support_page.dart';
import 'package:phinex/ui/views/lot/lot_page.dart';
import 'package:phinex/ui/views/news/news_page.dart';
import 'package:phinex/ui/views/suggest_service/suggest_service_page.dart';
import 'package:phinex/ui/views/videos/videos_page.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'home_search_page.dart';
import 'services_page.dart';

class HomeContents extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _HomeContentsState createState() => _HomeContentsState();
}

class _HomeContentsState extends State<HomeContents> {
  List<Categories> categories = [];
  List<String> ads = [];

  bool initiateChatWithAdmin = false;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {

    if(generalBloc.countries.value == null || generalBloc.countries.value.data == null) {
      generalBloc.getCountries();
    }

    if(generalBloc.generalGovModel.value == null || generalBloc.generalGovModel.value.data == null) {
      generalBloc.getModelGov();
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    categories = [
      Categories(
        'assets/images/services.png',
        AppLocalization.of(context).translate("services"),
      ),
      Categories(
        'assets/images/auction.svg',
        AppLocalization.of(context).translate("auctions"),
        isSvg: true,
      ),
      Categories(
        'assets/images/auction.png',
        AppLocalization.of(context).translate("lot"),
      ),
      Categories(
        'assets/images/shop-bag.png',
        AppLocalization.of(context).translate("buy_and_sell"),
      ),
      Categories(
        'assets/images/index.png',
        AppLocalization.of(context).translate("index"),
      ),
      Categories(
        'assets/images/news.png',
        AppLocalization.of(context).translate("news"),
      ),
      Categories(
        'assets/images/chat.png',
        AppLocalization.of(context).translate("chats"),
      ),
      Categories(
        'assets/images/idea.png',
        translate(context, 'ideas_bank'),
      ),
      Categories(
        'assets/images/funny_video.png',
        translate(context, 'funny_videos'),
      ),
      Categories(
        'assets/images/suggest_service.png',
        translate(context, 'suggest_service'),
        width: 80,
      ),
      Categories(
        'assets/images/custom_support.png',
        translate(context, 'custom_support'),
      ),
      Categories(
        'assets/images/coming_soon.png',
        translate(context, 'coming_soon'),
      ),
    ];

    ads = [
      'assets/images/coca.png',
      'assets/images/mac.png',
      'assets/images/voda.png',
      'assets/images/mg.png',
      'assets/images/zar.png',
    ];

    var pageProvider = Provider.of<PageProvider>(context);

    return Padding(
      padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ScreenUtil()
                  .setHeight(MediaQuery.of(context).padding.top + 15),
            ),
            Container(
              padding: EdgeInsets.only(
                left: Localizations.localeOf(context).languageCode == 'ar'
                    ? ScreenUtil().setWidth(0)
                    : ScreenUtil().setWidth(12),
                right: Localizations.localeOf(context).languageCode == 'ar'
                    ? ScreenUtil().setWidth(12)
                    : ScreenUtil().setWidth(0),
              ),
              height: ScreenUtil().setHeight(55),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onTap: () {
                        pageProvider.setPage(0, HomeSearchPage());
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 5),
                        hintText: AppLocalization.of(context)
                            .translate('type_products_brands_or_categories'),
                        hintStyle: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(55),
                    height: ScreenUtil().setHeight(70),
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius:
                          Localizations.localeOf(context).languageCode == 'ar'
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                )
                              : BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Text(
              translate(context, 'sponsored_ads'),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: Localizations.localeOf(context).languageCode == 'en'
                    ? 15
                    : 0,
                right: Localizations.localeOf(context).languageCode == 'en'
                    ? 0
                    : 15,
              ),
              height: ScreenUtil().setHeight(90),
              child: ListView.builder(
                physics: bouncingScrollPhysics,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Image.asset(ads[index]),
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: ads.length,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  int time = (100 * index);
                  return DelayedReveal(
                    delay: Duration(milliseconds: time),
                    child: GestureDetector(
                      onTap: () async {
                        if (index == 0) {
                          pageProvider.setPage(
                              ServicesPage.pageIndex, ServicesPage());
                        } else if (index == 1) {
                          if (AppUtils.userData == null) {
                            AppUtils.showNeedToRegisterDialog(context);
                            return;
                          }
                          // pageProvider.setPage(AuctionsPage.pageIndex, AuctionsPage());
                        } else if (index == 2) {
                          if (AppUtils.userData == null) {
                            AppUtils.showNeedToRegisterDialog(context);
                            return;
                          }
                          // pageProvider.setPage(LotPage.pageIndex, LotPage());
                        } else if (index == 3) {
                          pageProvider.setPage(
                              BuyAndSellPage.pageIndex, BuyAndSellPage());
                        } else if (index == 4) {
                          pageProvider.setPage(CompaniesIndexPage.pageIndex,
                              CompaniesIndexPage());
                        } else if (index == 5) {
                          pageProvider.setPage(NewsPage.pageIndex, NewsPage());
                        } else if (index == 6) {
                          if (AppUtils.userData == null || AppUtils.userData.id == null) {
                            AppUtils.showNeedToRegisterDialog(context);
                            return;
                          }
                          // pageProvider.setPage(
                          //   MainChatPage.pageIndex,
                          //   MainChatPage(),
                          // );
                        } else if (index == 7) {
                          pageProvider.setPage(
                            BankIdeaPage.pageIndex,
                            BankIdeaPage(),
                          );
                        } else if (index == 8) {
                          pageProvider.setPage(
                            VideosPage.pageIndex,
                            VideosPage(),
                          );
                        } else if (index == 9) {
                          if (AppUtils.userData == null || AppUtils.userData.id == null) {
                            AppUtils.showNeedToRegisterDialog(context);
                            return;
                          }
                          pageProvider.setPage(
                            SuggestServicePage.pageIndex,
                            SuggestServicePage(),
                          );
                        } else if (index == 10) {
                          if (AppUtils.userData == null || AppUtils.userData.id == null) {
                            AppUtils.showNeedToRegisterDialog(context);
                            return;
                          }

                          setState(() {
                            initiateChatWithAdmin = true;
                          });

                          // int id = await adminChatBloc.intiateNewChat();
                          // print('>>>>>>>>>>>>>>>> $id');

                          setState(() {
                            initiateChatWithAdmin = false;
                          });

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => CustomSupportChatPage(
                          //       id: id,
                          //     ),
                          //   ),
                          // );
                        }
                      },
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              categories[index].isSvg
                                  ? SvgPicture.asset(
                                      categories[index].imagePath,
                                      width: ScreenUtil().setWidth(
                                          categories[index].width ?? 60),
                                      height: ScreenUtil().setHeight(
                                          categories[index].height ?? 90),
                                    )
                                  : Image.asset(
                                      categories[index].imagePath,
                                      width: ScreenUtil().setWidth(
                                          categories[index].width ?? 60),
                                      height: ScreenUtil().setHeight(
                                          categories[index].height ?? 90),
                                    ),
                              index == 10 && initiateChatWithAdmin
                                  ? Loader(
                                      size: 20,
                                    )
                                  : Text(
                                      categories[index].title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: categories.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate:
                    MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                  crossAxisCount: 2,
                  height: ScreenUtil().setHeight(170),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Categories {
  final String imagePath;
  final String title;
  final bool isSvg;
  final double height;
  final double width;

  Categories(this.imagePath, this.title,
      {this.isSvg = false, this.height, this.width});
}
