import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantLandinResponse.dart';
import 'package:phinex/Bles/bloc/restaurant/RestaurantBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/services_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_multi_chips_selection.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'restuarnt_cart_item.dart';

class RestaurantPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  ScrollController controller = ScrollController();

  List<String> filterOptions;

  List<String> selectedCategories = [];

  int selectedOption = -1;

  bool hideCategoryOptions = true;
  bool makeSearch = false;

  double filterHeightPercent = .45;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    restaurantBloc.clear();
    restaurantBloc.getLanding();
  }

  @override
  Widget build(BuildContext context) {
    filterOptions = [
      AppLocalization.of(context).translate('category'),
    ];

    return Scaffold(
      appBar: makeSearch
          ? null
          : myAppBar(
              AppLocalization.of(context).translate('restaurant'),
              context,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    makeSearch = true;
                    setState(() {});
                  },
                ),
              ],
              onBackBtnClicked: () {
                Provider.of<PageProvider>(context, listen: false)
                    .setPage(ServicesPage.pageIndex, ServicesPage());
              },
            ),
      backgroundColor: scaffoldBackgroundColor,
      body: WillPopScope(
        child: StreamBuilder<RestaurantLandinResponse>(
          stream: restaurantBloc.landing.stream,
          builder: (context, snapshot) {
            if (!restaurantBloc.loading.value) {
              return SingleChildScrollView(
                physics: bouncingScrollPhysics,
                child: Column(
                  children: [
                    makeSearch
                        ? SizedBox(height: MediaQuery.of(context).padding.top)
                        : null,
                    makeSearch
                        ? null
                        : Material(
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
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                    makeSearch
                        ? Material(
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
                                        if (input.isEmpty) {
                                          restaurantBloc.clear();
                                          restaurantBloc.getLanding();
                                          return;
                                        }

                                        restaurantBloc.getSearch(input);
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
                                                  restaurantBloc.clear();
                                                  restaurantBloc.getLanding();

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
                                          horizontal: ScreenUtil().setWidth(10),
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
                                      restaurantBloc.clear();
                                      restaurantBloc.getLanding();
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
                          )
                        : null,
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
                          GridView.builder(
                            itemBuilder: (context, index) {
                              return RestuarntCartItem(
                                currentItem:
                                    snapshot.data.data.restaurants[index],
                              );
                            },
                            itemCount: snapshot.data.data.restaurants.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                              crossAxisCount: 2,
                              height: ScreenUtil().setHeight(360),
                            ),
                          ),
                          hideCategoryOptions
                              ? SizedBox.shrink()
                              : categoryFilter(
                                  snapshot.data.data.categories,
                                ),
                        ],
                      ),
                    )
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
          Provider.of<PageProvider>(context, listen: false)
              .setPage(ServicesPage.pageIndex, ServicesPage());
          return false;
        },
      ),
    );
  }

  Widget categoryFilter(List<CategoriesBean> categories) {
    List<String> options = [];
    categories.forEach(
      (element) {
        options.add(element.name);
      },
    );
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
    String _categories = '';

    // get selected categories ids
    categories.forEach(
      (element) {
        for (int i = 0; i < selectedCategories.length; i++) {
          if (selectedCategories[i] == element.name) {
            _categories = _categories + '${element.id},';
          }
        }
      },
    );

    SearchRequest filterRequest =
        SearchRequest(skip: 0, take: 10, search: _categories);

    // restaurantBloc.landing.value = null;
    restaurantBloc.getByCat(filterRequest);
  }

  void clearFilter() {
    selectedCategories.clear();
    setState(() {});

    restaurantBloc.landing.value = null;
    restaurantBloc.getLanding();
  }
}
