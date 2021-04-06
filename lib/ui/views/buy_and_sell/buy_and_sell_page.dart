import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellLandingResponse.dart';
import 'package:phinex/Bles/bloc/buy_sell/BuySellBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'add_buy_and_sell_product_page.dart';
import 'buy_and_sell_card_item.dart';
import 'buy_and_sell_category.dart';
import 'buy_sell_search_page.dart';

class BuyAndSellPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _BuyAndSellPageState createState() => _BuyAndSellPageState();
}

class _BuyAndSellPageState extends State<BuyAndSellPage> {

  ScrollController controller = ScrollController();

  List<String> filterOptions;

  int selectedOption = -1;
  int selectedCategory;

  bool hideCategoryOptions = true;

  double filterHeightPercent = .45;

  @override
  void initState() {
    super.initState();

    buySellBloc.clear();
    buySellBloc.getLanding();
  }

  @override
  Widget build(BuildContext context) {
    filterOptions = [
      AppLocalization.of(context).translate('category'),
    ];
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: myAppBar(
        AppLocalization.of(context).translate('buy_and_sell'),
        context,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BuySellSearchPage(),
                ),
              );
            },
            color: Colors.black,
          ),
          // IconButton(
          //   icon: Icon(Icons.add),
          //   onPressed: () {
          //     if(AppUtils.userData == null) {
          //       AppUtils.showNeedToRegisterDialog(context);
          //       return;
          //     }
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (_) => AddBuySellProductPage(),
          //       ),
          //     );
          //   },
          //   color: Colors.black,
          // ),
        ],
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, HomeContents());
        },
      ),
      body: WillPopScope(
        child: StreamBuilder<BuySellLandingResponse>(
          stream: buySellBloc.landing.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return SingleChildScrollView(
                physics: bouncingScrollPhysics,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      elevation: 5,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(12),
                          top: ScreenUtil().setHeight(10),
                          bottom: ScreenUtil().setHeight(10),
                        ),
                        height: ScreenUtil().setHeight(80),
                        width: double.infinity,
                        child: ListView(
                          physics: bouncingScrollPhysics,
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            filterOptions.length,
                            (index) {
                              return GestureDetector(
                                onTap: () {
                                  if (selectedOption == index) {
                                    selectedOption = -1;
                                    hideCategoryOptions = true;
                                  } else {
                                    hideCategoryOptions = false;
                                    selectedOption = index;
                                  }
                                  setState(() {});
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: selectedOption == index
                                        ? mainColor.withOpacity(.1)
                                        : Colors.white,
                                    border: Border.all(
                                      color: selectedOption == index
                                          ? mainColor
                                          : Colors.grey[300],
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(filterOptions[index]),
                                      Icon(
                                        selectedOption == index
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(8),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectedOption = -1;
                        hideCategoryOptions = true;
                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                height: ScreenUtil().setHeight(450),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data.data
                                                .categoriesItems[index].name,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Provider.of<PageProvider>(context, listen: false).setPage(
                                                SingleBuySellCategory.pageIndex,
                                                SingleBuySellCategory(
                                                  categoryID: snapshot.data.data.categoriesItems[index].id,
                                                  categoryName: snapshot.data.data.categoriesItems[index].name,
                                                ),
                                              );
                                            },
                                            child: Text(
                                              AppLocalization.of(context)
                                                  .translate('see_all'),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: mainColor,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        physics: bouncingScrollPhysics,
                                        itemBuilder: (context, index2) {
                                          return Container(
                                            width: ScreenUtil().setWidth(255),
                                            child: BuySellCartItem(
                                              productsBean: snapshot
                                                  .data
                                                  .data
                                                  .categoriesItems[index]
                                                  .items[index2],
                                            ),
                                          );
                                        },
                                        itemCount: snapshot
                                            .data
                                            .data
                                            .categoriesItems[index]
                                            .items
                                            .length,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount:
                                snapshot.data.data.categoriesItems.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                          hideCategoryOptions
                              ? SizedBox.shrink()
                              : categoryFilter(
                                  snapshot.data.data.categories,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('error'),
              );
            }
            return Loader();
          },
        ),
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, HomeContents());
          return false;
        },
      ),
    );
  }

  Widget categoryFilter(List<CategoriesBean> categories) {
    List<String> options = [];
    categories.forEach((element) {
      options.add(element.name);
    });

    for (int i = 0; i < categories.length; i++) {
      options.add(categories[i].name);
      if (categories[i].id == selectedCategory) {
        selectedCategory = i;
      }
    }
    return Container(
      color: Colors.transparent.withOpacity(.35),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(
            height: 2,
          ),
          Container(
            height: MediaQuery.of(context).size.height * filterHeightPercent,
            child: Material(
              elevation: 8,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(2),
                child: Column(
                  children: [
                    Expanded(
                      child: Scrollbar(
                        controller: controller,
                        isAlwaysShown: true,
                        thickness: 5,
                        radius: Radius.circular(80),
                        child: SingleChildScrollView(
                          controller: controller,
                          physics: bouncingScrollPhysics,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              children: List.generate(
                                categories.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    selectedCategory = index;
                                    setState(() {});
                                  },
                                  child: Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      width: ScreenUtil().setWidth(
                                          categories[index].name.length < 15
                                              ? 135
                                              : 215),
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: selectedCategory == index
                                            ? mainColor.withOpacity(.2)
                                            : Color(0xfF5F5F5),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            selectedCategory == index
                                                ? Icon(
                                                    Icons.cancel,
                                                    color: deepBlueColor,
                                                    size: 18,
                                                  )
                                                : SizedBox.shrink(),
                                            selectedCategory == index
                                                ? SizedBox(
                                                    width: 8,
                                                  )
                                                : SizedBox.shrink(),
                                            Text(
                                              categories[index].name,
                                              style: TextStyle(
                                                color: selectedCategory == index
                                                    ? mainColor
                                                    : Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      height: ScreenUtil().setHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          onPressed: () {
                            selectedOption = -1;
                            hideCategoryOptions = true;
                            clearFilter();

                            setState(() {});
                          },
                          child: Text(
                            AppLocalization.of(context)
                                .translate('clear_filter'),
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            selectedOption = -1;
                            hideCategoryOptions = true;
                            sendFilterRequest(categories);
                            setState(() {});
                          },
                          child: Text(
                            AppLocalization.of(context).translate('apply'),
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendFilterRequest(List<CategoriesBean> categories) {
    if (selectedCategory == null || selectedCategory == -1) {
      return;
    }

    var category = categories[selectedCategory];
    print(category.toJson());

    Provider.of<PageProvider>(context, listen: false).setPage(
      SingleBuySellCategory.pageIndex,
      SingleBuySellCategory(
        categoryID: category.id,
        categoryName: category.name,
      ),
    );
  }

  void clearFilter() {
    selectedOption = -1;
    selectedCategory = -1;
    hideCategoryOptions = true;
    setState(() {});
  }
}
