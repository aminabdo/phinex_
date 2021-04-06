import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/medical_service/common/CommonPaginResponse.dart';
import 'package:phinex/Bles/bloc/medical_service/MedicalCommonBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/medical_services/doctors/all_doctors_specialists.dart';
import 'package:phinex/ui/views/medical_services/hospital/all_hospitals.dart';
import 'package:phinex/ui/views/medical_services/pharmacy/all_pharmacies.dart';
import 'package:phinex/ui/views/medical_services/spa/all_spa.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/consts.dart';

import '../medical_services_page.dart';
import 'all_clinics_specialists.dart';
import 'clinics_cart_item.dart';

class SingleCategoryClinicDetailsPage extends StatefulWidget {
  static final int pageIndex = 0;
  final int categoryId;
  final String title;

  const SingleCategoryClinicDetailsPage({Key key, this.categoryId, this.title})
      : super(key: key);

  @override
  _SingleCategoryClinicDetailsPageState createState() =>
      _SingleCategoryClinicDetailsPageState();
}

class _SingleCategoryClinicDetailsPageState
    extends State<SingleCategoryClinicDetailsPage> {
  int topCategoryTag = 5;
  int secondCategoryTag = 0;

  String title = '';

  List<String> categories = [
    'All', // 0
    'Doctors', // 1
    'Spa', // 2
    'Hospital', // 3
    'Pharmacy', // 4
    'Clinics', // 5
  ];

  List<String> specialists = ['All'];
  bool gotIt = false;

  ScrollController _scrollController = ScrollController();
  int skip = 0;
  int take = 10;

  @override
  void initState() {
    super.initState();

    title = (widget.title);

    secondCategoryTag =
        (commonBloc.clinicsLanding.value.data.specialties.indexOf(
              commonBloc.clinicsLanding.value.data.specialties
                  .firstWhere((element) => element.id == widget.categoryId),
            ) +
            1);

    commonBloc.getClinicByCat(
      BaseRequestSkipTake(id: widget.categoryId, skip: skip, take: take),
    );

    commonBloc.clinicsLanding.value.data.specialties.forEach(
      (element) {
        specialists.add(element.name);
      },
    );

    _scrollController
      ..addListener(
        () {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            skip += 10;
            take = 10;
            commonBloc.getClinicByCat(
              BaseRequestSkipTake(
                  id: widget.categoryId, skip: skip, take: take),
            );
          }
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title,
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false).setPage(
            AllClinics.pageIndex,
            AllClinics(),
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
            AllClinics.pageIndex,
            AllClinics(),
          );
          return false;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: bouncingScrollPhysics,
          child: Column(
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
                      Provider.of<PageProvider>(context, listen: false).setPage(
                        MedicalServicesPage.pageIndex,
                        MedicalServicesPage(),
                      );
                    }
                    if (val == 1) {
                      Provider.of<PageProvider>(context, listen: false).setPage(
                        AllDoctorsSpecialists.pageIndex,
                        AllDoctorsSpecialists(),
                      );
                    } else if (val == 2) {
                      Provider.of<PageProvider>(context, listen: false).setPage(
                        AllSpa.pageIndex,
                        AllSpa(),
                      );
                    } else if (val == 3) {
                      Provider.of<PageProvider>(context, listen: false).setPage(
                        AllHospitals.pageIndex,
                        AllHospitals(),
                      );
                    } else if (val == 4) {
                      Provider.of<PageProvider>(context, listen: false).setPage(
                        AllPharmacies.pageIndex,
                        AllPharmacies(),
                      );
                    } else if (val == 5) {
                      Provider.of<PageProvider>(context, listen: false).setPage(
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
                      Provider.of<PageProvider>(context, listen: false).setPage(
                        AllDoctorsSpecialists.pageIndex,
                        AllDoctorsSpecialists(),
                      );
                    } else {
                      title = commonBloc.clinicsLanding.value.data
                          .specialties[secondCategoryTag - 1].name;
                      commonBloc.getClinicByCat(
                        BaseRequestSkipTake(
                          id: widget.categoryId,
                          skip: 0,
                          take: take,
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
                    elevation: 3,
                    color: Colors.black45,
                  ),
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: specialists,
                    value: (i, v) => i,
                    label: (i, v) => v,
                  ),
                ),
              ),
              StreamBuilder<CommonPaginResponse>(
                stream: commonBloc.clinics.stream,
                builder: (context, snapshot) {
                  if (commonBloc.loading.value) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                        Loader(),
                      ],
                    );
                  } else {
                    if (!gotIt) {
                      gotIt = true;
                      secondCategoryTag = (commonBloc
                              .clinicsLanding.value.data.specialties
                              .indexOf(
                            commonBloc.clinicsLanding.value.data.specialties
                                .firstWhere((element) =>
                                    element.id == widget.categoryId),
                          ) +
                          1);
                    }
                    commonBloc.clinicsLanding.value.data.specialties.forEach(
                      (element) {
                        specialists.add(element.name);
                      },
                    );
                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        height: ScreenUtil().setHeight(360),
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (context, index) {
                        return ClinicsCardItem(
                          item: snapshot.data.data[index],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
