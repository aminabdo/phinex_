
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/jobs/JobsByCatResponse.dart';
import 'package:phinex/Bles/bloc/jobs/JobBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'recruitment_details_page.dart';
import 'recruitment_page.dart';

class RecruitmentCategoriesPage extends StatefulWidget {
  static final int pageIndex = 0;
  final int categoryId;
  final int tag;
  final String categoryName;

  const RecruitmentCategoriesPage(
      {Key key,
      @required this.categoryId,
      @required this.categoryName,
      this.tag})
      : super(key: key);

  @override
  _RecruitmentCategoriesPageState createState() =>
      _RecruitmentCategoriesPageState();
}

class _RecruitmentCategoriesPageState extends State<RecruitmentCategoriesPage> {
  ScrollController _scrollController = ScrollController();
  int skip = 0;
  int take = 10;

  String titel;

  int topCategoryTag = 0;
  List<String> filterOptions = [];

  bool gotData = false;

  @override
  void initState() {
    super.initState();

    topCategoryTag = widget.tag;
    titel = widget.categoryName;

    jobBloc.getJobsByCat(
        BaseRequestSkipTake(id: widget.categoryId, skip: skip, take: take));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: myAppBar(
        titel,
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(RecruitmentPage.pageIndex, RecruitmentPage());
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(RecruitmentPage.pageIndex, RecruitmentPage());
          return false;
        },
        child: StreamBuilder<JobsByCatResponse>(
          stream: jobBloc.jobsByCat.stream,
          builder: (context, snapshot) {
            if (jobBloc.loading.value) {
              return Loader();
            } else {
              _scrollController
                ..addListener(
                  () {
                    if (_scrollController.position.pixels ==
                        _scrollController.position.maxScrollExtent) {
                      skip += 10;
                      take = 10;
                      jobBloc.getJobsByCat(
                        BaseRequestSkipTake(
                          skip: skip,
                          take: take,
                          id: widget.categoryId,
                        ),
                      );
                    }
                  },
                );

              if (!gotData) {
                filterOptions.add(AppUtils.translate(context, 'all'));
                jobBloc.cat.value.data.forEach((element) {
                  filterOptions.add(element.name);
                });

                gotData = true;
              }

              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(6),
                        vertical: ScreenUtil().setHeight(6),
                      ),
                      child: ChipsChoice<int>.single(
                        value: topCategoryTag,
                        scrollPhysics: bouncingScrollPhysics,
                        onChanged: (val) {
                          topCategoryTag = val;
                          setState(() {});

                          if(topCategoryTag == 0) {
                            Provider.of<PageProvider>(context, listen: false)
                                .setPage(RecruitmentPage.pageIndex, RecruitmentPage());
                            return;
                          }

                          setState(() {
                            titel = jobBloc.cat.value.data[topCategoryTag - 1].name;
                          });

                          jobBloc.getJobsByCat(
                            BaseRequestSkipTake(
                              id: jobBloc.cat.value.data[(topCategoryTag - 1) >= 0 ? topCategoryTag - 1 : 0].id,
                              skip: skip,
                              take: take,
                            ),
                          );
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
                          source: filterOptions,
                          value: (i, v) => i,
                          label: (i, v) => v,
                        ),
                      ),
                    ),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        childAspectRatio: 1 / 1.1,
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data.data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var currentItem = snapshot.data.data[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              RecruitmentDetailsPage(
                                            name: currentItem.title,
                                            id: currentItem.id,
                                          ),
                                        ),
                                      );
                                    },
                                    child:  currentItem.image != null ? CachedNetworkImage(
                                      imageUrl: currentItem.image.imageUrl,
                                      fit: BoxFit.fill,
                                      placeholder: (_, __) {
                                        return Loader(
                                          size: 40,
                                        );
                                      },
                                      errorWidget: (context, _, __) {
                                        return Image.asset('assets/images/no-product-image.png');
                                      },
                                    ) : Image.asset('assets/images/no-product-image.png', fit: BoxFit.fill,),
                                  ),
                                ),
                                myButton(
                                  currentItem.title ?? '',
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => RecruitmentDetailsPage(
                                          name: currentItem.title,
                                          id: currentItem.id,
                                        ),
                                      ),
                                    );
                                  },
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
