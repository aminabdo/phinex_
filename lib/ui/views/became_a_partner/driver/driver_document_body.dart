import 'dart:io';
import 'package:path/path.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/providers/driver_provider.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/ui/widgets/my_upload_image_button.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';

import 'driver_registeration_page.dart';

class DriverDocumentBody extends StatefulWidget {
  @override
  _DriverDocumentBodyState createState() => _DriverDocumentBodyState();
}

class _DriverDocumentBodyState extends State<DriverDocumentBody> {
  String date = '';
  DateTime selectedDate = DateTime.now();

  File licenceImage;
  File criminalImage;

  TextEditingController licenceNumberController = TextEditingController();

  String licenceImageErrorMsg;
  String criminalRecordErrorMsg;
  String licenceNumberErrorMsg;
  String expiryDateErrorMsg;

  String licenceNumberImageResult = '';
  String criminalImageResult = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        DriverRegisterationPage.driverRequest.licenseExpiryDate = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
        date = DateTimeFormat.format(selectedDate, format: AmericanDateFormats.dayOfWeek);
        setState(() {});
      });
  }

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextFormField(
          controller: licenceNumberController,
          errorMessage: licenceNumberErrorMsg,
          keyboardType: TextInputType.number,
          title: AppLocalization.of(context).translate('licence_number'),
          onChanged: (String input) {
            DriverRegisterationPage.driverRequest.licenseNumber = input;
          },
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        MyUploadImageButton(
          result: licenceNumberImageResult,
          title: AppLocalization.of(context).translate('licence_image'),
          onTap: () async {
            var selectedImage = await AppUtils.getImage(1);
            if (selectedImage != null) {
              var path = await FlutterAbsolutePath.getAbsolutePath(
                selectedImage[0].identifier,
              );

              licenceImage = File(path);
              DriverRegisterationPage.driverRequest.licenseImage = licenceImage;

              String name = basename(path);
              licenceNumberImageResult = name;
              setState(() {});
            }
          },
        ),
        Text(
          licenceImageErrorMsg ?? '',
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(25),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalization.of(context).translate('licence_expiration'),
              style: TextStyle(color: Colors.grey),
            ),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xffEEEEEE),
                ),
                child: Text(date),
              ),
            ),
          ],
        ),
        Text(
          expiryDateErrorMsg ?? '',
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        MyUploadImageButton(
          title: AppLocalization.of(context).translate('criminal_record'),
          result: criminalImageResult,
          onTap: () async {
            var selectedImage = await AppUtils.getImage(1);
            if (selectedImage != null) {
              var path = await FlutterAbsolutePath.getAbsolutePath(
                selectedImage[0].identifier,
              );

              criminalImage = File(path);
              DriverRegisterationPage.driverRequest.crimeRecordsImage =
                  criminalImage;

              String name = basename(path);
              criminalImageResult = name;
              setState(() {});
            }
          },
        ),
        Text(
          criminalRecordErrorMsg ?? '',
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
        SizedBox(
          height: ScreenUtil().setWidth(30),
        ),
        myButton(
          'Next',
          onTap: () {
            validateAndContineu(context);
          },
        ),
        SizedBox(
          height: ScreenUtil().setWidth(50),
        ),
      ],
    );
  }

  void validateAndContineu(BuildContext context) {
    if (licenceNumberController.text.isEmpty) {
      licenceNumberErrorMsg = translate(context, 'required');
    } else {
      licenceNumberErrorMsg = null;
    }

    if (licenceImage == null) {
      licenceImageErrorMsg = translate(context, 'required');
    } else {
      licenceImageErrorMsg = null;
    }

    if (criminalImage == null) {
      criminalRecordErrorMsg = translate(context, 'required');
    } else {
      criminalRecordErrorMsg = null;
    }

    if (date == '') {
      expiryDateErrorMsg = translate(context, 'required');
    } else {
      expiryDateErrorMsg = null;
    }

    setState(() {});

    if (expiryDateErrorMsg == null &&
        criminalRecordErrorMsg == null &&
        licenceImageErrorMsg == null &&
        licenceNumberErrorMsg == null) {

      driverProvider.setCurrentIndicatorNumber(3);
    }
  }
}
