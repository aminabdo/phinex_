import 'package:cached_network_image/cached_network_image.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/jobs/JobsByCatResponse.dart';
import 'package:phinex/Bles/bloc/jobs/JobBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/services_page.dart';
import 'package:phinex/ui/views/recruitment/recruitment_categories_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'add_recruitment_page.dart';
import 'recruitment_details_page.dart';

class RecruitmentPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _RecruitmentPageState createState() => _RecruitmentPageState();
}

class _RecruitmentPageState extends State<RecruitmentPage> {
  int topCategoryTag = 0;
  List<String> filterOptions = [];

  bool gotData = false;

  @override
  void initState() {
    super.initState();

    jobBloc.getLanding(50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: myAppBar(
        AppLocalization.of(context).translate('recruitment'),
        context,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              if (AppUtils.userData == null) {
                AppUtils.showNeedToRegisterDialog(context);
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddRecruitmentPage(),
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
        child: StreamBuilder<JobsByCatResponse>(
          stream: jobBloc.landing.stream,
          builder: (context, snapshot) {
            if (jobBloc.loading.value) {
              return Loader();
            } else {
              if (!gotData) {
                filterOptions.add(AppUtils.translate(context, 'all'));
                jobBloc.cat.value.data.forEach((element) {
                  filterOptions.add(element.name);
                });

                gotData = true;
              }
              return SingleChildScrollView(
                physics: bouncingScrollPhysics,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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

                          if (topCategoryTag == 0) return;

                          print(jobBloc.cat.value.data[topCategoryTag - 1].id);
                          print(jobBloc.cat.value.data[topCategoryTag - 1].parentId);

                          Provider.of<PageProvider>(context, listen: false)
                              .setPage(
                            RecruitmentCategoriesPage.pageIndex,
                            RecruitmentCategoriesPage(
                              categoryId:
                                  jobBloc.cat.value.data[topCategoryTag - 1].id,
                              categoryName:
                                  jobBloc.cat.value.data[topCategoryTag - 1].name,
                              tag: topCategoryTag,
                            ),
                          );

                          setState(() {});
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
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GridView.builder(
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
                                      child: currentItem.image != null ? CachedNetworkImage(
                                        imageUrl: currentItem.image.imageUrl,
                                        placeholder: (_, __) {
                                          return Loader(
                                            size: 40,
                                          );
                                        },
                                        errorWidget: (context, _, __) {
                                          return Image.asset('assets/images/no-product-image.png');
                                        },
                                      ) : Image.asset('assets/images/no-product-image.png'),
                                    ),
                                  ),
                                  Text(currentItem.title ?? ''),
                                  myButton(
                                    AppUtils.translate(context, 'see_details'),
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                    ),
                  ],
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
}
