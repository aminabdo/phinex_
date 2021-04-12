import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/animations/delayed_reveal_animation.dart';
import 'package:phinex/ui/views/car_rental/car_rental_page.dart';
import 'package:phinex/ui/views/driver/main_driver_page.dart';
import 'package:phinex/ui/views/education/education_page.dart';
import 'package:phinex/ui/views/festival/festival_page.dart';
import 'package:phinex/ui/views/holidays/holidays_page.dart';
import 'package:phinex/ui/views/medical_services/medical_services_page.dart';
import 'package:phinex/ui/views/profession/profession_page.dart';
import 'package:phinex/ui/views/real_states/real_states_page.dart';
import 'package:phinex/ui/views/recruitment/recruitment_page.dart';
import 'package:phinex/ui/views/resturant/resturant_page.dart';
import 'package:phinex/ui/views/security/security_page.dart';
import 'package:phinex/ui/views/shipping/shipping_page.dart';
import 'package:phinex/ui/views/sports/sport_page.dart';
import 'package:phinex/ui/views/store/store_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'home_contents.dart';

class ServicesPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  List<Categories> categories = [];

  @override
  Widget build(BuildContext context) {
    categories = [
      Categories(
        'assets/images/store.png',
        AppLocalization.of(context).translate("store"),
      ),
      Categories(
        'assets/images/resturant.png',
        AppLocalization.of(context).translate("restaurant"),
      ),
      Categories(
        'assets/images/real_state.png',
        AppLocalization.of(context).translate("real_state"),
      ),
      Categories(
        'assets/images/car_rental.png',
        AppLocalization.of(context).translate("car_rental"),
      ),
      Categories(
        'assets/images/profession.png',
        AppLocalization.of(context).translate("profession"),
      ),
      Categories(
        'assets/images/medical.png',
        AppLocalization.of(context).translate("medical_services"),
      ),
      Categories(
        'assets/images/map_icon.svg',
        AppLocalization.of(context).translate('request_a_ride'),
        isSvg: true,
      ),
      Categories(
        'assets/images/recruitment.svg',
        AppLocalization.of(context).translate('recruitment'),
        isSvg: true,
        width: 100,
      ),
      Categories(
        'assets/images/education.svg',
        AppLocalization.of(context).translate('education'),
        isSvg: true,
        width: 100,
      ),
      // Categories(
      //   'assets/images/tourism.svg',
      //   AppLocalization.of(context).translate('tourism'),
      //   isSvg: true,
      // ),
      Categories(
        'assets/images/festival.svg',
        AppLocalization.of(context).translate('holidays'),
        isSvg: true,
        width: 100,
      ),
      Categories(
        'assets/images/shipping.svg',
        AppLocalization.of(context).translate('shipping'),
        isSvg: true,
      ),
      Categories(
        'assets/images/sports.svg',
        AppLocalization.of(context).translate('sports'),
        isSvg: true,
      ),
      Categories(
        'assets/images/holiday.svg',
        AppLocalization.of(context).translate('festival'),
        isSvg: true,
      ),
      Categories(
        'assets/images/cctv.svg',
        AppLocalization.of(context).translate('security'),
        isSvg: true,
      ),
    ];

    var pageProvider = Provider.of<PageProvider>(context);

    return Scaffold(
      appBar: myAppBar(
        AppLocalization.of(context).translate('services'),
        context,
        onBackBtnClicked: () {
          pageProvider.setPage(HomeContents.pageIndex, HomeContents());
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          pageProvider.setPage(HomeContents.pageIndex, HomeContents());
          return false;
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: GridView.builder(
            itemBuilder: (context, index) {
              int time = (50 * index);
              return DelayedReveal(
                delay: Duration(milliseconds: time),
                child: GestureDetector(
                  onTap: () async {
                    if (index == 0) {
                      pageProvider.setPage(StorePage.pageIndex, StorePage());
                    } else if (index == 1) {
                      pageProvider.setPage(
                          RestaurantPage.pageIndex, RestaurantPage());
                    } else if (index == 2) {
                      pageProvider.setPage(
                          RealStatesPage.pageIndex, RealStatesPage());
                    } else if (index == 3) {
                      pageProvider.setPage(
                          CarRentalPage.pageIndex, CarRentalPage());
                    } else if (index == 4) {
                      pageProvider.setPage(
                          ProfessionPage.pageIndex, ProfessionPage());
                    } else if (index == 5) {
                      pageProvider.setPage(
                        MedicalServicesPage.pageIndex,
                        MedicalServicesPage(),
                      );
                    } else if (index == 6) {
                      if (AppUtils.userData == null) {
                        AppUtils.showNeedToRegisterDialog(context);
                        return;
                      }

                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      bool result;

                      if(preferences.getBool('locationDialog') ?? false) {
                        result = true;
                      } else {
                        result = await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Attention'),
                              content: Text(
                                'This service will use the location in the background To facilitate the trip tracking process',
                              ),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: Text('OK ACCEPT'),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: Text('Cancel'),
                                )
                              ],
                            );
                          },
                        );
                      }

                      if(result) {
                        preferences.setBool('locationDialog', true);
                        pageProvider.setPage(
                          MainDriverPage.pageIndex,
                          MainDriverPage(),
                        );
                      }
                    } else if (index == 7) {
                      pageProvider.setPage(
                        RecruitmentPage.pageIndex,
                        RecruitmentPage(),
                      );
                    } else if (index == 8) {
                      pageProvider.setPage(
                        EducationPage.pageIndex,
                        EducationPage(),
                      );
                    }
                    // else if (index == 9) {
                    //   pageProvider.setPage(
                    //     TourismPage.pageIndex,
                    //     TourismPage(),
                    //   );
                    // }
                    else if (index == 9) {
                      pageProvider.setPage(
                        HolidaysPage.pageIndex,
                        HolidaysPage(),
                      );
                    } else if (index == 10) {
                      pageProvider.setPage(
                        ShippingPage.pageIndex,
                        ShippingPage(),
                      );
                    } else if (index == 11) {
                      pageProvider.setPage(
                        SportsPage.pageIndex,
                        SportsPage(),
                      );
                    } else if (index == 12) {
                      pageProvider.setPage(
                        FestivalPage.pageIndex,
                        FestivalPage(),
                      );
                    } else if (index == 13) {
                      pageProvider.setPage(
                        SecurityPage.pageIndex,
                        SecurityPage(),
                      );
                    }
                  },
                  child: Card(
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        categories[index].isSvg
                            ? SvgPicture.asset(
                                categories[index].imagePath,
                                width: ScreenUtil()
                                    .setWidth(categories[index].width ?? 60),
                                height: ScreenUtil()
                                    .setHeight(categories[index].height ?? 90),
                              )
                            : Image.asset(
                                categories[index].imagePath,
                                width: ScreenUtil()
                                    .setWidth(categories[index].width ?? 60),
                                height: ScreenUtil()
                                    .setHeight(categories[index].height ?? 90),
                              ),
                        Text(categories[index].title),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: categories.length,
            physics: bouncingScrollPhysics,
            gridDelegate:
                MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              crossAxisCount: 2,
              height: ScreenUtil().setHeight(170),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class Categories {
  final String imagePath;
  final String title;
  final bool isSvg;
  final double height;
  final double width;

  Categories(
    this.imagePath,
    this.title, {
    this.isSvg = false,
    this.height,
    this.width,
  });
}
