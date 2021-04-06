import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/real_state/RealStateFilterRequest.dart';
import 'package:phinex/Bles/Model/responses/real_state/RealStateFilterResponse.dart';
import 'package:phinex/Bles/bloc/real_state/RealState.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/services_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_multi_chips_selection.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'real_state_cart_item.dart';
import 'second_filter_option.dart';

class RealStatesPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _RealStatesPageState createState() => _RealStatesPageState();
}

class _RealStatesPageState extends State<RealStatesPage> {
  double filterHeightPercent = .45;

  ScrollController controller = ScrollController();

  List<String> filterOptions;
  List<String> selectedCategories = [];

  int selectedOption = -1;
  int selectedType = -1;
  int selectedFurnishing = -1;
  int selectedFinishing = -1;

  bool hideCategoryOptions = true;
  bool hideTypeOption = true;
  bool hideFurnishing = true;
  bool hideFinishing = true;

  bool hasGarden = false;
  bool hasMaidService = false;
  bool hasSecurity = false;
  bool hasParking = false;

  bool makeSearch = false;
  TextEditingController searchController = TextEditingController();

  int skip = 0;
  int take = 15;

  @override
  void initState() {
    super.initState();

    realStateBloc.clear();
    realStateBloc.getFilter(RealStateFilterRequest(
      skip: skip.toString(),
      take: take.toString(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    filterOptions = [
      AppLocalization.of(context).translate('category'),
      AppLocalization.of(context).translate('type'),
      AppLocalization.of(context).translate('finishing'),
      AppLocalization.of(context).translate("furnishing"),
      AppLocalization.of(context).translate("garden"),
      AppLocalization.of(context).translate("maid_service"),
      AppLocalization.of(context).translate("security"),
      AppLocalization.of(context).translate("parking"),
    ];
    return Scaffold(
      appBar: makeSearch
          ? null
          : myAppBar(
              AppLocalization.of(context).translate('real_state'),
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
              ],
              onBackBtnClicked: () {
                Provider.of<PageProvider>(context, listen: false).setPage(ServicesPage.pageIndex, ServicesPage());
              },
            ),
      body: WillPopScope(
        child: StreamBuilder<RealStateFilterResponse>(
            stream: realStateBloc.filter.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                print(snapshot.data.data);
                return SingleChildScrollView(
                  physics: bouncingScrollPhysics,
                  child: Column(
                    children: [
                      makeSearch
                          ? SizedBox(height: MediaQuery.of(context).padding.top)
                          : null,
                      makeSearch
                          ? null
                          : Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Material(
                                elevation: 5,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(15),
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
                                        if (index >= 0 && index <= 3) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (selectedOption == index) {
                                                selectedOption = -1;
                                                hideCategoryOptions = true;
                                                hideTypeOption = true;
                                                hideFurnishing = true;
                                                hideFinishing = true;
                                              } else {
                                                selectedOption = index;
                                              }

                                              if (selectedOption == 0) {
                                                hideCategoryOptions = true;
                                                hideTypeOption = true;
                                                hideFurnishing = true;
                                                hideFinishing = true;
                                                if (hideCategoryOptions) {
                                                  hideCategoryOptions = false;
                                                } else {
                                                  hideCategoryOptions = true;
                                                }
                                              }

                                              if (selectedOption == 1) {
                                                hideCategoryOptions = true;
                                                hideTypeOption = true;
                                                hideFurnishing = true;
                                                hideFinishing = true;
                                                if (hideTypeOption) {
                                                  hideTypeOption = false;
                                                } else {
                                                  hideTypeOption = true;
                                                }
                                              }

                                              if (selectedOption == 2) {
                                                hideCategoryOptions = true;
                                                hideTypeOption = true;
                                                hideFurnishing = true;
                                                if (hideFinishing) {
                                                  hideFinishing = false;
                                                } else {
                                                  hideFinishing = true;
                                                }
                                              }

                                              if (selectedOption == 3) {
                                                hideCategoryOptions = true;
                                                hideTypeOption = true;
                                                hideFinishing = true;
                                                if (hideFurnishing) {
                                                  hideFurnishing = false;
                                                } else {
                                                  hideFurnishing = true;
                                                }
                                              }

                                              setState(() {});
                                            },
                                            child: AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 300),
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
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              if (index == 4) {
                                                hasGarden = !hasGarden;
                                              }

                                              if (index == 5) {
                                                hasMaidService =
                                                    !hasMaidService;
                                              }

                                              if (index == 6) {
                                                hasSecurity = !hasSecurity;
                                              }

                                              if (index == 7) {
                                                hasParking = !hasParking;
                                              }

                                              selectedOption = -1;
                                              hideCategoryOptions = true;
                                              hideTypeOption = true;
                                              hideFurnishing = true;
                                              hideFinishing = true;

                                              setState(() {});

                                              sendFilterRequest(snapshot.data.data.categories);

                                            },
                                            child: SecondFilterOption(
                                              title: filterOptions[index],
                                              isSelected: index == 4 ? hasGarden : index == 5 ? hasMaidService : index == 6 ? hasSecurity : index == 7 ? hasParking : false,
                                            ),
                                          );
                                        }
                                      },
                                    ).toList(),
                                  ),
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
                                            realStateBloc.getFilter(
                                              RealStateFilterRequest(
                                                skip: skip.toString(), take: take.toString(),
                                              ),
                                            );
                                            return;
                                          }

                                          realStateBloc.getSearch(input);
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Colors.grey[300],
                                          ),
                                          suffixIcon:
                                              searchController.text.isNotEmpty
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        realStateBloc.getFilter(
                                                          RealStateFilterRequest(
                                                            skip: skip.toString(), take: take.toString(),
                                                          ),
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
                                        realStateBloc.getFilter(
                                          RealStateFilterRequest(
                                            skip: skip.toString(), take: take.toString(),
                                          ),
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
                            )
                          : null,
                      GestureDetector(
                        onTap: () {
                          hideCategoryOptions = true;
                          hideTypeOption = true;
                          hideFurnishing = true;
                          hideFinishing = true;
                          selectedOption = -1;
                          setState(() {});
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                  height: ScreenUtil().setHeight(345),
                                  crossAxisCount:
                                      MediaQuery.of(context).size.width <= 450
                                          ? 2
                                          : 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                                itemCount: snapshot.data.data.realestates.length,
                                itemBuilder: (context, index) {
                                  return RealStateCartItem(
                                    currentItem:
                                        snapshot.data.data.realestates[index],
                                  );
                                },
                              ),
                            ),
                            hideTypeOption
                                ? null
                                : typeFilter(snapshot.data.data.categories),
                            hideFurnishing
                                ? null
                                : furnishingFilter(
                                    snapshot.data.data.categories),
                            hideFinishing
                                ? null
                                : finishingFilter(
                                    snapshot.data.data.categories),
                            hideCategoryOptions
                                ? null
                                : categoryFilter(snapshot.data.data.categories),
                          ].where((element) => element != null).toList(),
                        ),
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
          Provider.of<PageProvider>(context, listen: false).setPage(ServicesPage.pageIndex, ServicesPage());
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
                            hideTypeOption = true;
                            hideFurnishing = true;
                            hideFinishing = true;

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
                            hideTypeOption = true;
                            hideFurnishing = true;
                            hideFinishing = true;
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

  Widget typeFilter(List<CategoriesBean> categories) {
    List<String> options = ['Rental', "Sale"];
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
                      child: SingleChildScrollView(
                        physics: bouncingScrollPhysics,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            children: List.generate(
                              options.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  selectedType = index;
                                  setState(() {});
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(50),
                                  elevation: 4,
                                  child: Container(
                                    width: ScreenUtil().setWidth(
                                      100,
                                    ),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: selectedType == index
                                          ? mainColor.withOpacity(.2)
                                          : Color(0xfF5F5F5),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          selectedType == index
                                              ? Icon(
                                                  Icons.cancel,
                                                  color: deepBlueColor,
                                                  size: 18,
                                                )
                                              : SizedBox.shrink(),
                                          selectedType == index
                                              ? SizedBox(
                                                  width: 8,
                                                )
                                              : SizedBox.shrink(),
                                          Text(
                                            options[index],
                                            style: TextStyle(
                                              color: selectedType == index
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
                            hideTypeOption = true;
                            hideFurnishing = true;
                            hideFinishing = true;
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
                            hideTypeOption = true;
                            hideFurnishing = true;
                            hideFinishing = true;

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

  Widget furnishingFilter(List<CategoriesBean> categories) {
    List<String> options = ['Unfurnished', "Furnished"];
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
                      child: SingleChildScrollView(
                        physics: bouncingScrollPhysics,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            children: List.generate(
                              options.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  selectedFurnishing = index;
                                  setState(() {});
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(50),
                                  elevation: 4,
                                  child: Container(
                                    width: ScreenUtil().setWidth(
                                      140,
                                    ),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: selectedFurnishing == index
                                          ? mainColor.withOpacity(.2)
                                          : Color(0xfF5F5F5),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          selectedFurnishing == index
                                              ? Icon(
                                                  Icons.cancel,
                                                  color: deepBlueColor,
                                                  size: 18,
                                                )
                                              : SizedBox.shrink(),
                                          selectedFurnishing == index
                                              ? SizedBox(
                                                  width: 8,
                                                )
                                              : SizedBox.shrink(),
                                          Text(
                                            options[index],
                                            style: TextStyle(
                                              color: selectedFurnishing == index
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
                            hideTypeOption = true;
                            hideFurnishing = true;
                            hideFinishing = true;

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
                            hideTypeOption = true;
                            hideFurnishing = true;
                            hideFinishing = true;

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

  Widget finishingFilter(List<CategoriesBean> categories) {
    List<String> options = ['Full', "Half", 'None'];
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
                      child: SingleChildScrollView(
                        physics: bouncingScrollPhysics,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            children: List.generate(
                              options.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  selectedFinishing = index;
                                  setState(() {});
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(50),
                                  elevation: 4,
                                  child: Container(
                                    width: ScreenUtil().setWidth(
                                      Localizations.localeOf(context)
                                                  .languageCode ==
                                              'ar'
                                          ? 180
                                          : 100,
                                    ),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: selectedFinishing == index
                                          ? mainColor.withOpacity(.2)
                                          : Color(0xfF5F5F5),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          selectedFinishing == index
                                              ? Icon(
                                                  Icons.cancel,
                                                  color: deepBlueColor,
                                                  size: 18,
                                                )
                                              : SizedBox.shrink(),
                                          selectedFinishing == index
                                              ? SizedBox(
                                                  width: 8,
                                                )
                                              : SizedBox.shrink(),
                                          Text(
                                            options[index],
                                            style: TextStyle(
                                              color: selectedFinishing == index
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
                            hideTypeOption = true;
                            hideFurnishing = true;
                            hideFinishing = true;

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
                            hideTypeOption = true;
                            hideFurnishing = true;
                            hideFinishing = true;

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

    realStateBloc.filter.value = null;
    RealStateFilterRequest request = RealStateFilterRequest(
      take: 5.toString(),
      skip: 0.toString(),
      has_coverd_parking: hasParking.toString(),
      category_id: _categories.isEmpty ? '0' : _categories,
      estate_finishing: selectedFinishing == 0 ? 'full' : selectedFinishing == 1 ? 'half' : selectedFinishing == 2 ? 'none' : null,
      estate_furnishing: selectedFurnishing == 0 ? 'unfurnished' : selectedFurnishing == 1 ? 'furnished' : null,
      estate_type: selectedType == 0 ? 'rental' : selectedType == 1 ? 'sale' : null,
      has_garden: hasGarden.toString(),
      has_maid_service: hasMaidService.toString(),
      has_security: hasSecurity.toString(),
    );

    print(request.tojson());

    realStateBloc.getFilter(request);

    selectedType = -1;
    selectedFurnishing = -1;
    selectedFinishing = -1;
    selectedCategories.clear();

    selectedOption = -1;
    searchController.clear();

    setState(() {});
  }

  void clearFilter() {
    selectedType = -1;
    selectedFurnishing = -1;
    selectedFinishing = -1;
    selectedCategories.clear();

    hasMaidService = false;
    hasParking = false;
    hasGarden = false;
    hasSecurity = false;

    selectedOption = -1;
    searchController.clear();

    setState(() {});
    realStateBloc.getFilter(RealStateFilterRequest(
      take: 5.toString(),
      skip: 0.toString(),
      category_id: '0',
    ));
  }
}
