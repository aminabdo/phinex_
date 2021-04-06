import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/views/home/home_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

class DoneOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          AppLocalization.of(context).translate('order_placed'), context),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height /
                        MediaQuery.of(context).size.width +
                    20,
              ),
              Image.asset('assets/images/done_image.png'),
              SizedBox(
                height: ScreenUtil().setHeight(35),
              ),
              Text(
                AppLocalization.of(context)
                    .translate('order_placed_successfully'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: myButton(
                    AppLocalization.of(context).translate('ok'),
                    onTap: () {
                      Provider.of<PageProvider>(context, listen: false)
                          .setPage(HomeContents.pageIndex, HomeContents());
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => HomePage(),
                          ),
                          (route) => false);
                    },
                    btnColor: mainColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
