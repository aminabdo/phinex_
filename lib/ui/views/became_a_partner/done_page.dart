import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/providers/doctor_provider.dart';
import 'package:phinex/providers/driver_provider.dart';
import 'package:phinex/providers/merchant_provider.dart';
import 'package:phinex/providers/pharmacy_provider.dart';
import 'package:phinex/providers/profession_provider.dart';
import 'package:phinex/providers/real_estate_provider.dart';
import 'package:phinex/providers/resturant_provider.dart';
import 'package:phinex/ui/views/home/home_page.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

class DonePage extends StatefulWidget {
  @override
  _DonePageState createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      professionProvider.dispose();
      merchantProvider.dispose();
      driverProvider.dispose();
      realEstateProvider.dispose();
      resturantProvider.dispose();
      pharmacyProvider.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    DoctorProvider doctorProvider = Provider.of<DoctorProvider>(context, listen: false);

    if (doctorProvider.currentIndicatorNumber == 3) {
      doctorProvider.setCurrentIndicatorNumber(1);
      if (doctorProvider.isLoading) {
        doctorProvider.toggleLoadingState(false);
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .15,
              ),
              Image.asset('assets/images/done_image.png'),
              SizedBox(
                height: ScreenUtil().setHeight(18),
              ),
              Text(
                AppLocalization.of(context).translate('registeration_completed_sucessfully'),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                AppLocalization.of(context).translate('thanks_for_joing_us_your_account_will_be_activated_soon'),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: myButton(
                    AppLocalization.of(context).translate('ok'),
                    btnColor: mainColor,
                    height: 50,
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => HomePage(),
                          ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
