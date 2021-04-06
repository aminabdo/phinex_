import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phinex/Bles/Model/requests/SignupRequest.dart';
import 'package:phinex/Bles/bloc/auth/UserBloc.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/base/BaseResponse.dart';
import 'package:phinex/utils/consts.dart';

import 'verify_phone_page.dart';

class SignupPage extends StatefulWidget {
  final cardKey;

  const SignupPage({Key key, this.cardKey}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  String firstNameErrorMessage = '';
  String lastNameErrorMessage = '';
  String mobileNumberErrorMessage = '';
  String passwordErrorMessage = '';
  String confirmPasswordErrorMessage = '';

  @override
  void initState() {
    authBloc.signupSubject.onListen = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        isLoading: isLoading,
        opacity: .5,
        progressIndicator: Loader(),
        color: Colors.white,
        child: SingleChildScrollView(
          physics: bouncingScrollPhysics,
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
                  AppLocalization.of(context).translate("sign_up"),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                Text(
                  AppLocalization.of(context)
                      .translate("complete_the_following_data_please"),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyTextFormField(
                        onChanged: (String input) {
                          if (input.isEmpty) {
                            firstNameErrorMessage = AppLocalization.of(context)
                                .translate("required");
                          } else if (input.length < 2) {
                            firstNameErrorMessage = AppLocalization.of(context)
                                .translate("name_length_not_valid");
                          } else {
                            firstNameErrorMessage = null;
                          }
                          setState(() {});
                        },
                        controller: firstNameController,
                        errorMessage: firstNameErrorMessage,
                        title:
                            AppLocalization.of(context).translate("first_name"),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Expanded(
                      child: MyTextFormField(
                        onChanged: (String input) {
                          if (input.isEmpty) {
                            lastNameErrorMessage = AppLocalization.of(context)
                                .translate("required");
                          } else if (input.length < 2) {
                            lastNameErrorMessage = AppLocalization.of(context)
                                .translate("name_length_not_valid");
                          } else {
                            lastNameErrorMessage = null;
                          }
                          setState(() {});
                        },
                        controller: lastNameController,
                        errorMessage: lastNameErrorMessage,
                        title:
                            AppLocalization.of(context).translate("last_name"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CountryPickerDropdown(
                        initialValue: AppUtils.country.toUpperCase(),
                        onValuePicked: (Country country) {
                          print("${country.name}");
                        },
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: MyTextFormField(
                        onChanged: (String input) {
                          if (input.isEmpty) {
                            return AppLocalization.of(context).translate("required");
                          } else if (input.length <= 2) {
                            mobileNumberErrorMessage = AppLocalization.of(context)
                                .translate("mobile_length_not_valid");
                          } else {
                            mobileNumberErrorMessage = null;
                          }
                          setState(() {});
                        },
                        controller: mobileNumberController,
                        keyboardType: TextInputType.phone,
                        errorMessage: mobileNumberErrorMessage,
                        title: AppLocalization.of(context).translate("mobile_number"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                MyTextFormField(
                  obscureText: hidePassword,
                  errorMessage: passwordErrorMessage,
                  onChanged: (String input) {
                    if (input.isEmpty) {
                      passwordErrorMessage =
                          AppLocalization.of(context).translate("required");
                    } else if (input.length < 8) {
                      passwordErrorMessage = AppLocalization.of(context)
                          .translate('create_new_password_msg');
                    } else {
                      passwordErrorMessage = null;
                    }
                    setState(() {});
                  },
                  title: AppLocalization.of(context).translate('password'),
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
                  height: ScreenUtil().setHeight(5),
                ),
                MyTextFormField(
                  obscureText: hideConfirmPassword,
                  errorMessage: confirmPasswordErrorMessage,
                  onChanged: (String input) {
                    if (input.isEmpty) {
                      confirmPasswordErrorMessage =
                          AppLocalization.of(context).translate("required");
                    } else if (input != passwordController.text) {
                      confirmPasswordErrorMessage = AppLocalization.of(context)
                          .translate("confirm_password_not_match");
                    } else {
                      confirmPasswordErrorMessage = null;
                    }
                    setState(() {});
                  },
                  title:
                      AppLocalization.of(context).translate("confirm_password"),
                  controller: confirmPasswordController,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      hideConfirmPassword = !hideConfirmPassword;
                      setState(() {});
                    },
                    child: Icon(
                      hideConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: hideConfirmPassword ? Colors.grey : mainColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(25),
                ),
                myButton(
                  AppLocalization.of(context).translate("sign_up"),
                  btnColor: mainColor,
                  onTap: singupUser,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalization.of(context)
                            .translate("already_have_account"),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 12,),
                      Text(
                        AppLocalization.of(context).translate("sign_in"),
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
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

  void singupUser() {
    AppUtils.hideKeyboard(context);

    // first name
    if (firstNameController.text.isEmpty) {
      firstNameErrorMessage = AppLocalization.of(context).translate("required");
    } else if (firstNameController.text.length < 2) {
      firstNameErrorMessage =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      firstNameErrorMessage = null;
    }

    // last name
    if (lastNameController.text.isEmpty) {
      lastNameErrorMessage = AppLocalization.of(context).translate("required");
    } else if (lastNameController.text.length < 2) {
      lastNameErrorMessage =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      lastNameErrorMessage = null;
    }

    // mobile number
    if (mobileNumberController.text.isEmpty) {
      mobileNumberErrorMessage =
          AppLocalization.of(context).translate("required");
    } else if (mobileNumberController.text.length < 5) {
      mobileNumberErrorMessage = AppLocalization.of(context).translate("mobile_length_not_valid");
    } else if (mobileNumberController.text.length > 20) {
      mobileNumberErrorMessage = AppLocalization.of(context).translate("mobile_length_not_valid");
    } else {
      mobileNumberErrorMessage = null;
    }

    // confirm password
    if (passwordController.text.isEmpty) {
      passwordErrorMessage = AppLocalization.of(context).translate("required");
    } else if (passwordController.text.length < 8) {
      passwordErrorMessage =
          AppLocalization.of(context).translate('create_new_password_msg');
    } else {
      passwordErrorMessage = null;
    }

    // password
    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordErrorMessage =
          AppLocalization.of(context).translate("required");
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordErrorMessage =
          AppLocalization.of(context).translate("confirm_password_not_match");
    } else {
      confirmPasswordErrorMessage = null;
    }

    if (firstNameErrorMessage == null &&
        lastNameErrorMessage == null &&
        passwordErrorMessage == null &&
        mobileNumberErrorMessage == null &&
        confirmPasswordErrorMessage == null) {
      setState(() {
        isLoading = true;
      });
      authBloc.signup(
        SignupRequest(
          firstNameController.text,
          lastNameController.text,
          mobileNumberController.text,
          passwordController.text,
          Type,
          Channel,
        ),
      );
    }
  }

  getData() {
    authBloc.signupSubject.stream.listen(
      (value) {
        value.data;
        if (value == null) {
          isLoading = false;
          return;
        }
        if (value.code >= 200 && value.code < 300) {
          AppUtils.showToast(
              msg: 'Account Created Successfully', bgColor: mainColor);
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (_) => VerifyPhonePage(
                otp: value.data.verificationCode.toString(),
                userId: value.data.id,
                phone: (mobileNumberController.text),
                loginResponse: value,
              ),
            ),
          )
              .then(
            (value) {
              firstNameController.clear();
              lastNameController.clear();
              passwordController.clear();
              mobileNumberController.clear();
              confirmPasswordController.clear();
              if (mounted) setState(() {});
            },
          );
          setState(() {
            isLoading = false;
          });
        } else {
          List<dynamic> li = value.message as List;
          Map<String, dynamic> map = Message.getMessageMap(li);
          map.forEach((key, value) {
            if (key == 'phone') {
              List<dynamic> list = value;
              list.forEach((element) {
                mobileNumberErrorMessage = element + "\n";
              });
            }
            if (key == 'password') {
              List<dynamic> list = value;
              list.forEach((element) {
                passwordErrorMessage = element + "\n";
              });
            }
            if (key == 'first_name') {
              List<dynamic> list = value;
              list.forEach((element) {
                passwordErrorMessage = element + "\n";
              });
            }
            if (key == 'last_name') {
              List<dynamic> list = value;
              list.forEach((element) {
                passwordErrorMessage = element + "\n";
              });
            }
          });
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }
}
