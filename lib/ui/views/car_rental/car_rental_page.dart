import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalFilterationRequest.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'package:phinex/Bles/Model/responses/car_rental/CarRentalFilterResponse.dart';
import 'package:phinex/Bles/bloc/car_rental/CarRentalBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;
import 'package:phinex/ui/views/home/services_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_multi_chips_selection.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'add_car_page.dart';
import 'car_cart_item.dart';

class CarRentalPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _CarRentalPageState createState() => _CarRentalPageState();
}

class _CarRentalPageState extends State<CarRentalPage> {
  double _lowerValue = 1.0;
  double _upperValue = 1000.0;
  double filterHeightPercent = .45;

  ScrollController controller = ScrollController();

  List<String> filterOptions;

  List<String> selectedCategories = [];
  List<String> selectedModels = [];

  int selectedOption = -1;

  int selectedPeriod;

  bool hideCategoryOptions = true;
  bool hideRangeSlider = true;
  bool hideModel = true;
  bool hideRentalPeriod = true;

  bool gotMaxPriceForFirstTime = false;
  bool makeSearch = false;

  TextEditingController searchController = TextEditingController();
  int skip = 0;
  int take = 50;

  @override
  void initState() {
    super.initState();
    carRentalBloc.clear();
    carRentalBloc.getFilter(
      CarRentalFilterationRequest(
        skip: skip,
        take: take,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (carRentalBloc.filter.value == null ||
        carRentalBloc.filter.value.data == null ||
        carRentalBloc.filter.value.data.models == null ||
        carRentalBloc.filter.value.data.models.isEmpty) {
      filterOptions = [
        AppLocalization.of(context).translate('category'),
        AppLocalization.of(context).translate('price_range'),
        AppLocalization.of(context).translate('rental_period'),
      ];
    } else {
      filterOptions = [
        AppLocalization.of(context).translate('category'),
        AppLocalization.of(context).translate('model'),
        AppLocalization.of(context).translate('price_range'),
        AppLocalization.of(context).translate('rental_period'),
      ];
    }

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: makeSearch
          ? null
          : myAppBar(
              AppLocalization.of(context).translate('car_rental'),
              context,
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    makeSearch = true;
                    setState(() {});
                  },
                  color: Colors.black,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (AppUtils.userData == null) {
                      AppUtils.showNeedToRegisterDialog(context);
                      return;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AddCarPage(),
                      ),
                    );
                  },
                  color: Colors.black,
                ),
              ],
              onBackBtnClicked: () {
                Provider.of<PageProvider>(context, listen: false)
                    .setPage(ServicesPage.pageIndex, ServicesPage());
              },
            ),
      body: WillPopScope(
        child: StreamBuilder<CarRentalFilterResponse>(
          stream: carRentalBloc.filter.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              if (!gotMaxPriceForFirstTime) {
                _upperValue = PeriodsBean.max;
                _lowerValue = PeriodsBean.min ?? 1;
                gotMaxPriceForFirstTime = true;
              }
              return SingleChildScrollView(
                physics: bouncingScrollPhysics,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    makeSearch
                        ? SizedBox(height: MediaQuery.of(context).padding.top)
                        : null,
                    makeSearch
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Material(
                              elevation: 8,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(4),
                                  vertical: ScreenUtil().setHeight(8),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: ScreenUtil().setWidth(10),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: searchController,
                                        onChanged: (String input) {
                                          if (input.length < 1) {
                                            carRentalBloc.getFilter(
                                              CarRentalFilterationRequest(),
                                            );
                                            return;
                                          }
                                          carRentalBloc.getSearch(
                                            SearchRequest(
                                              take: take,
                                              skip: skip,
                                              search: input,
                                            ),
                                          );
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Colors.grey[300],
                                          ),
                                          suffixIcon: searchController
                                                  .text.isNotEmpty
                                              ? GestureDetector(
                                                  onTap: () {
                                                    carRentalBloc.getFilter(
                                                      CarRentalFilterationRequest(),
                                                    );
                                                    searchController.clear();
                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.cancel_rounded,
                                                    color: deepBlueColor,
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal:
                                                ScreenUtil().setWidth(10),
                                            vertical: ScreenUtil().setHeight(0),
                                          ),
                                          hintText: AppLocalization.of(context)
                                              .translate('search'),
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: .8,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: .8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        makeSearch = false;
                                        searchController.clear();
                                        carRentalBloc.getFilter(
                                          CarRentalFilterationRequest(),
                                        );
                                        setState(() {});
                                      },
                                      child: Text(
                                        AppLocalization.of(context)
                                            .translate('cancel'),
                                        style: TextStyle(
                                          fontSize: 17,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : null,
                    !makeSearch
                        ? Material(
                            elevation: 5,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(15),
                                top: ScreenUtil().setHeight(10),
                                bottom: ScreenUtil().setHeight(10),
                              ),
                              height: ScreenUtil().setHeight(65),
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
                                          hideModel = true;
                                          hideRentalPeriod = true;
                                        } else {
                                          selectedOption = index;
                                        }

                                        setState(() {});

                                        if (carRentalBloc.filter.value == null || carRentalBloc.filter.value.data == null || carRentalBloc.filter.value.data.models == null || carRentalBloc.filter.value.data.models.isEmpty) {
                                          if (selectedOption == 0) {
                                            hideRangeSlider = true;
                                            hideModel = true;
                                            hideRentalPeriod = true;
                                            if (hideCategoryOptions) {
                                              hideCategoryOptions = false;
                                            } else {
                                              hideCategoryOptions = true;
                                            }
                                          }

                                          if (selectedOption == 1) {
                                            hideCategoryOptions = true;
                                            hideModel = true;
                                            hideRentalPeriod = true;
                                            if (hideRangeSlider) {
                                              hideRangeSlider = false;
                                            } else {
                                              hideRangeSlider = true;
                                            }
                                          }

                                          if (selectedOption == 2) {
                                            hideCategoryOptions = true;
                                            hideModel = true;
                                            hideRangeSlider = true;
                                            if (hideRentalPeriod) {
                                              hideRentalPeriod = false;
                                            } else {
                                              hideRentalPeriod = true;
                                            }
                                          }

                                        } else {
                                          if (selectedOption == 0) {
                                            hideRangeSlider = true;
                                            hideModel = true;
                                            hideRentalPeriod = true;
                                            if (hideCategoryOptions) {
                                              hideCategoryOptions = false;
                                            } else {
                                              hideCategoryOptions = true;
                                            }
                                          }

                                          if (selectedOption == 1) {
                                            hideCategoryOptions = true;
                                            hideRangeSlider = true;
                                            hideRentalPeriod = true;
                                            if (hideModel) {
                                              hideModel = false;
                                            } else {
                                              hideModel = true;
                                            }
                                          }

                                          if (selectedOption == 2) {
                                            hideCategoryOptions = true;
                                            hideModel = true;
                                            hideRentalPeriod = true;
                                            if (hideRangeSlider) {
                                              hideRangeSlider = false;
                                            } else {
                                              hideRangeSlider = true;
                                            }
                                          }

                                          if (selectedOption == 3) {
                                            hideCategoryOptions = true;
                                            hideModel = true;
                                            hideRangeSlider = true;
                                            if (hideRentalPeriod) {
                                              hideRentalPeriod = false;
                                            } else {
                                              hideRentalPeriod = true;
                                            }
                                          }

                                          setState(() {});
                                        }
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: selectedOption == index ? mainColor.withOpacity(.1) : Colors.white,
                                          border: Border.all(color: selectedOption == index ? mainColor : Colors.grey[300],),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(filterOptions[index]),
                                            Icon(selectedOption == index ? Icons.arrow_drop_up : Icons.arrow_drop_down,),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          )
                        : null,
                    !makeSearch
                        ? Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              translate(context, 'popular_cars'),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : null,
                    GestureDetector(
                      onTap: () {
                        selectedOption = -1;
                        hideCategoryOptions = true;
                        hideRangeSlider = true;
                        hideModel = true;
                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: Localizations.localeOf(context).languageCode == 'en'
                                  ? ScreenUtil().setWidth(8)
                                  : 0,
                              right: Localizations.localeOf(context).languageCode == 'en'
                                  ? ScreenUtil().setWidth(0)
                                  : ScreenUtil().setWidth(8),
                            ),
                            child: GridView.builder(
                              itemBuilder: (context, index) {
                                return CarCartItem(
                                  currentCar: snapshot.data.data.cars[index],
                                );
                              },
                              itemCount: snapshot.data.data.cars.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                height: ScreenUtil().setHeight(350),
                                crossAxisCount: 2,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                              ),
                            ),
                          ),
                          hideCategoryOptions
                              ? SizedBox.shrink()
                              : categoryFilter(
                                  snapshot.data.data.categories,
                                  snapshot.data.data.models,
                                  snapshot.data.data.periods,
                                ),
                          hideModel
                              ? SizedBox.shrink()
                              : modelFilter(
                                  snapshot.data.data.categories,
                                  snapshot.data.data.models,
                                  snapshot.data.data.periods,
                                ),
                          hideRentalPeriod
                              ? SizedBox.shrink()
                              : periodFilter(
                                  snapshot.data.data.categories,
                                  snapshot.data.data.models,
                                  snapshot.data.data.periods,
                                ),
                          hideRangeSlider
                              ? SizedBox.shrink()
                              : priceRangeSliderFilter(
                                  snapshot.data.data.categories,
                                  snapshot.data.data.models,
                                  snapshot.data.data.periods,
                                )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                  ].where((element) => element != null).toList(),
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
          if (makeSearch) {
            makeSearch = false;
            carRentalBloc.getFilter(
              CarRentalFilterationRequest(),
            );
            setState(() {});
          } else {
            Provider.of<PageProvider>(context, listen: false)
                .setPage(ServicesPage.pageIndex, ServicesPage());
          }

          return false;
        },
      ),
    );
  }

  Widget categoryFilter(List<CategoriesBean> categories,
      List<ModelsBean> models, List<PeriodsBean> periods) {
    List<String> options = [];
    categories.forEach((element) {
      options.add(element.modelName);
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
                          controller: controller,
                          physics: bouncingScrollPhysics,
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
                            hideModel = true;
                            hideRangeSlider = true;

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
                            hideModel = true;
                            hideRangeSlider = true;

                            sendFilterRequest(categories, models, periods);
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

  Widget modelFilter(List<CategoriesBean> categories, List<ModelsBean> models,
      List<PeriodsBean> periods) {
    List<String> options = [];

    models.forEach((element) {
      options.add(element.modelName);
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
                          controller: controller,
                          physics: bouncingScrollPhysics,
                          child: MultiSelectChip(
                            options,
                            selectedChoices: selectedModels,
                            onSelectionChanged: (selectedItems) {
                              this.selectedModels = selectedItems;
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
                            hideModel = true;
                            hideRangeSlider = true;
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
                            hideModel = true;
                            hideRangeSlider = true;

                            sendFilterRequest(categories, models, periods);
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

  Widget periodFilter(List<CategoriesBean> categories, List<ModelsBean> models,
      List<PeriodsBean> periods) {
    List<String> options = [];
    periods.forEach((element) {
      options.add(element.key);
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
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
                          physics: bouncingScrollPhysics,
                          child: Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            children: List.generate(
                              periods.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  selectedPeriod = index;
                                  setState(() {});
                                },
                                child: Container(
                                  width: ScreenUtil().setWidth(80),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: selectedPeriod == index
                                            ? mainColor.withOpacity(.2)
                                            : Colors.grey[200],
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    color: selectedPeriod == index
                                        ? mainColor.withOpacity(.2)
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        selectedPeriod == index
                                            ? Icon(
                                                Icons.cancel,
                                                color: deepBlueColor,
                                                size: 18,
                                              )
                                            : SizedBox.shrink(),
                                        selectedPeriod == index
                                            ? SizedBox(
                                                width: 8,
                                              )
                                            : SizedBox.shrink(),
                                        Text(
                                          periods[index].key,
                                          style: TextStyle(
                                            color: selectedPeriod == index
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
                            hideModel = true;
                            hideRangeSlider = true;
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
                            hideModel = true;
                            hideRangeSlider = true;
                            hideRentalPeriod = true;

                            sendFilterRequest(categories, models, periods);
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

  Widget priceRangeSliderFilter(List<CategoriesBean> categories,
      List<ModelsBean> models, List<PeriodsBean> periods) {
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
                                  _lowerValue.toStringAsFixed(0) +
                                      ' ${AppUtils.currency}',
                                  style: TextStyle(
                                    color: mainColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  _upperValue.toStringAsFixed(0) +
                                      ' ${AppUtils.currency}',
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
                              min: PeriodsBean.min ?? 1,
                              max: PeriodsBean.max,
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
                            hideRentalPeriod = true;
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
                            hideRentalPeriod = true;
                            sendFilterRequest(categories, models, periods);
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

  void sendFilterRequest(List<CategoriesBean> categories,
      List<ModelsBean> models, List<PeriodsBean> periods) async {
    String _categories = '';
    String _models = '';

    // get selected categories ids
    categories.forEach(
      (element) {
        for (int i = 0; i < selectedCategories.length; i++) {
          if (selectedCategories[i] == element.modelName) {
            if (i == selectedCategories.length - 1) {
              _categories = _categories + '${element.id}';
            } else {
              _categories = _categories + '${element.id},';
            }
          }
        }
      },
    );

    // get selected models ids
    models.forEach((element) {
      for (int i = 0; i < selectedModels.length; i++) {
        if (selectedModels[i] == element.modelName) {
          _models = _models + '${element.id},';
        }
      }
    });

    // get selected period if found
    PeriodsBean period;
    if (selectedPeriod != null) {
      period = periods[selectedPeriod];
    }

    print('>>>> $_categories');
    print('>>>> $_models');

    CarRentalFilterationRequest filterRequest = CarRentalFilterationRequest(
      categories: _categories.isEmpty ? null : _categories,
      model_ids: _models.isEmpty ? null : _models,
      rent_period: period?.key,
      take: take,
      skip: skip,
      max_price: _upperValue.toString(),
      min_price: _lowerValue.toString(),
    );

    print(filterRequest.tojson());

    carRentalBloc.filter.value = null;
    await carRentalBloc.getFilter(filterRequest);
    setState(() {});
  }

  void clearFilter() {
    _lowerValue = 1.0;
    _upperValue = 999.0;
    gotMaxPriceForFirstTime = false;
    selectedCategories.clear();
    selectedModels.clear();
    setState(() {});

    carRentalBloc.filter.value = null;
    carRentalBloc.getFilter(CarRentalFilterationRequest());
  }
}
