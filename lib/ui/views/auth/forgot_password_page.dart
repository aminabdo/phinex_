import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/bloc/auth/UserBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'verify_phone_forget_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController phoneController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          AppLocalization.of(context).translate("forgot_password"), context),
      body: LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: Loader(),
        opacity: .5,
        color: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(12),
              vertical: ScreenUtil().setHeight(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalization.of(context).translate("forgot_password"),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(
                  AppLocalization.of(context)
                      .translate("enter_the_mobile_number_you_used_for_phinex"),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
                MyTextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  onChanged: (String input) {
                    setState(() {});
                  },
                  title: AppLocalization.of(context).translate("mobile_number"),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: myButton(
                      AppLocalization.of(context).translate("verify"),
                      btnColor: phoneController.text.isEmpty ||
                              phoneController.text.length < 5
                          ? Colors.grey
                          : mainColor,
                      onTap: phoneController.text.isEmpty ||
                              phoneController.text.length < 5
                          ? null
                          : () {
                              verifyPhone();
                            },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void verifyPhone() async {
    AppUtils.hideKeyboard(context);
    isLoading = true;
    setState(() {});
    var response = await authBloc.forgotPassword(phoneController.text.trim());
    isLoading = false;
    setState(() {});
    if (response.statusCode <= 200 && response.statusCode < 300) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => VerifyPhoneForgetPasswordPage(
            phone: phoneController.text,
            userId: response.data['data']['user_id'],
          ),
        ),
      );
    } else {
      AppUtils.showToast(msg: AppUtils.translate(context, 'phone_not_found'));
    }
  }
}
