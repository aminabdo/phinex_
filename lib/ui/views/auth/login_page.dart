import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/user/LoginRequest.dart';
import 'package:phinex/Bles/Model/responses/user/LoginResponse.dart';
import 'package:phinex/Bles/bloc/auth/UserBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/auth/signup_page.dart';
import 'package:phinex/ui/views/auth/verify_phone_page.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/views/home/home_page.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;

  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String mobileNumberErrorMessage = '';
  String passwordErrorMessage = '';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        isLoading: isLoading,
        opacity: .5,
        progressIndicator: Loader(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(15),
              vertical: ScreenUtil().setHeight(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
                Text(
                  AppLocalization.of(context).translate('welcome'),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                Text(
                  AppLocalization.of(context).translate('welcome_to_phinex'),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                MyTextFormField(
                  title: AppLocalization.of(context).translate('mobile_number'),
                  initialValue: null,
                  controller: mobileNumberController,
                  onChanged: (String input) {
                    if (input.isEmpty) {
                      mobileNumberErrorMessage =
                          AppLocalization.of(context).translate("required");
                    } else {
                      mobileNumberErrorMessage = null;
                    }
                    setState(() {});
                  },
                  keyboardType: TextInputType.phone,
                  errorMessage: mobileNumberErrorMessage,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                MyTextFormField(
                  obscureText: hidePassword,
                  title: AppLocalization.of(context).translate('password'),
                  errorMessage: passwordErrorMessage,
                  onChanged: (String input) {
                    if (input.isEmpty) {
                      passwordErrorMessage =
                          AppLocalization.of(context).translate("required");
                    } else {
                      passwordErrorMessage = null;
                    }
                    setState(() {});
                  },
                  controller: passwordController,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      hidePassword = !hidePassword;
                      setState(() {});
                    },
                    child: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                      color: hidePassword ? Colors.grey : mainColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: Text(
                      AppLocalization.of(context).translate('forgot_password'),
                      style: TextStyle(
                        color: deepBlueColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(25),
                ),
                myButton(
                  AppLocalization.of(context).translate('sign_in'),
                  btnColor: mainColor,
                  onTap: loginUser,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SignupPage(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalization.of(context)
                            .translate("don't_have_an_account"),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        AppLocalization.of(context).translate("sign_up"),
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => HomePage(),
                        ),
                      );
                    },
                    child: Text(
                      AppLocalization.of(context).translate("skip"),
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    AppUtils.hideKeyboard(context);

    // first name
    if (mobileNumberController.text.isEmpty) {
      mobileNumberErrorMessage =
          AppLocalization.of(context).translate("required");
    } else {
      mobileNumberErrorMessage = null;
    }

    // last name
    if (passwordController.text.isEmpty) {
      passwordErrorMessage = AppLocalization.of(context).translate("required");
    } else {
      passwordErrorMessage = null;
    }

    if (mobileNumberErrorMessage == null && passwordErrorMessage == null) {
      setState(() {
        isLoading = true;
      });

      var request = LoginRequest(
        mobileNumberController.text,
        passwordController.text,
      );

      print(request.toJson());
      LoginResponse response = await authBloc.login(
        LoginRequest(
          mobileNumberController.text,
          passwordController.text,
        ),
      );

      if (response.code >= 200 && response.code < 300) {
        if (response.data.user.isPhoneVerified == false) {
          print(response.data.toJson());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VerifyPhonePage(
                otp: response.data.user.verificationCode,
                userId: response.data.user.id,
                phone: mobileNumberController.text,
                loginResponse: response,
                sendOtp: true,
              ),
            ),
          );
        } else {
          print(response.data.toJson());
          await AppUtils.saveUserData(response.data.user);
          await AppUtils.saveLoginDate(DateTime.now().toString());
          Provider.of<PageProvider>(context, listen: false).setPage(HomeContents.pageIndex, HomeContents());
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => HomePage(),), (_) => false,)
              .then((response) {
              passwordController.clear();
              mobileNumberController.clear();
              if (mounted) setState(() {});
            },
          );
        }
      } else {
        AppUtils.showToast(msg: AppUtils.translate(context, 'login_error_msg'));
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
