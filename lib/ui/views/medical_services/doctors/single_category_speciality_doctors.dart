import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorBySpecialityResponse.dart';
import 'package:phinex/Bles/bloc/medical_service/DoctorBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/medical_services/clinics/all_clinics_specialists.dart';
import 'package:phinex/ui/views/medical_services/hospital/all_hospitals.dart';
import 'package:phinex/ui/views/medical_services/pharmacy/all_pharmacies.dart';
import 'package:phinex/ui/views/medical_services/spa/all_spa.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/consts.dart';

import '../medical_services_page.dart';
import 'all_doctors_specialists.dart';
import 'doctors_cart_item.dart';

class SingleCategorySpecialityDoctors extends StatefulWidget {
  static final int pageIndex = 0;

  final String title;
  final int categoryId;

  const SingleCategorySpecialityDoctors(
      {Key key, @required this.title, @required this.categoryId})
      : super(key: key);

  @override
  _SingleCategorySpecialityDoctorsState createState() =>
      _SingleCategorySpecialityDoctorsState();
}

class _SingleCategorySpecialityDoctorsState
    extends State<SingleCategorySpecialityDoctors> {
  int topCategoryTag = 1;
  int secondCategoryTag = 0;

  String title = '';

  List<String> categories;

  List<String> specialists;
  bool gotIt = false;

  @override
  void initState() {
    super.initState();

    specialists = [];

    for (int i = 0; i < doctorBloc.landing.value.data.specialties.length; i++) {
      specialists.add(doctorBloc.landing.value.data.specialties[i].name);
    }

    title = (widget.title);

    secondCategoryTag = (doctorBloc.landing.value.data.specialties
        .indexOf(
      doctorBloc.landing.value.data.specialties.firstWhere(
              (element) => element.id == widget.categoryId),
    ) +
        1);

    doctorBloc.getByCatID(BaseRequestSkipTake(
      id: widget.categoryId,
    ));
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
        title,
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false).setPage(
            AllDoctorsSpecialists.pageIndex,
            AllDoctorsSpecialists(),
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
            AllDoctorsSpecialists.pageIndex,
            AllDoctorsSpecialists(),
          );
          return false;
        },
        child: SingleChildScrollView(
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
                      title = doctorBloc.landing.value.data
                          .specialties[secondCategoryTag - 1].name;
                      doctorBloc.getByCatID(
                        BaseRequestSkipTake(
                          id: doctorBloc.landing.value.data
                              .specialties[secondCategoryTag - 1].id,
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
              StreamBuilder<DoctorBySpecialityResponse>(
                stream: doctorBloc.getByCat.stream,
                builder: (context, snapshot) {
                  if (doctorBloc.loading.value) {
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
                      secondCategoryTag =
                          (doctorBloc.landing.value.data.specialties.indexOf(
                                doctorBloc.landing.value.data.specialties
                                    .firstWhere((element) =>
                                        element.id == widget.categoryId),
                              ) +
                              1);
                    }
                    doctorBloc.landing.value.data.specialties.forEach(
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
                        return DoctorsCardItem(
                          doctorBean: snapshot.data.data[index],
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
