import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/utils/app_localization.dart';

import 'doctor/doctor_registeration_page.dart';
import 'driver/driver_registeration_page.dart';
import 'merchant/merchant_regiteration_page.dart';
import 'pharmacy/pharmacy_regiteration_page.dart';
import 'profession/profession_registeration_page.dart';
import 'real_state/real_state_registeration_page.dart';
import 'restaurant/restaurant_regiteration_page.dart';

class BecameAPartnerMainPage extends StatefulWidget {
  @override
  _BecameAPartnerMainPageState createState() => _BecameAPartnerMainPageState();
}

class _BecameAPartnerMainPageState extends State<BecameAPartnerMainPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: myAppBar(
          AppLocalization.of(context).translate('became_a_partner'), context),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(12),
          vertical: ScreenUtil().setHeight(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalization.of(context).translate('select_your_service'),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Text(
              AppLocalization.of(context).translate('make_your_business'),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        serviceType(
                          AppLocalization.of(context).translate('merchant'),
                          'assets/images/shop.png',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => MerchantRegisterationPage(),
                              ),
                            );
                          },
                        ),
                        serviceType(
                          AppLocalization.of(context).translate('doctor'),
                          'assets/images/doctor_logo.png',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DoctorRegisterationPage(),
                              ),
                            );
                          },
                        ),
                        serviceType(
                          AppLocalization.of(context)
                              .translate('profession_name'),
                          'assets/images/carpenter.png',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ProfessionRegisterationPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        serviceType(
                          AppLocalization.of(context).translate('driver'),
                          'assets/images/driver.png',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DriverRegisterationPage(),
                              ),
                            );
                          },
                        ),
                        serviceType(
                          AppLocalization.of(context)
                              .translate('real_state_developer'),
                          'assets/images/real_state_logo.png',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => RealStateRegiserationPage(),
                              ),
                            );
                          },
                        ),
                        serviceType(
                          AppLocalization.of(context).translate('restaurant'),
                          'assets/images/food.png',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => RestaurantRegisterationPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    serviceType(
                      AppLocalization.of(context).translate('pharmacy'),
                      'assets/images/pharmacy.png',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PharmacyRegisterationPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceType(String title, String imagePath, {Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            elevation: 4,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(15),
                vertical: ScreenUtil().setHeight(15),
              ),
              child: Container(
                height: ScreenUtil().setHeight(70),
                width: ScreenUtil().setWidth(50),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(
                      imagePath,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
