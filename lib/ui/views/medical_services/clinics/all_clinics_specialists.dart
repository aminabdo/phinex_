import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/medical_service/common/ClinicLandingResponse.dart';
import 'package:phinex/Bles/bloc/medical_service/MedicalCommonBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/medical_services/doctors/all_doctors_specialists.dart';
import 'package:phinex/ui/views/medical_services/doctors/single_category_speciality_doctors.dart';
import 'package:phinex/ui/views/medical_services/hospital/all_hospitals.dart';
import 'package:phinex/ui/views/medical_services/pharmacy/all_pharmacies.dart';
import 'package:phinex/ui/views/medical_services/spa/all_spa.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';
import '../medical_services_page.dart';
import 'clinics_cart_item.dart';
import 'single_category_details_page.dart';

class AllClinics extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _AllClinicsState createState() => _AllClinicsState();
}

class _AllClinicsState extends State<AllClinics> {
  int topCategoryTag = 5;
  int secondCategoryTag = 0;

  List<String> categories ;

  List<String> specialists = [
    'All',
  ];

  @override
  void initState() {
    super.initState();

    commonBloc.getClinic(MedicalObjectName.clinics);
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
        translate(context, 'clinics'),
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false).setPage(
            MedicalServicesPage.pageIndex,
            MedicalServicesPage(),
          );
        },
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false).setPage(
            MedicalServicesPage.pageIndex,
            MedicalServicesPage(),
          );
          return false;
        },
        child: StreamBuilder<ClinicLandingResponse>(
          stream: commonBloc.clinicsLanding.stream,
          builder: (context, snapshot) {
            if (commonBloc.loading.value) {
              return Loader();
            } else {
              specialists = [
                'All',
              ];
              snapshot.data.data.specialties.forEach((element) {
                specialists.add(element.name);
              });
              return SingleChildScrollView(
                physics: bouncingScrollPhysics,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(6),
                        right: ScreenUtil().setWidth(6),
                        top: ScreenUtil().setHeight(6),
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
                          elevation: 4,
                          color: Colors.black45,
                        ),
                        choiceItems: C2Choice.listFrom<int, String>(
                          source: categories,
                          value: (i, v) => i,
                          label: (i, v) => v,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(6),
                        vertical: ScreenUtil().setHeight(0),
                      ),
                      child: ChipsChoice<int>.single(
                        value: secondCategoryTag,
                        scrollPhysics: bouncingScrollPhysics,
                        onChanged: (val) {
                          setState(() => secondCategoryTag = val);
                          if (val == 0) {
                            Provider.of<PageProvider>(context, listen: false)
                                .setPage(
                              AllClinics.pageIndex,
                              AllClinics(),
                            );
                          } else {
                            Provider.of<PageProvider>(context, listen: false)
                                .setPage(
                              SingleCategoryClinicDetailsPage.pageIndex,
                              SingleCategoryClinicDetailsPage(
                                title: snapshot.data.data.specialties[val - 1].name,
                                categoryId:
                                snapshot.data.data.specialties[val - 1].id,
                              ),
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
                          elevation: 4,
                          color: Colors.black45,
                        ),
                        choiceItems: C2Choice.listFrom<int, String>(
                          source: specialists,
                          value: (i, v) => i,
                          label: (i, v) => v,
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: snapshot.data.data.clinics_specialties.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return buildOptionList(
                          index,
                          snapshot,
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

  Widget buildOptionList(int index, AsyncSnapshot<ClinicLandingResponse> snapshot) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(430),
      child: Padding(
        padding: EdgeInsets.all(
          ScreenUtil().setWidth(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  snapshot.data.data.clinics_specialties[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<PageProvider>(context, listen: false).setPage(
                      SingleCategorySpecialityDoctors.pageIndex,
                      SingleCategoryClinicDetailsPage(
                        title:
                        snapshot.data.data.clinics_specialties[index].name,
                        categoryId:
                        snapshot.data.data.clinics_specialties[index].id,
                      ),
                    );
                  },
                  child: Text(
                    AppLocalization.of(context).translate('see_all'),
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
                itemBuilder: (context, index1) {
                  return Container(
                    width: ScreenUtil().setWidth(230),
                    child: ClinicsCardItem(
                      item: snapshot.data.data.clinics_specialties[index]
                          .clinics[index1],
                      // speciality: specialists[index + 1],
                    ),
                  );
                },
                itemCount: snapshot
                    .data.data.clinics_specialties[index].clinics.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
