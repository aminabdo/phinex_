import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/store/FilterRequest.dart';
import 'package:phinex/Bles/Model/responses/store/filter/FilterResponse.dart';
import 'package:phinex/Bles/bloc/store/StoreBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/services_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_multi_chips_selection.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'single_store_category_page.dart';
import 'store_card_item.dart';

class StorePage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  double _lowerValue = 1.0;
  double _upperValue = 1000.0;

  bool gotMaxPriceForFirstTime = false;
  List<String> filterOptions;

  ScrollController controller = ScrollController();

  List<String> selectedCategories = [];

  int selectedSortBy = -1;
  int selectedOrderBy = -1;
  int selectedShowOnlyProductsThatHasDiscount; // 0 => NO  || 1 => YES

  int selectedOption = -1;
  int selectedRate = -1;

  bool hideCategoryOptions = true;
  bool hideRangeSlider = true;
  bool hideSortBy = true;
  bool hideRating = true;
  bool showOnlyDiscountProducts = false;

  double filterHeightPercent = .45;

  @override
  void initState() {
    super.initState();

    storeBloc.clear();
    storeBloc.filter(FilterRequest());
  }

  @override
  Widget build(BuildContext context) {

    filterOptions = [
      AppLocalization.of(context).translate('category'),
      AppLocalization.of(context).translate('price_range'),
      AppLocalization.of(context).translate('sort_by'),
      AppLocalization.of(context).translate('rating'),
      AppLocalization.of(context).translate('discount_only'),
    ];

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: myAppBar(
        AppLocalization.of(context).translate('store'),
        context,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
          //     // Navigator.of(context).push(
          //     //   MaterialPageRoute(
          //     //     builder: (_) => StoreSearchPage(),
          //     //   ),
          //     // );
          //   },
          //   color: Colors.black,
          // ),
        ],
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(ServicesPage.pageIndex, ServicesPage());
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(ServicesPage.pageIndex, ServicesPage());
          return false;
        },
        child: StreamBuilder<FilterResponse>(
          stream: storeBloc.myProductFilterSubject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              if (!gotMaxPriceForFirstTime) {
                _upperValue =
                    snapshot.data.data.filtration.max_price.toDouble();
                gotMaxPriceForFirstTime = true;
              }
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
                                    hideRangeSlider = true;
                                    hideSortBy = true;
                                    hideRating = true;
                                    showOnlyDiscountProducts = false;
                                  } else {
                                    selectedOption = index;
                                  }

                                  if (selectedOption == 0) {
                                    hideRangeSlider = true;
                                    hideSortBy = true;
                                    hideRating = true;
                                    showOnlyDiscountProducts = false;
                                    if (hideCategoryOptions) {
                                      hideCategoryOptions = false;
                                    } else {
                                      hideCategoryOptions = true;
                                    }
                                  }

                                  if (selectedOption == 1) {
                                    hideCategoryOptions = true;
                                    hideSortBy = true;
                                    hideRating = true;
                                    showOnlyDiscountProducts = false;
                                    if (hideRangeSlider) {
                                      hideRangeSlider = false;
                                    } else {
                                      hideRangeSlider = true;
                                    }
                                  }

                                  if (selectedOption == 2) {
                                    hideCategoryOptions = true;
                                    hideRangeSlider = true;
                                    hideRating = true;
                                    showOnlyDiscountProducts = false;
                                    if (hideSortBy) {
                                      hideSortBy = false;
                                    } else {
                                      hideSortBy = true;
                                    }
                                  }

                                  if (selectedOption == 3) {
                                    hideCategoryOptions = true;
                                    hideRangeSlider = true;
                                    hideRating = true;
                                    showOnlyDiscountProducts = false;
                                    if (hideRating) {
                                      hideRating = false;
                                    } else {
                                      hideRating = true;
                                    }
                                  }

                                  if (selectedOption == 4) {
                                    hideCategoryOptions = true;
                                    hideRangeSlider = true;
                                    hideRating = true;
                                    hideSortBy = true;
                                    if (showOnlyDiscountProducts) {
                                      showOnlyDiscountProducts = false;
                                    } else {
                                      showOnlyDiscountProducts = true;
                                    }
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
                    GestureDetector(
                      onTap: () {
                        selectedOption = -1;
                        hideCategoryOptions = true;
                        hideRangeSlider = true;
                        hideSortBy = true;
                        hideRating = true;
                        showOnlyDiscountProducts = false;
                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: Localizations.localeOf(context)
                                          .languageCode ==
                                      'en'
                                  ? ScreenUtil().setWidth(8)
                                  : 0,
                              right: Localizations.localeOf(context)
                                          .languageCode ==
                                      'en'
                                  ? ScreenUtil().setWidth(0)
                                  : ScreenUtil().setWidth(8),
                            ),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  height: ScreenUtil().setHeight(460),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot
                                                  .data
                                                  .data
                                                  .productsCategories[index]
                                                  .name,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Provider.of<PageProvider>(
                                                        context,
                                                        listen: false)
                                                    .setPage(
                                                  SingleStoreCategoryPage
                                                      .pageIndex,
                                                  SingleStoreCategoryPage(
                                                    categoryID: snapshot
                                                        .data
                                                        .data
                                                        .productsCategories[
                                                            index]
                                                        .id,
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
                                              child: StoreCartItem(
                                                productsBean: snapshot
                                                    .data
                                                    .data
                                                    .productsCategories[index]
                                                    .products[index2],
                                              ),
                                            );
                                          },
                                          itemCount: snapshot
                                              .data
                                              .data
                                              .productsCategories[index]
                                              .products
                                              .length,
                                          scrollDirection: Axis.horizontal,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount:
                                  snapshot.data.data.productsCategories.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                          ),
                          hideCategoryOptions
                              ? SizedBox.shrink()
                              : categoryFilter(snapshot.data.data.categories),
                          hideRangeSlider
                              ? SizedBox.shrink()
                              : priceRangeSliderFilter(
                                  snapshot.data.data.categories,
                                  snapshot.data,
                                ),
                          hideSortBy
                              ? SizedBox.shrink()
                              : sortByFilter(snapshot.data.data.categories),
                          hideRating
                              ? SizedBox.shrink()
                              : ratingFilter(snapshot.data.data.categories),
                          !showOnlyDiscountProducts
                              ? SizedBox.shrink()
                              : showOnlyDiscountFilter(
                                  snapshot.data.data.categories),
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
                          physics: bouncingScrollPhysics,
                          controller: controller,
                          child: MultiSelectChip(
                            options,
                            selectedChoices: selectedCategories,
                            onSelectionChanged: (selectedItems) {
                              this.selectedCategories = selectedItems;
                              setState(() {});
                            },
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
                            hideRangeSlider = true;
                            hideSortBy = true;
                            showOnlyDiscountProducts = false;

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
                            hideRangeSlider = true;
                            hideSortBy = true;
                            showOnlyDiscountProducts = false;
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

  Widget priceRangeSliderFilter(
      List<CategoriesBean> categories, FilterResponse snapshot) {
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _lowerValue.toStringAsFixed(0) + ' ${AppUtils.currency}',
                                  style: TextStyle(
                                    color: mainColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  _upperValue.toStringAsFixed(0) + ' ${AppUtils.currency}',
                                  style: TextStyle(
                                    color: mainColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Theme(
                            data: ThemeData(
                              sliderTheme: SliderThemeData(
                                activeTickMarkColor: mainColor,
                                thumbColor: deepBlueColor,
                                trackHeight: 3,
                              ),
                            ),
                            child: frs.RangeSlider(
                              min: 1.0,
                              max:
                                  snapshot.data.filtration.max_price.toDouble(),
                              lowerValue: _lowerValue,
                              upperValue: _upperValue,
                              showValueIndicator: true,
                              valueIndicatorMaxDecimals: 1,
                              onChanged:
                                  (double newLowerValue, double newUpperValue) {
                                setState(() {
                                  _lowerValue = newLowerValue;
                                  _upperValue = newUpperValue;
                                });
                              },
                              onChangeEnd: (double newLowerValue,
                                  double newUpperValue) {},
                            ),
                          ),
                        ],
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
                            hideRangeSlider = true;
                            hideSortBy = true;
                            hideRating = true;
                            showOnlyDiscountProducts = false;

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
                            hideRangeSlider = true;
                            hideSortBy = true;
                            hideRating = true;
                            showOnlyDiscountProducts = false;
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

  Widget sortByFilter(List<CategoriesBean> categories) {
    List<String> sortBy = [
      AppLocalization.of(context).translate('date').toUpperCase(),
      AppLocalization.of(context).translate('price').toUpperCase(),
    ];

    List<String> orderBy = [
      AppLocalization.of(context).translate('asc').toUpperCase(),
      AppLocalization.of(context).translate('desc').toUpperCase(),
    ];
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(AppLocalization.of(context)
                                  .translate('sort_by')
                                  .toUpperCase()),
                              SizedBox(
                                height: ScreenUtil().setHeight(8),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  sortBy.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      selectedSortBy = index;
                                      setState(() {});
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: Material(
                                        elevation: 4,
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          width: ScreenUtil().setWidth(90),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: selectedSortBy == index
                                                ? mainColor.withOpacity(.2)
                                                : Color(0xfF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                selectedSortBy == index
                                                    ? Icon(
                                                        Icons.cancel,
                                                        color: deepBlueColor,
                                                        size: 18,
                                                      )
                                                    : SizedBox.shrink(),
                                                selectedSortBy == index
                                                    ? SizedBox(
                                                        width: 8,
                                                      )
                                                    : SizedBox.shrink(),
                                                Text(
                                                  sortBy[index],
                                                  style: TextStyle(
                                                    color:
                                                        selectedSortBy == index
                                                            ? mainColor
                                                            : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ).toList(),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(AppLocalization.of(context)
                                  .translate('order_by')
                                  .toUpperCase()),
                              SizedBox(
                                height: ScreenUtil().setHeight(8),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  orderBy.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      selectedOrderBy = index;
                                      setState(() {});
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: Material(
                                        elevation: 4,
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          width: ScreenUtil().setWidth(130),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: selectedOrderBy == index
                                                ? mainColor.withOpacity(.2)
                                                : Color(0xfF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                selectedOrderBy == index
                                                    ? Icon(
                                                        Icons.cancel,
                                                        color: deepBlueColor,
                                                        size: 18,
                                                      )
                                                    : SizedBox.shrink(),
                                                selectedOrderBy == index
                                                    ? SizedBox(
                                                        width: 8,
                                                      )
                                                    : SizedBox.shrink(),
                                                Text(
                                                  orderBy[index],
                                                  style: TextStyle(
                                                    color:
                                                        selectedOrderBy == index
                                                            ? mainColor
                                                            : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ).toList(),
                              ),
                            ],
                          ),
                        ],
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
                            hideRangeSlider = true;
                            hideSortBy = true;
                            hideRating = true;
                            showOnlyDiscountProducts = false;

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
                            hideRangeSlider = true;
                            hideSortBy = true;
                            hideRating = true;
                            showOnlyDiscountProducts = false;
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

  Widget ratingFilter(List<CategoriesBean> categories) {
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
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            5,
                            (index) => GestureDetector(
                              onTap: () {
                                selectedRate = index;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(12),
                                  vertical: ScreenUtil().setHeight(5),
                                ),
                                decoration: BoxDecoration(
                                  color: selectedRate == index
                                      ? mainColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.grey[300],
                                    width: .8,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: selectedRate == index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: goldColor,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ).toList(),
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
                            hideRangeSlider = true;
                            hideSortBy = true;
                            hideRating = true;
                            showOnlyDiscountProducts = false;

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
                            hideRangeSlider = true;
                            hideSortBy = true;
                            hideRating = true;
                            showOnlyDiscountProducts = false;
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

  Widget showOnlyDiscountFilter(List<CategoriesBean> categories) {
    List<String> options = [
      '${AppLocalization.of(context).translate('no_').toUpperCase()}',
      '${AppLocalization.of(context).translate('yes_').toUpperCase()}',
    ];
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalization.of(context).translate(
                                'show_only_products_that_have_a_discount'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(8),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              options.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  selectedShowOnlyProductsThatHasDiscount =
                                      index;
                                  setState(() {});
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 12),
                                  child: Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      width: ScreenUtil().setWidth(85),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color:
                                            selectedShowOnlyProductsThatHasDiscount ==
                                                    index
                                                ? mainColor.withOpacity(.2)
                                                : Color(0xfF5F5F5),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            selectedShowOnlyProductsThatHasDiscount ==
                                                    index
                                                ? Icon(
                                                    Icons.cancel,
                                                    color: deepBlueColor,
                                                    size: 18,
                                                  )
                                                : SizedBox.shrink(),
                                            selectedShowOnlyProductsThatHasDiscount ==
                                                    index
                                                ? SizedBox(
                                                    width: 8,
                                                  )
                                                : SizedBox.shrink(),
                                            Text(
                                              options[index],
                                              style: TextStyle(
                                                color:
                                                    selectedShowOnlyProductsThatHasDiscount ==
                                                            index
                                                        ? mainColor
                                                        : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ).toList(),
                          ),
                        ],
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
                            hideRangeSlider = true;
                            hideSortBy = true;
                            hideRating = true;
                            showOnlyDiscountProducts = false;

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
                            hideRangeSlider = true;
                            hideSortBy = true;
                            hideRating = true;
                            showOnlyDiscountProducts = false;
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
    String _categories = '';
    // get selected categories ids
    categories.forEach(
      (element) {
        for (int i = 0; i < selectedCategories.length; i++) {
          if (selectedCategories[i] == element.name) {
            if (i == selectedCategories.length - 1) {
              _categories = _categories + '${element.id}';
            } else {
              _categories = _categories + '${element.id},';
            }
          }
        }
      },
    );

    FilterRequest filterRequest = FilterRequest(
      maxPrice: _upperValue.toInt(),
      minPrice: _lowerValue.toInt(),
      rates: selectedRate == -1 ? null : selectedRate + 1,
      categories: _categories.isEmpty ? null : _categories,
      sortby: selectedSortBy == null || selectedSortBy == -1
          ? null
          : selectedSortBy == 0
              ? 'asc'
              : 'desc',
      order: selectedOrderBy == null || selectedOrderBy == -1
          ? null
          : selectedOrderBy == 0
              ? 'date'
              : 'price',
      discount: selectedShowOnlyProductsThatHasDiscount == -1 ? null : selectedShowOnlyProductsThatHasDiscount,
    );

    storeBloc.myProductFilterSubject.value = null;
    storeBloc.filter(filterRequest);
  }

  void clearFilter() {
    selectedOrderBy = -1;
    selectedSortBy = -1;
    _lowerValue = 1.0;
    _upperValue = 999.0;
    selectedRate = -1;
    selectedShowOnlyProductsThatHasDiscount = 0;
    gotMaxPriceForFirstTime = false;
    selectedCategories.clear();
    setState(() {});

    storeBloc.filter(FilterRequest(
      discount: null,
      order: null,
      rates: null,
      minPrice: null,
      maxPrice: null,
      categories: null,
      sortby: null,
    ));
  }
}
