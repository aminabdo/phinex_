import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/store/FilterRequest.dart';
import 'package:phinex/Bles/Model/responses/store/filter/FilterByProductsResponse.dart';
import 'package:phinex/Bles/Model/responses/store/filter/FilterResponse.dart';
import 'package:phinex/Bles/bloc/store/StoreBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/store/store_card_item.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'store_page.dart';

class SingleStoreCategoryPage extends StatefulWidget {
  static final int pageIndex = 0;
  final int categoryID;

  const SingleStoreCategoryPage({Key key, @required this.categoryID})
      : super(key: key);

  @override
  _SingleStoreCategoryPageState createState() =>
      _SingleStoreCategoryPageState();
}

class _SingleStoreCategoryPageState extends State<SingleStoreCategoryPage> {
  double _lowerValue = 1.0;
  double _upperValue = 10000.0;

  List<String> filterOptions;
  bool gotMaxPriceForFirstTime = false;

  int selectedSortBy = -1;
  int selectedOrderBy = -1;
  int selectedShowOnlyProductsThatHasDiscount; // 0 => NO  || 1 => YES
  int selectedOption = -1;
  int selectedRate = -1;
  int selectedCategory;

  ScrollController categoryController = ScrollController();

  bool hideCategoryOptions = true;
  bool hideRangeSlider = true;
  bool hideSortBy = true;
  bool hideRating = true;
  bool showOnlyDiscountProducts = false;

  double filterHeightPercent = .45;

  ScrollController _scrollController = ScrollController();
  int skip = 0;
  int take = 10;

  @override
  void initState() {
    super.initState();

    storeBloc.clear();
    selectedCategory = widget.categoryID;
    storeBloc.getProductsByCat(
      FilterRequest(
        categories: widget.categoryID.toString(),
        skip: skip,
        take: take,
      ),
    );
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
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(StorePage.pageIndex, StorePage());
        },
      ),
      body: StreamBuilder<FilterByProductsResponse>(
        stream: storeBloc.ProductsByCatSubject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (!gotMaxPriceForFirstTime) {
              _upperValue = snapshot.data.data.filtration.max_price.toDouble();
              gotMaxPriceForFirstTime = true;
            }
            _scrollController
              ..addListener(
                () {
                  if (_scrollController.position.pixels ==
                      _scrollController.position.maxScrollExtent) {
                    skip += 10;
                    take = 10;
                    storeBloc.getProductsByCat(
                      FilterRequest(
                        categories: widget.categoryID.toString(),
                        skip: skip,
                        take: take,
                      ),
                    );
                  }
                },
              );
            return SingleChildScrollView(
              physics: bouncingScrollPhysics,
              controller: _scrollController,
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
                      hideRangeSlider = true;
                      hideSortBy = true;
                      hideRating = true;
                      showOnlyDiscountProducts = false;
                      setState(() {});
                    },
                    child: Stack(
                      children: [
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            height: ScreenUtil().setHeight(420),
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 4,
                            crossAxisCount: 2,
                          ),
                          itemCount: snapshot.data.data.products.length,
                          itemBuilder: (context, index) {
                            return StoreCartItem(
                              productsBean: snapshot.data.data.products[index],
                            );
                          },
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
    );
  }

  Widget categoryFilter(List<CategoriesBean> categories) {
    List<String> options = [];
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
                        controller: categoryController,
                        isAlwaysShown: true,
                        thickness: 5,
                        radius: Radius.circular(80),
                        child: SingleChildScrollView(
                          controller: categoryController,
                          physics: bouncingScrollPhysics,
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
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 12),
                                  child: Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      width: ScreenUtil().setWidth(
                                          categories[index].name.length < 25
                                              ? 155
                                              : categories[index].name.length > 25 &&
                                                      categories[index].name.length <
                                                          35
                                                  ? 250
                                                  : 300),
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
                              ),
                            ).toList(),
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

  Widget priceRangeSliderFilter(List<CategoriesBean> categories, FilterByProductsResponse snapshot) {
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
                              max: snapshot.data.filtration.max_price.toDouble(),
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
                                      width: ScreenUtil().setWidth(70),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 6),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: selectedSortBy == index
                                                ? mainColor.withOpacity(.2)
                                                : Colors.grey[200],
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                        color: selectedSortBy == index
                                            ? mainColor.withOpacity(.2)
                                            : Colors.grey[300],
                                        borderRadius: BorderRadius.circular(50),
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
                                                color: selectedSortBy == index
                                                    ? mainColor
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
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
                                      width: ScreenUtil().setWidth(110),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 6),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: selectedOrderBy == index
                                                ? mainColor.withOpacity(.2)
                                                : Colors.grey[200],
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                        color: selectedOrderBy == index
                                            ? mainColor.withOpacity(.2)
                                            : Colors.grey[300],
                                        borderRadius: BorderRadius.circular(50),
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
                                                color: selectedOrderBy == index
                                                    ? mainColor
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
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
                                  width: ScreenUtil().setWidth(85),
                                  margin: EdgeInsets.symmetric(horizontal: 6),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            selectedShowOnlyProductsThatHasDiscount ==
                                                    index
                                                ? mainColor.withOpacity(.2)
                                                : Colors.grey[200],
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    color:
                                        selectedShowOnlyProductsThatHasDiscount ==
                                                index
                                            ? mainColor.withOpacity(.2)
                                            : Colors.grey[300],
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

    var _category = categories[selectedCategory];

    FilterRequest filterRequest = FilterRequest(
      maxPrice: _upperValue.toInt(),
      minPrice: _lowerValue.toInt(),
      rates: selectedRate == -1 ? null : selectedRate + 1,
      categories: _category.id.toString(),
      sortby: selectedSortBy == null || selectedSortBy == -1 ? null : selectedSortBy == 0 ? 'asc' : 'desc',
      order: selectedOrderBy == null || selectedOrderBy == -1 ? null : selectedOrderBy == 0 ? 'date' : 'price',
      discount: selectedShowOnlyProductsThatHasDiscount == -1 ? null : selectedShowOnlyProductsThatHasDiscount,
      skip: skip,
      take: take,
    );

    storeBloc.ProductsByCatSubject.value = null;
    storeBloc.getProductsByCat(filterRequest);
  }

  void clearFilter() {
    selectedOrderBy = -1;
    selectedSortBy = -1;
    _lowerValue = 1.0;
    _upperValue = 999.0;
    selectedRate = -1;
    gotMaxPriceForFirstTime = false;
    selectedShowOnlyProductsThatHasDiscount = -1;
    selectedCategory = widget.categoryID;
    setState(() {});

    storeBloc.getProductsByCat(
      FilterRequest(
        categories: widget.categoryID.toString(),
        skip: skip,
        take: take,
      ),
    );
  }
}
