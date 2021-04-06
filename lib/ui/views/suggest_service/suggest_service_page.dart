import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/suggest_service/BankIdeaRequest.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/Bles/bloc/suggest_service/suggest_service_bloc.dart';
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

class SuggestServicePage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _SuggestServicePageState createState() => _SuggestServicePageState();
}

class _SuggestServicePageState extends State<SuggestServicePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String lastNameErrorMsg;
  String phoneErrorMsg;
  String descriptionErrorMsg;
  String emailErrorMsg;
  String nameErrorMsg;
  String titleErrorMsg;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    generalBloc.getModelGov();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: myAppBar(
          AppLocalization.of(context).translate('suggest_service'),
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
            child: Padding(
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
                    title: AppLocalization.of(context).translate('name'),
                    controller: nameController,
                    errorMessage: nameErrorMsg,
                  ),
                  SizedBox(
                    height: ScreenUtil().setWidth(12),
                  ),
                  MyTextFormField(
                    title: AppLocalization.of(context).translate('mobile_number'),
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
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  MyTextFormField(
                    title: AppLocalization.of(context).translate('title'),
                    controller: titleController,
                    errorMessage: titleErrorMsg,
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
                  SizedBox(
                    height: 20,
                  ),
                  myButton(AppUtils.translate(context, 'submit'), onTap: () {
                    validateAndCreate();
                  }),
                ],
              ),
            ),
          ),
        ));
  }

  void validateAndCreate() async {
    AppUtils.hideKeyboard(context);

    //  name
    if (nameController.text.isEmpty) {
      nameErrorMsg = AppLocalization.of(context).translate("required");
    } else if (nameController.text.length < 2) {
      nameErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
    } else {
      nameErrorMsg = null;
    }

    // title
    if (titleController.text.isEmpty) {
      titleErrorMsg = AppLocalization.of(context).translate("required");
    } else if (titleController.text.length < 2) {
      titleErrorMsg = AppLocalization.of(context).translate("invalid_length");
    } else {
      titleErrorMsg = null;
    }

    // description
    if (descriptionController.text.isEmpty) {
      descriptionErrorMsg = AppLocalization.of(context).translate("required");
    } else if (descriptionController.text.length < 2) {
      descriptionErrorMsg =
          AppLocalization.of(context).translate("name_length_not_valid");
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
    if (emailController.text.isEmpty) {
      emailErrorMsg = AppLocalization.of(context).translate("required");
    } else if (!PatternUtils.emailIsValid(email: emailController.text)) {
      emailErrorMsg = translate(context, 'enter_valid_email');
    } else {
      emailErrorMsg = null;
    }

    setState(() {});

    if (emailErrorMsg == null &&
        nameErrorMsg == null &&
        lastNameErrorMsg == null &&
        descriptionErrorMsg == null &&
        titleErrorMsg == null &&
        phoneErrorMsg == null) {

      AppUtils.hideKeyboard(context);

      isLoading = true;
      setState(() {});

      var response = await suggestService.suggestService(SuggestServiceRequest(
        description: descriptionController.text,
        phone: mobileNumberController.text,
        email: emailController.text,
        title: titleController.text,
        full_name: nameController.text,
      ));

      if(response != null && response.statusCode >= 200 && response.statusCode < 300) {
        AppUtils.showToast(msg: AppUtils.translate(context, 'done'), bgColor: mainColor);
        emailController.clear();
        nameController.clear();
        titleController.clear();
        mobileNumberController.clear();
        descriptionController.clear();
      } else {
        AppUtils.showToast(msg: AppUtils.translate(context, 'error'));
      }

      isLoading = false;
      setState(() {});
    }
  }
}
