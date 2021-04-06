import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:phinex/Bles/Model/responses/driver/DriverCreateDetailsResponse.dart';
import 'package:phinex/Bles/bloc/driver/DriverBloc.dart';
import 'package:phinex/providers/driver_provider.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/ui/widgets/my_upload_image_button.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'driver_registeration_page.dart';
class DriverVehicleBody extends StatefulWidget {
  @override
  _DriverVehicleBodyState createState() => _DriverVehicleBodyState();
}

class _DriverVehicleBodyState extends State<DriverVehicleBody> {
  String selectedCarModel = 'A';
  String plateCharacters = '';
  String plateNumbers = '';
  String plateNumbersErrors;
  String plateCharactersErrors;
  String selectedManufactureYear = '';
  String licenceImageFrontResult = '';
  String licenceImageBackResult = '';
  String licenceImageBackErrorsMsg = '';
  String licenceImageFrontErrorsMsg = '';

  List<String> years = [];
  List<String> models = [];
  DateTime date = DateTime.now();

  File licenceImageFront;
  File licenceImageBack;

  bool getData = false;

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  @override
  void initState() {
    super.initState();

    for (int i = date.year; i > date.year - 100; i--) {
      years.add(i.toString());
    }

    selectedManufactureYear = years[0];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DriverCreateDetailsResponse>(
      stream: driverBloc.getCreateDetails.stream,
      builder: (context, snapshot) {
        if (driverBloc.loading.value) {
          return Loader();
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            if (!getData) {
              getData = true;

              snapshot.data.data.models.forEach((element) {
                if(!models.contains(element.modelName)) {
                  models.add(element.modelName);
                }
              });

              selectedCarModel = models[0];
              DriverRegisterationPage.driverRequest.carModelId = snapshot.data.data.models.firstWhere((element) => element.modelName == selectedCarModel).id;
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translate(context, 'vehicle_model'),
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
                    value: selectedCarModel,
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.grey,
                      size: 26,
                    ),
                    items: models.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (car) {
                      selectedCarModel = car;
                      print(models);
                      print('==================\n');
                      print(selectedCarModel);
                      setState(() {});

                      DriverRegisterationPage.driverRequest.carModelId = snapshot.data.data.models.firstWhere((element) => element.modelName == selectedCarModel).id;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                translate(context, 'manufacture_year'),
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
                    value: selectedManufactureYear,
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.grey,
                      size: 26,
                    ),
                    items: years.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (year) {
                      setState(() {
                        selectedManufactureYear = year;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyTextFormField(
                      errorMessage: plateNumbersErrors,
                      title: AppLocalization.of(context).translate('plate_numbers'),
                      keyboardType: TextInputType.number,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      onChanged: (String input) {
                        plateNumbers = input;
                      },
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(16),
                  ),
                  Expanded(
                    child: MyTextFormField(
                      errorMessage: plateCharactersErrors,
                      onChanged: (String input) {
                        plateCharacters = input;
                      },
                      title: translate(context, 'plate_characters'),
                      titleStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              MyUploadImageButton(
                result: licenceImageFrontResult,
                title: AppLocalization.of(context)
                    .translate('vehicle_licence_front'),
                onTap: () async {
                  List<Asset> image = await getImage();
                  if (image != null) {
                    // file path
                    var path = await FlutterAbsolutePath.getAbsolutePath(
                      image[0].identifier,
                    );

                    licenceImageFrontResult = basename(path);

                    licenceImageFront = File(path);
                    DriverRegisterationPage.driverRequest.imageLicenseFront = licenceImageFront;
                    setState(() {});
                  }
                },
              ),
              Text(
                licenceImageFrontErrorsMsg ?? '',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              MyUploadImageButton(
                title: AppLocalization.of(context).translate('vehicle_licence_back'),
                result: licenceImageBackResult,
                onTap: () async {
                  List<Asset> image = await getImage();
                  if (image != null) {
                    // file path
                    var path = await FlutterAbsolutePath.getAbsolutePath(
                      image[0].identifier,
                    );

                    licenceImageBackResult = basename(path);

                    licenceImageBack = File(path);
                    DriverRegisterationPage.driverRequest.imageLicenseBack = licenceImageBack;
                    setState(() {});
                  }
                },
              ),
              Text(
                licenceImageBackErrorsMsg ?? '',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(30),
              ),
              myButton(translate(context, 'next'), onTap: () {
                validateAndContinue(context);
              }),
              SizedBox(
                height: ScreenUtil().setWidth(30),
              ),
            ],
          );
        }
      },
    );
  }

  Future<List<Asset>> getImage() async {
    bool permissionIsGranted = await AppUtils.askPhotosPermission();
    if (permissionIsGranted) {
      try {
        var selectedImage = await MultiImagePicker.pickImages(
          maxImages: 1,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: APP_NAME),
          materialOptions: MaterialOptions(
            actionBarColor: "#ff16135A",
            actionBarTitle: APP_NAME,
            allViewTitle: "All Photos",
            useDetailsView: false,
            autoCloseOnSelectionLimit: false,
            startInAllView: false,
            selectCircleStrokeColor: "#000000",
          ),
        );

        return selectedImage;
      } catch (e) {
        print(e);
      }
    }
  }

  void validateAndContinue(BuildContext context) {
    if (plateNumbers == '') {
      plateNumbersErrors = translate(context, 'required');
    } else {
      plateNumbersErrors = null;
    }
    if (plateCharacters == '') {
      plateCharactersErrors = translate(context, 'required');
    } else {
      plateCharactersErrors = null;
    }
    if (licenceImageFront == null) {
      licenceImageFrontErrorsMsg = translate(context, 'required');
    } else {
      licenceImageFrontErrorsMsg = null;
    }
    if (licenceImageBack == null) {
      licenceImageBackErrorsMsg = translate(context, 'required');
    } else {
      licenceImageBackErrorsMsg = null;
    }

    setState(() {});
    if (plateNumbersErrors == null &&
        plateCharactersErrors == null &&
        licenceImageBackErrorsMsg == null &&
        licenceImageFrontErrorsMsg == null) {

      DriverRegisterationPage.driverRequest.licensePlate = plateNumbers + plateCharacters;

      DriverRegisterationPage.driverRequest.manufacturerYear = num.parse(selectedManufactureYear);

      driverProvider.setCurrentIndicatorNumber(4);
    }
  }
}
