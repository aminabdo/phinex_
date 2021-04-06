import 'package:cached_network_image/cached_network_image.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/medical_service/common/CommonPaginResponse.dart';
import 'package:phinex/Bles/bloc/medical_service/MedicalCommonBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/medical_services/clinics/all_clinics_specialists.dart';
import 'package:phinex/ui/views/medical_services/doctors/all_doctors_specialists.dart';
import 'package:phinex/ui/views/medical_services/pharmacy/all_pharmacies.dart';
import 'package:phinex/ui/views/medical_services/spa/all_spa.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';
import '../medical_services_page.dart';
import 'hospital_details_page.dart';

class AllHospitals extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _AllHospitalsState createState() => _AllHospitalsState();
}

class _AllHospitalsState extends State<AllHospitals> {
  int topCategoryTag = 3;

  List<String> categories ;

  ScrollController _scrollController = ScrollController();
  int skip = 0;
  int take = 10;

  @override
  void initState() {
    super.initState();

    commonBloc.getLanding(
        BaseRequestSkipTake(
          take: take,
          skip: skip,
        ),
        MedicalObjectName.hospitals);
  }

  @override
  Widget build(BuildContext context) {

    categories = [
      translate(context, 'all'), // 0
      translate(context, 'doctors'), // 1
      translate(context, 'spa'), // 2
      translate(context, 'hospital'), // 3
      translate(context, 'pharmacy'), // 4
      translate(context, 'clinics'), // 5
    ];

    return Scaffold(
      appBar: myAppBar(
        translate(context, 'hospitals'),
        context,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false).setPage(
            MedicalServicesPage.pageIndex,
            MedicalServicesPage(),
          );
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false).setPage(
            MedicalServicesPage.pageIndex,
            MedicalServicesPage(),
          );
          return false;
        },
        child: StreamBuilder<CommonPaginResponse>(
          stream: commonBloc.landing.stream,
          builder: (context, snapshot) {
            if (commonBloc.loading.value) {
              return Loader();
            } else {
              _scrollController
                ..addListener(
                      () {
                    if (_scrollController.position.pixels ==
                        _scrollController.position.maxScrollExtent) {
                      print('load more');
                      skip += 10;
                      take = 10;
                      commonBloc.getLanding(
                          BaseRequestSkipTake(
                            take: take,
                            skip: skip,
                          ),
                          MedicalObjectName.spa);
                    }
                  },
                );
              return SingleChildScrollView(
                physics: bouncingScrollPhysics,
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
                          if (val == 0) {
                            Provider.of<PageProvider>(context, listen: false)
                                .setPage(
                              MedicalServicesPage.pageIndex,
                              MedicalServicesPage(),
                            );
                          }
                          if (val == 1) {
                            Provider.of<PageProvider>(context, listen: false)
                                .setPage(
                              AllDoctorsSpecialists.pageIndex,
                              AllDoctorsSpecialists(),
                            );
                          } else if (val == 2) {
                            Provider.of<PageProvider>(context, listen: false)
                                .setPage(
                              AllSpa.pageIndex,
                              AllSpa(),
                            );
                          } else if (val == 3) {
                            Provider.of<PageProvider>(context, listen: false)
                                .setPage(
                              AllHospitals.pageIndex,
                              AllHospitals(),
                            );
                          } else if (val == 4) {
                            Provider.of<PageProvider>(context, listen: false)
                                .setPage(
                              AllPharmacies.pageIndex,
                              AllPharmacies(),
                            );
                          } else if (val == 5) {
                            Provider.of<PageProvider>(context, listen: false)
                                .setPage(
                              AllClinics.pageIndex,
                              AllClinics(),
                            );
                          }
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
                          source: categories,
                          value: (i, v) => i,
                          label: (i, v) => v,
                        ),
                      ),
                    ),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var item = snapshot.data.data[index];
                        print(item.coverImageUrl);
                        return Container(
                          width: double.infinity,
                          child: Card(
                            elevation: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => HospitalDetailsPage(
                                            id: item.id,
                                            title: item.title,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: item.coverImageUrl == null ||
                                            item.coverImageUrl == ''
                                            ? Image.asset(
                                          'assets/images/no-product-image.png',
                                        )
                                            : CachedNetworkImage(
                                          imageUrl: item.coverImageUrl,
                                          errorWidget: (_, __, ___) {
                                            return Center(
                                              child: Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                            );
                                          },
                                          placeholder: (context, url) {
                                            return Loader(
                                              size: 40,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(10),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(10),
                                      ),
                                      Row(
                                        children: [
                                          RatingBar.builder(
                                            initialRating:
                                            item.totalRates?.toDouble(),
                                            minRating: 1,
                                            itemSize: 16,
                                            ignoreGestures: true,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 0.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: goldColor,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(8),
                                          ),
                                          Text(
                                            '(${item.totalRates.toDouble()})',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(10),
                                      ),
                                      myButton(
                                        AppLocalization.of(context)
                                            .translate('see_details'),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => HospitalDetailsPage(
                                                id: item.id,
                                                title: item.title,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data.data.length,
                      gridDelegate:
                      MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        crossAxisCount: 2,
                        height: ScreenUtil().setHeight(300),
                      ),
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
