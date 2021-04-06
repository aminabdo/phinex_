import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsByCatResponse.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsLandingResponse.dart';
import 'package:phinex/Bles/bloc/professions/Professions.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/profession/profession_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'profession_cart_item.dart';

class SingleProfessionCategoryPage extends StatefulWidget {
  final int id;
  final String title;

  const SingleProfessionCategoryPage(
      {Key key, @required this.id, @required this.title})
      : super(key: key);

  @override
  _SingleProfessionCategoryPageState createState() =>
      _SingleProfessionCategoryPageState();
}

class _SingleProfessionCategoryPageState
    extends State<SingleProfessionCategoryPage> {
  List<String> filterOptions;

  int selectedOption = -1;
  int selectedRate = -1;
  int selectedCategory;

  ScrollController controller = ScrollController();
  ScrollController _scrollController = ScrollController();

  bool hideCategoryOptions = true;
  bool hideRating = true;

  double filterHeightPercent = .45;

  int skip = 0;
  int take = 10;

  String title;

  @override
  void initState() {
    super.initState();

    selectedCategory = widget.id;

    title = widget.title;

    professionsBloc.getByCatID(BaseRequestSkipTake(
      id: widget.id,
      skip: skip,
      take: take,
    ));
  }

  @override
  Widget build(BuildContext context) {
    filterOptions = [
      AppLocalization.of(context).translate('category'),
      // AppLocalization.of(context).translate('rating'),
    ];

    return WillPopScope(
      onWillPop: () async {
        Provider.of<PageProvider>(context, listen: false)
            .setPage(ProfessionPage.pageIndex, ProfessionPage());
        return false;
      },
      child: Scaffold(
        appBar: myAppBar(
          title,
          context,
          onBackBtnClicked: () {
            Provider.of<PageProvider>(context, listen: false)
                .setPage(ProfessionPage.pageIndex, ProfessionPage());
          },
        ),
        body: StreamBuilder<ProfessionsByCatResponse>(
          stream: professionsBloc.getByCat.stream,
          builder: (context, snapshot) {
            if (professionsBloc.loading.value) {
              return Loader();
            } else {
              _scrollController
                ..addListener(
                  () {
                    if (_scrollController.position.pixels ==
                        _scrollController.position.maxScrollExtent) {
                      skip += 10;
                      take = 10;
                      professionsBloc.getByCatID(
                        BaseRequestSkipTake(
                          id: widget.id,
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
                                    hideRating = true;
                                  } else {
                                    selectedOption = index;
                                  }

                                  if (selectedOption == 0) {
                                    hideRating = true;
                                    if (hideCategoryOptions) {
                                      hideCategoryOptions = false;
                                    } else {
                                      hideCategoryOptions = true;
                                    }
                                  }

                                  if (selectedOption == 1) {
                                    hideCategoryOptions = true;
                                    hideRating = true;
                                    if (hideRating) {
                                      hideRating = false;
                                    } else {
                                      hideRating = true;
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
                        hideRating = true;

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
                              height: ScreenUtil().setHeight(380),
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 4,
                              crossAxisCount: 2,
                            ),
                            itemCount: snapshot.data.data.length,
                            itemBuilder: (context, index) {
                              return ProfessionCardItem(
                                currentItem: snapshot.data.data[index],
                              );
                            },
                          ),
                          hideCategoryOptions
                              ? null
                              : categoryFilter(
                                  professionsBloc.landing.value.data.categories,
                                ),
                          hideRating
                              ? null
                              : ratingFilter(
                                  professionsBloc.landing.value.data.categories,
                                ),
                        ].where((element) => element != null).toList(),
                      ),
                    ),
                  ].where((element) => element != null).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget categoryFilter(List<CategoriesBean> categories) {
    List<String> options = [];
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
                                              : categories[index].name.length >
                                                          25 &&
                                                      categories[index]
                                                              .name
                                                              .length <
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

                            setState(() {});
                            clearFilter();
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
                            hideRating = true;
                            setState(() {});

                            clearFilter();
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
                            hideRating = true;
                            setState(() {});

                            sendFilterRequest(categories);
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
    setState(() {
      title = _category.name;
    });
    professionsBloc.getByCatID(
      BaseRequestSkipTake(
        take: take,
        skip: skip,
        id: _category.id,
      ),
    );
  }

  void clearFilter() {
    Provider.of<PageProvider>(context, listen: false)
        .setPage(ProfessionPage.pageIndex, ProfessionPage());
  }
}
