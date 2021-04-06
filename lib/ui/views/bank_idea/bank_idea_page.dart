import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/bank_idea/BankIdeaRequest.dart';
import 'package:phinex/Bles/Model/responses/general/GeneralModelGovResponse.dart';
import 'package:phinex/Bles/bloc/bank_idea/BankIdeaBlaoc.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_patterns.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class BankIdeaPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _BankIdeaPageState createState() => _BankIdeaPageState();
}

class _BankIdeaPageState extends State<BankIdeaPage> {
  List<String> partnerTypeList = [];

  String selectedGovernorate = '';
  String selectedGovernorateId = '';
  String selectedCity = '';
  String selectedCityId = '';
  String selectedPartnerType;

  List<String> governoratesList = [];
  List<String> cityList = [];

  bool gotData = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String titleErrorMsg;
  String phoneErrorMsg;
  String descriptionErrorMsg;
  String emailErrorMsg;
  String nameErrorMsg;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    partnerTypeList = [
      AppUtils.translate(context, 'sell_us_your_idea'),
      AppUtils.translate(context, 'partner_with_us'),
      AppUtils.translate(context, 'fund_your_idea'),
    ];
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: myAppBar(
        AppLocalization.of(context).translate('ideas_bank'),
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false).setPage(HomeContents.pageIndex, HomeContents());
        },
      ),
      body: LoadingOverlay(
        progressIndicator: Loader(),
        isLoading: isLoading,
        color: Colors.white,
        opacity: .5,
        child: SingleChildScrollView(
          physics: bouncingScrollPhysics,
          child: StreamBuilder<GeneralModelGovResponse>(
            stream: generalBloc.generalGovModel.stream,
            builder: (context, snapshot) {
              if (generalBloc.loading.value) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    Loader(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  ],
                );
              } else {
                if (!gotData) {
                  gotData = true;
                  selectedPartnerType = partnerTypeList[0];
                  var governorates = snapshot.data.data.governorates;
                  governorates.forEach((element) {
                    governoratesList.add(element.name);
                  });

                  selectedGovernorate = governoratesList[0];

                  var government = governorates.firstWhere(
                      (element) => element.name == selectedGovernorate);
                  government.cities.forEach((element) {
                    cityList.add(element.name);
                  });

                  selectedCity = cityList[0];

                  var currentGovernorate = governorates.firstWhere(
                    (element) => element.name == selectedGovernorate,
                  );

                  selectedGovernorateId = currentGovernorate.id.toString();

                  currentGovernorate.cities.forEach(
                    (element) {
                      if (element.name == selectedCity) {

                        selectedCityId = element.id.toString();
                      }
                    },
                  );
                }
                return Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppUtils.translate(context, 'start_msg'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      MyTextFormField(
                        title: AppUtils.translate(context, 'full_name'),
                        errorMessage: nameErrorMsg,
                        controller: nameController,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      MyTextFormField(
                        title: AppUtils.translate(context, 'title1'),
                        errorMessage: titleErrorMsg,
                        controller: titleController,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      MyTextFormField(
                        title: AppUtils.translate(context, 'description'),
                        errorMessage: descriptionErrorMsg,
                        controller: descriptionController,
                        maxLines: 6,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        AppLocalization.of(context).translate('partner_type'),
                        style: TextStyle(color: Colors.grey),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(12),
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffEEEEEE),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedPartnerType,
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.grey,
                              size: 26,
                            ),
                            items: partnerTypeList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (result) {
                              selectedPartnerType = result;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setWidth(25),
                      ),
                      MyTextFormField(
                        title: AppLocalization.of(context)
                            .translate('mobile_number'),
                        controller: mobileNumberController,
                        keyboardType: TextInputType.phone,
                        errorMessage: phoneErrorMsg,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      MyTextFormField(
                        title: AppLocalization.of(context).translate('email'),
                        controller: emailController,
                        errorMessage: emailErrorMsg,
                      ),
                      Text(
                        translate(context, 'government'),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(12),
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffEEEEEE),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedGovernorate,
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.grey,
                              size: 26,
                            ),
                            items: governoratesList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              selectedGovernorate = newValue;
                              var currentGovernorate =
                                  snapshot.data.data.governorates.firstWhere(
                                (element) =>
                                    element.name == selectedGovernorate,
                              );

                              selectedGovernorateId =
                                  currentGovernorate.id.toString();

                              cityList.clear();
                              currentGovernorate.cities.forEach((element) {
                                cityList.add(element.name);
                              });

                              selectedCity = cityList[0];
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Text(
                        '',
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        translate(context, 'city'),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(12),
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffEEEEEE),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedCity,
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.grey,
                              size: 26,
                            ),
                            items: cityList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              selectedCity = newValue;
                              var currentGovernorate =
                                  snapshot.data.data.governorates.firstWhere(
                                (element) =>
                                    element.name == selectedGovernorate,
                              );

                              currentGovernorate.cities.forEach((element) {
                                if (element.name == selectedCity) {
                                  selectedCityId = element.id.toString();
                                }
                              });
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Text(
                        '',
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(12),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      myButton(AppUtils.translate(context, 'submit'),
                          onTap: () {
                        validateAndCreate();
                      }),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void validateAndCreate() async {
    AppUtils.hideKeyboard(context);

    //  name
    if (nameController.text.isEmpty) {
      nameErrorMsg = AppLocalization.of(context).translate("required");
    } else if (nameController.text.length < 2) {
      nameErrorMsg = AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      nameErrorMsg = null;
    }

    // title
    if (titleController.text.isEmpty) {
      titleErrorMsg = AppLocalization.of(context).translate("required");
    } else if (titleController.text.length < 2) {
      titleErrorMsg = AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      titleErrorMsg = null;
    }

    // description
    if (descriptionController.text.isEmpty) {
      descriptionErrorMsg = AppLocalization.of(context).translate("required");
    } else if (descriptionController.text.length < 2) {
      descriptionErrorMsg = AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      descriptionErrorMsg = null;
    }

    // mobile number
    if (mobileNumberController.text.isEmpty) {
      phoneErrorMsg = AppLocalization.of(context).translate("required");
    } else if (mobileNumberController.text.length < 5) {
      phoneErrorMsg = AppLocalization.of(context).translate("mobile_length_not_valid");
    } else if (mobileNumberController.text.length > 20) {
      phoneErrorMsg = AppLocalization.of(context).translate("mobile_length_not_valid");
    } else {
      phoneErrorMsg = null;
    }

    // email
    if (emailController.text.isNotEmpty) {
      if (!PatternUtils.emailIsValid(email: emailController.text)) {
        emailErrorMsg = translate(context, 'enter_valid_email');
      } else {
        emailErrorMsg = null;
      }
    } else {
      emailErrorMsg = null;
    }

    setState(() {});
    if (emailErrorMsg == null &&
        nameErrorMsg == null &&
        titleErrorMsg == null &&
        descriptionErrorMsg == null &&
        phoneErrorMsg == null) {
      isLoading = true;
      setState(() {});

      BankIdeaRequest request = BankIdeaRequest(
        city: 2,
        governorate: 2,
        email: emailController.text,
        title: titleController.text,
        description: descriptionController.text,
        phone: mobileNumberController.text,
        full_name: nameController.text,
        partner_type: getPartnerType(),
      );

      var response = await bankIdeaBloc.makeIdea(request);
      if (response.statusCode <= 200 && response.statusCode < 300) {
        AppUtils.showToast(
            msg: AppUtils.translate(context, 'done'), bgColor: mainColor);
        titleController.clear();
        descriptionController.clear();
        emailController.clear();
        mobileNumberController.clear();
        nameController.clear();
        selectedPartnerType = partnerTypeList[0];
        isLoading = false;
        setState(() {});
      } else {
        isLoading = false;
        setState(() {});
        AppUtils.showToast(
            msg: response.data['message'].toString(), bgColor: Colors.red);
      }
    }
  }

  String getPartnerType() {
    if (selectedPartnerType == partnerTypeList[0]) {
      return 'sell_us_your_idea';
    } else if (selectedPartnerType == partnerTypeList[1]) {
      return 'partner_with_us';
    } else {
      return 'fund_your_idea';
    }
  }
}
