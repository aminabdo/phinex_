import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsLandingResponse.dart';
import 'package:phinex/Bles/bloc/professions/Professions.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/services_page.dart';
import 'package:phinex/ui/views/profession/profession_search_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';
import 'profession_cart_item.dart';
import 'single_profession_category_page.dart';

class ProfessionPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _ProfessionPageState createState() => _ProfessionPageState();
}

class _ProfessionPageState extends State<ProfessionPage> {
  List<String> filterOptions;

  int selectedOption = -1;
  int selectedRate = -1;
  int selectedCategory;

  ScrollController controller = ScrollController();

  bool hideCategoryOptions = true;
  bool hideRating = true;

  double filterHeightPercent = .45;

  @override
  void initState() {
    super.initState();

    professionsBloc.getLanding();
  }

  @override
  Widget build(BuildContext context) {
    filterOptions = [
      AppLocalization.of(context).translate('category'),
      // AppLocalization.of(context).translate('rating'),
    ];

    return Scaffold(
      appBar: myAppBar(
        AppLocalization.of(context).translate('professions'),
        context,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfessionSearchPage(),
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
        child: StreamBuilder<ProfessionsLandingResponse>(
          stream: professionsBloc.landing.stream,
          builder: (context, snapshot) {
            if (professionsBloc.loading.value) {
              return Loader();
            } else {
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
                          ListView.builder(
                            itemCount:
                                snapshot.data.data.CategoryTechnicians.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                height: ScreenUtil().setHeight(485),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    ScreenUtil().setWidth(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot
                                                .data
                                                .data
                                                .CategoryTechnicians[index]
                                                .name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Provider.of<PageProvider>(context, listen: false).setPage(0, SingleProfessionCategoryPage(
                                                id: snapshot
                                                    .data
                                                    .data
                                                    .CategoryTechnicians[
                                                index]
                                                    .id,
                                                title: snapshot
                                                    .data
                                                    .data
                                                    .CategoryTechnicians[
                                                index]
                                                    .name,
                                              ));
                                            },
                                            child: Text(
                                              AppLocalization.of(context)
                                                  .translate('see_all'),
                                              style: TextStyle(
                                                color: mainColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(8),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          physics: bouncingScrollPhysics,
                                          itemBuilder: (context, index2) {
                                            return Container(
                                              width: ScreenUtil().setWidth(220),
                                              child: ProfessionCardItem(
                                                currentItem: snapshot
                                                    .data
                                                    .data
                                                    .CategoryTechnicians[index]
                                                    .technicians[index2],
                                              ),
                                            );
                                          },
                                          itemCount: snapshot
                                              .data
                                              .data
                                              .CategoryTechnicians[index]
                                              .technicians
                                              .length,
                                          scrollDirection: Axis.horizontal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          hideCategoryOptions
                              ? null
                              : categoryFilter(snapshot.data.data.categories),
                          // hideRating
                          //     ? null
                          //     : ratingFilter(snapshot.data.data.categories),
                        ].where((element) => element != null).toList(),
                      ),
                    ),
                  ].where((element) => element != null).toList(),
                ),
              );
            }
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
                              alignment: WrapAlignment.center,
                                direction: Axis.horizontal,
                              spacing: 10,
                              children: List.generate(
                                categories.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    selectedCategory = index;
                                    setState(() {});
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    child: Material(
                                      elevation: 4,
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        width: ScreenUtil().setWidth(
                                            categories[index].name.length < 25 ? 155 : categories[index].name.length > 25 && categories[index].name.length < 35 ? 250 : 300),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: selectedCategory == index
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
                                                  color:
                                                      selectedCategory == index
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
  //
  // Widget ratingFilter(List<CategoriesBean> categories) {
  //   return Container(
  //     color: Colors.transparent.withOpacity(.35),
  //     height: MediaQuery.of(context).size.height,
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           height: 2,
  //         ),
  //         Container(
  //           height: MediaQuery.of(context).size.height * filterHeightPercent,
  //           child: Material(
  //             elevation: 8,
  //             child: Container(
  //               color: Colors.white,
  //               padding: EdgeInsets.all(2),
  //               child: Column(
  //                 children: [
  //                   Expanded(
  //                     child: Padding(
  //                       padding: EdgeInsets.all(8.0),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: List.generate(
  //                           5,
  //                           (index) => GestureDetector(
  //                             onTap: () {
  //                               selectedRate = index;
  //                               setState(() {});
  //                             },
  //                             child: Container(
  //                               padding: EdgeInsets.symmetric(
  //                                 horizontal: ScreenUtil().setWidth(12),
  //                                 vertical: ScreenUtil().setHeight(5),
  //                               ),
  //                               decoration: BoxDecoration(
  //                                 color: selectedRate == index
  //                                     ? greenColor
  //                                     : Colors.white,
  //                                 borderRadius: BorderRadius.circular(50),
  //                                 border: Border.all(
  //                                   color: Colors.grey[300],
  //                                   width: .8,
  //                                 ),
  //                               ),
  //                               child: Row(
  //                                 children: [
  //                                   Text(
  //                                     '${index + 1}',
  //                                     style: TextStyle(
  //                                       color: selectedRate == index
  //                                           ? Colors.white
  //                                           : Colors.black,
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     width: 5,
  //                                   ),
  //                                   Icon(
  //                                     Icons.star_border,
  //                                     color: goldColor,
  //                                     size: 18,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ).toList(),
  //                       ),
  //                     ),
  //                   ),
  //                   Divider(
  //                     thickness: 1.5,
  //                     height: ScreenUtil().setHeight(20),
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       FlatButton(
  //                         onPressed: () {
  //                           selectedOption = -1;
  //                           hideCategoryOptions = true;
  //                           hideRating = true;
  //                           setState(() {});
  //                         },
  //                         child: Text(
  //                           AppLocalization.of(context)
  //                               .translate('clear_filter'),
  //                           style: TextStyle(
  //                             color: Colors.red,
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                       ),
  //                       FlatButton(
  //                         onPressed: () {
  //                           selectedOption = -1;
  //                           hideCategoryOptions = true;
  //                           hideRating = true;
  //                           setState(() {});
  //
  //                           sendFilterRequest(
  //                             categories,
  //                           );
  //                         },
  //                         child: Text(
  //                           AppLocalization.of(context).translate('apply'),
  //                           style: TextStyle(
  //                             color: greenColor,
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void sendFilterRequest(
    List<CategoriesBean> categories,
  ) {
    if (selectedCategory == null) return;
    var item = categories[selectedCategory];
    print(item.toJson());
    Provider.of<PageProvider>(context, listen: false).setPage(0, SingleProfessionCategoryPage(id: item.id, title: item.name),);
  }
}
