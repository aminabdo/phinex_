import 'package:cached_network_image/cached_network_image.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacyLandingResponse.dart';
import 'package:phinex/Bles/bloc/medical_service/PharmacyBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/medical_services/clinics/all_clinics_specialists.dart';
import 'package:phinex/ui/views/medical_services/doctors/all_doctors_specialists.dart';
import 'package:phinex/ui/views/medical_services/hospital/all_hospitals.dart';
import 'package:phinex/ui/views/medical_services/pharmacy/single_pharmacy_details_page.dart';
import 'package:phinex/ui/views/medical_services/spa/all_spa.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import '../medical_services_page.dart';

class AllPharmacies extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _AllPharmaciesState createState() => _AllPharmaciesState();
}

class _AllPharmaciesState extends State<AllPharmacies> {
  int topCategoryTag = 4;

  List<String> categories;

  @override
  void initState() {
    super.initState();

    pharmacyBloc.getLanding(BaseRequestSkipTake());
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
        translate(context, 'pharmacies'),
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
        child: StreamBuilder<PharmacyLandingResponse>(
          stream: pharmacyBloc.landing.stream,
          builder: (context, snapshot) {
            if (pharmacyBloc.loading.value) {
              return Loader();
            } else {
              return SingleChildScrollView(
                physics: bouncingScrollPhysics,
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
                        var pharmacy = snapshot.data.pharmacy[index];
                        return Card(
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            SinglePharmacyDetailsPage(
                                              title: pharmacy.title,
                                              id: pharmacy.pharmacyId,
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
                                      child: CachedNetworkImage(
                                        imageUrl: pharmacy.coverImageUrl,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pharmacy.title,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(10),
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating:
                                              pharmacy.totalRates.toDouble(),
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
                                          '(${pharmacy.totalRates.toDouble()})',
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
                                            builder: (_) =>
                                                SinglePharmacyDetailsPage(
                                              title: pharmacy.title,
                                              id: pharmacy.pharmacyId,
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
                        );
                      },
                      itemCount: snapshot.data.pharmacy.length,
                      gridDelegate:
                          MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        crossAxisCount: 2,
                        height: ScreenUtil().setHeight(320),
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
