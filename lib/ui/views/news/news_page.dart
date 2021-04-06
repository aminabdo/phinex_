import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/news/BaseNewsResponse.dart';
import 'package:phinex/Bles/bloc/news/NewsBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool gotCategory = false;
  int selectedCategoryTag = 0;

  @override
  void initState() {
    super.initState();

    newsBloc.getNews(AppUtils.language, AppUtils.country, 'general');
  }

  String getCategory() {
    switch (selectedCategoryTag) {
      case 0:
        return 'general';
      case 1:
        return 'business';
      case 2:
        return 'entertainment';
      case 3:
        return 'health';
      case 4:
        return 'science';
      case 5:
        return 'sports';
      case 6:
        return 'technology';
    }
  }

  @override
  Widget build(BuildContext context) {
    List categories = AppUtils.getNewsCat(context);
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: myAppBar(
        AppLocalization.of(context).translate('news'),
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false).setPage(HomeContents.pageIndex, HomeContents());
        },
      ),
      body: WillPopScope(
        child: SingleChildScrollView(
          physics: bouncingScrollPhysics,
          child: Padding(
            padding: EdgeInsets.all(
              ScreenUtil().setWidth(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChipsChoice<int>.single(
                  value: selectedCategoryTag,
                  scrollPhysics: bouncingScrollPhysics,
                  onChanged: (val) {
                    if (selectedCategoryTag == val) {
                      return;
                    }
                    selectedCategoryTag = val;
                    newsBloc.getNews(
                        AppUtils.language, AppUtils.country, getCategory());
                    setState(() {});
                  },
                  choiceActiveStyle: C2ChoiceStyle(
                    showCheckmark: true,
                    color: deepBlueColor,
                    avatarBorderColor: deepBlueColor,
                    borderColor: deepBlueColor,
                  ),
                  choiceStyle: C2ChoiceStyle(
                    avatarBorderColor: Colors.grey,
                    elevation: 3,
                    color: Colors.black45,
                  ),
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: categories,
                    value: (i, v) => i,
                    label: (i, v) => v,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                StreamBuilder<BaseNewsResponse>(
                  stream: newsBloc.news.stream,
                  builder: (context, snapshot) {
                    if (newsBloc.loading.value) {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 5,
                          ),
                          Loader(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 5,
                          ),
                        ],
                      );
                    } else {
                      return snapshot.data.sources.isNotEmpty
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  height: ScreenUtil().setHeight(195),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(1),
                                    vertical: ScreenUtil().setHeight(10),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[400],
                                        spreadRadius: 1,
                                        blurRadius: 6,
                                        offset: Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          snapshot.data.sources[index].name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(6),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            snapshot.data.sources[index].description ?? '',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(6),
                                      ),
                                      myButton(
                                        AppLocalization.of(context).translate('read_more'),
                                        onTap: () async {
                                          await launch(snapshot.data.sources[index].url);
                                        },
                                        decoration: BoxDecoration(
                                          color: deepBlueColor,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: snapshot.data.sources.length,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          AppUtils.translate(context, 'sorry'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Text(
                                          AppUtils.translate(
                                              context, 'no_data_found'),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                      size: 120,
                                    ),
                                  ],
                                ),
                              ],
                            );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, HomeContents(),
          );
          return false;
        },
      ),
    );
  }
}
