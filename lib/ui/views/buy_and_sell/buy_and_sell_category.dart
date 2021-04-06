import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellByCatReposnse.dart';
import 'package:phinex/Bles/bloc/buy_sell/BuySellBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'buy_and_sell_category_card_item.dart';
import 'buy_and_sell_page.dart';
import 'buy_sell_search_page.dart';

class SingleBuySellCategory extends StatefulWidget {
  static final int pageIndex = 0;
  final int categoryID;
  final String categoryName;

  const SingleBuySellCategory(
      {Key key, @required this.categoryID, @required this.categoryName})
      : super(key: key);

  @override
  _SingleBuySellCategoryState createState() =>
      _SingleBuySellCategoryState();
}

class _SingleBuySellCategoryState extends State<SingleBuySellCategory> {

  ScrollController controller = ScrollController();

  List<String> filterOptions;

  int selectedOption = -1;

  int selectedCategory;
  bool hideCategoryOptions = true;

  double filterHeightPercent = .45;

  ScrollController _scrollController = ScrollController();
  int skip = 0;
  int take = 10;

  @override
  void initState() {
    super.initState();

    buySellBloc.clear();
    selectedCategory = widget.categoryID;

    buySellBloc.getByCatID(
      SearchRequest(
        search: widget.categoryID.toString(),
        skip: skip,
        take: take,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    filterOptions = [
      AppLocalization.of(context).translate('category'),
    ];
    return WillPopScope(
      onWillPop: () async {
        Provider.of<PageProvider>(context, listen: false).setPage(
          BuyAndSellPage.pageIndex,
          BuyAndSellPage(),
        );

        return false;
      },
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: myAppBar(
          widget.categoryName,
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
          ],
          onBackBtnClicked: () {
            Provider.of<PageProvider>(context, listen: false).setPage(
              BuyAndSellPage.pageIndex,
              BuyAndSellPage(),
            );
          },
        ),
        body: StreamBuilder<BuySellByCatReposnse>(
          stream: buySellBloc.getByCat.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              _scrollController
                ..addListener(
                  () {
                    if (_scrollController.position.pixels ==
                        _scrollController.position.maxScrollExtent) {
                      skip += 10;
                      take = 10;
                      buySellBloc.getByCatID(
                        SearchRequest(
                          search: widget.categoryID.toString(),
                          skip: skip,
                          take: take,
                        ),
                      );
                    }
                  },
                );
              return SingleChildScrollView(
                physics: bouncingScrollPhysics,
                child: Column(
                  children: [
                    Material(
                      elevation: 5,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(12),
                          top: ScreenUtil().setHeight(10),
                          bottom: ScreenUtil().setHeight(10),
                        ),
                        height: ScreenUtil().setHeight(60),
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                    GestureDetector(
                      onTap: () {
                        selectedOption = -1;
                        hideCategoryOptions = true;
                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          GridView.builder(
                            controller: _scrollController,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                              height: ScreenUtil().setHeight(360),
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 4,
                              crossAxisCount: 2,
                            ),
                            itemCount: snapshot.data.data.items.length,
                            itemBuilder: (context, index) {
                              return BuySellCategoryCartItem(
                                productsBean: snapshot.data.data.items[index],
                              );
                            },
                          ),
                          hideCategoryOptions
                              ? SizedBox.shrink()
                              : categoryFilter(snapshot.data.data.categories),
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
      ),
    );
  }

  Widget categoryFilter(List<CategoriesBean> categories) {
    List<String> options = [];
    categories.forEach((element) {
      options.add(element.name);
    });

    for(int i = 0; i < categories.length; i++) {
      options.add(categories[i].name);
      if(categories[i].id == selectedCategory) {
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
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: selectedCategory == index
                                            ? mainColor.withOpacity(.2)
                                            : Color(0xfF5F5F5),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
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
                                                fontSize: 12,
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
    var _category = categories[selectedCategory];
    buySellBloc.getByCat.value = null;

    buySellBloc.getByCatID(
      SearchRequest(
        search: _category.id.toString(),
        take: take,
        skip: skip,
      ),
    );
  }

  void clearFilter() {
    buySellBloc.getByCat.value = null;
    buySellBloc.getByCatID(
      SearchRequest(
        search: widget.categoryID.toString(),
        take: skip,
        skip: take,
      ),
    );
  }
}
