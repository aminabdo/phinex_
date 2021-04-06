import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/medical_service/medical_service/MedicalServiceLanding.dart';
import 'package:phinex/Bles/bloc/medical_service/MedicalBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/services_page.dart';
import 'package:phinex/ui/views/medical_services/pharmacy/all_pharmacies.dart';
import 'package:phinex/ui/views/medical_services/spa/all_spa.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'clinics/all_clinics_specialists.dart';
import 'clinics/single_clinic_details_page.dart';
import 'doctors/all_doctors_specialists.dart';
import 'doctors/single_doctor_details_page.dart';
import 'hospital/all_hospitals.dart';
import 'hospital/hospital_details_page.dart';
import 'medical_cart_item.dart';
import 'pharmacy/single_pharmacy_details_page.dart';
import 'spa/spa_details_page.dart';

class MedicalServicesPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _MedicalServicesPageState createState() => _MedicalServicesPageState();
}

class _MedicalServicesPageState extends State<MedicalServicesPage> {
  int topCategoryTag = 0;
  int secondCategoryTag = 0;

  List<String> categories;

  @override
  void initState() {
    super.initState();

    medicalBloc.getLanding();
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
        AppLocalization.of(context).translate('medical_services'),
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(ServicesPage.pageIndex, ServicesPage());
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
          Provider.of<PageProvider>(context, listen: false)
              .setPage(ServicesPage.pageIndex, ServicesPage());
          return false;
        },
        child: StreamBuilder<MedicalServiceLanding>(
          stream: medicalBloc.landing.stream,
          builder: (context, snapshot) {
            if (medicalBloc.loading.value) {
              return Loader();
            } else {
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
                          setState(() {});
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
                    ListView.builder(
                      itemCount: categories.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return index == 0
                            ? SizedBox.shrink()
                            : buildOptionList(
                                index,
                                () {
                                  if (topCategoryTag == 1 ||
                                      index == 1) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => SingleDoctorDetailsPage(
                                          title: snapshot.data.data
                                              .doctors[index].commercialName,
                                          id: snapshot
                                              .data.data.doctors[index].id,
                                        ),
                                      ),
                                    );
                                  } else if (topCategoryTag == 2 || index == 2) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => SpaDetailsPage(
                                          title: snapshot
                                              .data.data.spa[index].title,
                                          id: snapshot.data.data.spa[index].id,
                                        ),
                                      ),
                                    );
                                  } else if (topCategoryTag == 3 || index == 3) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => HospitalDetailsPage(
                                          title: snapshot
                                              .data.data.hospitals[index].title,
                                          id: snapshot
                                              .data.data.hospitals[index].id,
                                        ),
                                      ),
                                    );
                                  } else if (topCategoryTag == 4 || index == 4) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            SinglePharmacyDetailsPage(
                                          title: snapshot.data.data
                                              .pharmacies[index].title,
                                          id: snapshot.data.data
                                              .pharmacies[index].pharmacyId,
                                        ),
                                      ),
                                    );
                                  } else if (topCategoryTag == 5 || index == 5) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => SingleClinicDetailsPage(
                                          title: snapshot
                                              .data.data.clinics[index].title,
                                          id: snapshot
                                              .data.data.clinics[index].id,
                                        ),
                                      ),
                                    );
                                  }
                                },
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

  Widget buildOptionList(int index, Function onItemTap,
      AsyncSnapshot<MedicalServiceLanding> snapshot) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(490),
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
                  categories[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (topCategoryTag == 1) {
                      Provider.of<PageProvider>(context, listen: false).setPage(
                        AllDoctorsSpecialists.pageIndex,
                        AllDoctorsSpecialists(),
                      );
                    } else if (topCategoryTag == 2) {
                      Provider.of<PageProvider>(context, listen: false).setPage(
                        AllSpa.pageIndex,
                        AllSpa(),
                      );
                    } else if (topCategoryTag == 3) {
                      Provider.of<PageProvider>(context, listen: false).setPage(
                        AllHospitals.pageIndex,
                        AllHospitals(),
                      );
                    } else if (topCategoryTag == 4) {
                      Provider.of<PageProvider>(context, listen: false).setPage(
                        AllPharmacies.pageIndex,
                        AllPharmacies(),
                      );
                    }
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
                  String title;
                  String image;
                  int id;
                  Function onTap;
                  double rate;

                  if (index == 1) {
                    title = snapshot.data.data.doctors[index1].commercialName;
                    image = snapshot.data.data.doctors[index1].imageUrl;
                    id = snapshot.data.data.doctors[index1].doctorId;
                    rate = snapshot.data.data.doctors[index1].totalRates?.toDouble();
                    onTap = () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SingleDoctorDetailsPage(
                            id: id,
                            title: title,
                          ),
                        ),
                      );
                    };
                  } else if (index == 2) {
                    title = snapshot.data.data.spa[index1].title;
                    image = snapshot.data.data.spa[index1].coverImageUrl;
                    id = snapshot.data.data.spa[index1].id;
                    rate = snapshot.data.data.spa[index1].totalRates?.toDouble();
                    onTap = () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SpaDetailsPage(
                            id: id,
                            title: title,
                          ),
                        ),
                      );
                    };
                  } else if (index == 3) {
                    title = snapshot.data.data.hospitals[index1].title;
                    image = snapshot.data.data.hospitals[index1].coverImageUrl;
                    id = snapshot.data.data.hospitals[index1].id;
                    rate = snapshot.data.data.hospitals[index1].totalRates?.toDouble();
                    onTap = () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => HospitalDetailsPage(
                            id: id,
                            title: title,
                          ),
                        ),
                      );
                    };
                  } else if (index == 4) {
                    title = snapshot.data.data.pharmacies[index1].title;
                    image = snapshot.data.data.pharmacies[index1].coverImageUrl;
                    id = snapshot.data.data.pharmacies[index1].pharmacyId;
                    rate = snapshot.data.data.pharmacies[index1].totalRates?.toDouble();
                    onTap = () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SinglePharmacyDetailsPage(
                            id: id,
                            title: title,
                          ),
                        ),
                      );
                    };
                  } else {
                    title = snapshot.data.data.clinics[index1].title;
                    image = snapshot.data.data.clinics[index1].coverImageUrl;
                    id = snapshot.data.data.clinics[index1].id;
                    rate = snapshot.data.data.clinics[index1].totalRates?.toDouble();
                    onTap = () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SingleClinicDetailsPage(
                            id: id,
                            title: title,
                          ),
                        ),
                      );
                    };
                  }

                  return Container(
                    width: ScreenUtil().setWidth(230),
                    child: MedicalCardItem(
                      title: title,
                      onTap: onTap,
                      imageUrl: image,
                      rate: rate,
                    ),
                  );
                },
                itemCount: index == 1
                    ? snapshot.data.data.doctors.length
                    : index == 2
                        ? snapshot.data.data.spa.length
                        : index == 3
                            ? snapshot.data.data.hospitals.length
                            : index == 4
                                ? snapshot.data.data.pharmacies.length
                                : snapshot.data.data.clinics.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
