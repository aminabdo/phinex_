import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:phinex/Bles/Model/requests/froms/DoctorFormRequest.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorDetailsCreateResponse.dart';
import 'package:phinex/Bles/bloc/medical_service/DoctorBloc.dart';
import 'package:phinex/ui/views/became_a_partner/doctor/clinic_lang_page.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/ui/widgets/my_time_picker.dart';
import 'package:phinex/ui/widgets/my_upload_image_button.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_patterns.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';
import 'package:weekday_selector/weekday_selector.dart';

import 'doctor_registeration_page.dart';

class DoctorHospitalForm extends StatefulWidget {
  @override
  _DoctorHospitalFormState createState() => _DoctorHospitalFormState();
}

class _DoctorHospitalFormState extends State<DoctorHospitalForm> {
  List<Widget> workshopsList = [];
  List<String> governoratesList = [];
  List<String> cityList = [];
  List<String> specialityList = [];

  // We start with all days selected.
  final values = List.filled(7, false);

  String selectedGovernorate = '';
  String selectedGovernorateId = '';
  String selectedCity = '';
  String selectedCityId = '';

  String coverImageResult = '';
  String profileImageResult = '';
  String photosResult = '';
  String selectedSpeciality = '';
  String selectedSpecialityId = '';

  List<File> photos = [];
  File coverImage;
  File logoImage;

  bool gotData = false;
  bool fillForm = false;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DoctorDetailsCreateResponse>(
      stream: doctorBloc.doctorCreateDetails.stream,
      builder: (context, snapshot) {
        if (doctorBloc.loading.value) {
          return Loader();
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            if (!gotData) {
              // initialize hospitals
              DoctorRegisterationPage.doctorRequest.hospitals = [];
              DoctorRegisterationPage.doctorRequest.hospitals.add(Hospitals()..workingDays = WorkingDays());
              DoctorRegisterationPage.doctorRequest.hospitals[0].clinics = [];

              DoctorRegisterationPage.doctorRequest.hospitals[0].clinics.add(Clinics()..workingDays = WorkingDays());

              DoctorRegisterationPage.doctorRequest.hospitals[0].type =
                  'hospital';
              DoctorRegisterationPage.doctorRequest.hospitals[0].limit = 5000;
              DoctorRegisterationPage.doctorRequest.hospitals[0].latitude =
                  double.parse(LATITUDE);
              DoctorRegisterationPage.doctorRequest.hospitals[0].longitude =
                  double.parse(LONGITUDE);

              if (!fillForm) {
                fillForm = true;
                workshopsList.add(
                  workshopForm(context, 0),
                );
              }

              // government && city
              var governorates = snapshot.data.data.country.governorates;
              governorates.forEach((element) {
                governoratesList.add(element.name);
              });

              selectedGovernorate = governoratesList[0];

              var government = governorates
                  .firstWhere((element) => element.name == selectedGovernorate);
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

              // speciality
              var specialities = snapshot.data.data.specialty;
              specialities.forEach((element) {
                specialityList.add(element.name);
              });

              selectedSpeciality = specialityList[0];

              specialities.forEach(
                (element) {
                  if (element.name == selectedSpeciality) {
                    selectedSpecialityId = '${element.id}';
                  }
                },
              );

              DoctorRegisterationPage.doctorRequest.hospitals[0].city =
                  num.parse(selectedCityId);
              DoctorRegisterationPage.doctorRequest.hospitals[0].governorate =
                  num.parse(selectedGovernorateId);

              DoctorRegisterationPage.doctorRequest.hospitals[0].categoryId =
                  int.parse(selectedSpecialityId);

              gotData = true;
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                AppLocalization.of(context).translate('hospital_info'),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('hospital_name'),
                onChanged: (String input) {
                  DoctorRegisterationPage.doctorRequest.hospitals[0].title =
                      input;
                },
              ),
              Text(
                AppLocalization.of(context).translate('select_specialization'),
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
                    value: selectedSpeciality,
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.grey,
                      size: 26,
                    ),
                    items: specialityList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (result) {
                      selectedSpeciality = result;
                      var specialityList = snapshot.data.data.specialty;
                      String id;
                      specialityList.forEach(
                        (element) {
                          if (selectedSpeciality == element.name) {
                            id = element.id.toString();
                          }
                        },
                      );

                      DoctorRegisterationPage.doctorRequest.hospitals[0]
                          .categoryId = int.parse(id);

                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('mobile_number'),
                keyboardType: TextInputType.phone,
                onChanged: (String input) {
                  DoctorRegisterationPage.doctorRequest.hospitals[0].phone =
                      int.parse(input);
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('description'),
                maxLines: 5,
                onChanged: (String input) {
                  DoctorRegisterationPage
                      .doctorRequest.hospitals[0].description = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
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
                          snapshot.data.data.country.governorates.firstWhere(
                        (element) => element.name == selectedGovernorate,
                      );

                      selectedGovernorateId = currentGovernorate.id.toString();
                      DoctorRegisterationPage.doctorRequest.hospitals[0]
                          .governorate = int.parse(selectedGovernorateId);

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
                          snapshot.data.data.country.governorates.firstWhere(
                        (element) => element.name == selectedGovernorate,
                      );

                      currentGovernorate.cities.forEach((element) {
                        if (element.name == selectedCity) {
                          selectedCityId = element.id.toString();
                        }
                      });

                      DoctorRegisterationPage.doctorRequest.hospitals[0].city =
                          int.parse(selectedCityId);

                      setState(() {});
                    },
                  ),
                ),
              ),
              Text(
                '',
                style: TextStyle(color: Colors.red),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('address'),
                onChanged: (String input) {
                  DoctorRegisterationPage.doctorRequest.hospitals[0].address =
                      input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              MyUploadImageButton(
                title: translate(context, 'cover_image'),
                result: coverImageResult,
                onTap: () async {
                  var selectedImage = await AppUtils.getImage(1);
                  if (selectedImage != null) {
                    var path = await FlutterAbsolutePath.getAbsolutePath(
                      selectedImage[0].identifier,
                    );

                    coverImage = File(path);
                    DoctorRegisterationPage
                        .doctorRequest.hospitals[0].coverImage = coverImage;

                    String name = basename(path);
                    coverImageResult = name;
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              MyUploadImageButton(
                title: translate(context, 'logo_image'),
                result: profileImageResult,
                onTap: () async {
                  var selectedImage = await AppUtils.getImage(1);
                  if (selectedImage != null) {
                    var path = await FlutterAbsolutePath.getAbsolutePath(
                      selectedImage[0].identifier,
                    );

                    logoImage = File(path);
                    DoctorRegisterationPage.doctorRequest.hospitals[0].logo =
                        logoImage;

                    String name = basename(path);
                    profileImageResult = name;
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              MyUploadImageButton(
                title: translate(context, 'photos'),
                result: photosResult,
                onTap: () async {
                  List<Asset> resultList = await AppUtils.getImage(10);
                  if (resultList != null) {
                    photos.clear();
                    for (int i = 0; i < resultList.length; i++) {
                      photos.add(
                        File(
                          await FlutterAbsolutePath.getAbsolutePath(
                            resultList[i].identifier,
                          ),
                        ),
                      );
                    }

                    DoctorRegisterationPage.doctorRequest.hospitals[0].gallery =
                        photos;
                    photosResult =
                        '${photos.length} ${photos.length == 1 ? '${translate(context, 'image')}' : '${translate(context, 'images')}'}';
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              photos.isEmpty
                  ? SizedBox.shrink()
                  : Container(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(90),
                      margin: EdgeInsets.only(
                        left:
                            Localizations.localeOf(context).languageCode == 'en'
                                ? 8
                                : 0,
                        right:
                            Localizations.localeOf(context).languageCode == 'en'
                                ? 0
                                : 8,
                      ),
                      child: ListView.builder(
                        physics: bouncingScrollPhysics,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(100),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.file(
                                  photos[index],
                                  fit: BoxFit.fill,
                                ),
                                margin: EdgeInsets.only(right: 8),
                              ),
                              Positioned(
                                right: 5,
                                top: -8,
                                child: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    photos.removeAt(index);
                                    if (photos.isEmpty) {
                                      photosResult = '';
                                    } else {
                                      photosResult =
                                          '${photos.length} ${photos.length == 1 ? '${translate(context, 'image')}' : '${translate(context, 'images')}'}';
                                    }

                                    DoctorRegisterationPage
                                        .doctorRequest.hospitals[0].gallery
                                        .removeAt(index);

                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: photos.length,
                      ),
                    ),
              SizedBox(
                height: ScreenUtil().setHeight(4),
              ),
              Text(
                translate(context, 'working_days'),
                style: TextStyle(color: Colors.grey),
              ),
              WeekdaySelector(
                elevation: 4,
                onChanged: (int day) {
                  if (day == 1) {
                    DoctorRegisterationPage.doctorRequest.hospitals[0]
                        .workingDays.monday = !values[0] ? 1 : 0;
                  }
                  if (day == 2) {
                    DoctorRegisterationPage.doctorRequest.hospitals[0]
                        .workingDays.tuesday = !values[0] ? 1 : 0;
                  }
                  if (day == 3) {
                    DoctorRegisterationPage.doctorRequest.hospitals[0]
                        .workingDays.wednesday = !values[0] ? 1 : 0;
                  }
                  if (day == 4) {
                    DoctorRegisterationPage.doctorRequest.hospitals[0]
                        .workingDays.thursday = !values[0] ? 1 : 0;
                  }
                  if (day == 5) {
                    DoctorRegisterationPage.doctorRequest.hospitals[0]
                        .workingDays.friday = !values[0] ? 1 : 0;
                  }
                  if (day == 6) {
                    DoctorRegisterationPage.doctorRequest.hospitals[0]
                        .workingDays.saturday = !values[0] ? 1 : 0;
                  }
                  if (day == 7) {
                    DoctorRegisterationPage.doctorRequest.hospitals[0]
                        .workingDays.sunday = !values[0] ? 1 : 0;
                  }
                  setState(
                    () {
                      final index = day % 7;
                      values[index] = !values[index];
                    },
                  );
                },
                values: values,
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyTimePicker(
                      title: AppLocalization.of(context).translate('open_in'),
                      onTimeSelected: (String time, TimeOfDay timeOfDay) {
                        final localizations = MaterialLocalizations.of(context);
                        final formattedTimeOfDay =
                            localizations.formatTimeOfDay(timeOfDay,
                                alwaysUse24HourFormat: true);

                        print("format    =====>>> ");
                        print(formattedTimeOfDay);

                        DoctorRegisterationPage.doctorRequest.hospitals[0]
                            .openAt = '${formattedTimeOfDay}:00';
                      },
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(16),
                  ),
                  Expanded(
                    child: MyTimePicker(
                      title: AppLocalization.of(context).translate('close_in'),
                      onTimeSelected: (String time, TimeOfDay timeOfDay) {
                        final localizations = MaterialLocalizations.of(context);
                        final formattedTimeOfDay =
                            localizations.formatTimeOfDay(timeOfDay,
                                alwaysUse24HourFormat: true);

                        print("format    =====>>> ");
                        print(formattedTimeOfDay);

                        DoctorRegisterationPage.doctorRequest.hospitals[0]
                            .closingAt = '${formattedTimeOfDay}:00';
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(25),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyTextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (String input) {
                        DoctorRegisterationPage.doctorRequest.hospitals[0]
                            .regularPrice = num.parse(input);
                      },
                      title: AppLocalization.of(context)
                          .translate('regular_price'),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(16),
                  ),
                  Expanded(
                    child: MyTextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (String input) {
                        DoctorRegisterationPage.doctorRequest.hospitals[0]
                            .urgentPrice = num.parse(input);
                      },
                      title:
                          AppLocalization.of(context).translate('urgent_price'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              Text(
                '(${AppLocalization.of(context).translate('you_must_at_least_add_one_clinic')})',
                style: TextStyle(color: deepBlueColor),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              ListView.separated(
                itemBuilder: (context, index) {
                  return workshopsList[index];
                },
                itemCount: workshopsList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: ScreenUtil().setHeight(15),
                  );
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(20),
              ),
              FlatButton(
                onPressed: () {
                  DoctorRegisterationPage.doctorRequest.hospitals[0].clinics
                      .add(Clinics()..workingDays = WorkingDays());
                  workshopsList.add(
                    workshopForm(
                      context,
                      workshopsList.length,
                      onDeleteBtnTapped: (int index) {
                        DoctorRegisterationPage
                            .doctorRequest.hospitals[0].clinics
                            .removeAt(index);
                        workshopsList.removeAt(index);
                        setState(() {});
                      },
                    ),
                  );
                  setState(() {});
                },
                padding: EdgeInsets.zero,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: deepBlueColor,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalization.of(context)
                          .translate('add_another_clinic_+'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(30),
              ),
              myButton(
                AppLocalization.of(context).translate('next'),
                btnColor: mainColor,
                onTap: () async {
                  await validateAndContinue(snapshot, context);
                  setState(() {});
                },
              ),
            ],
          );
        }
      },
    );
  }

  Widget workshopForm(BuildContext context, int index, {Function(int) onDeleteBtnTapped}) {
    // We start with all days selected.
    final values = List.filled(7, false);

    List<String> governoratesList = [];
    List<String> cityList = [];
    List<String> specialityList = [];

    List<LangClinic> langs = [];
    langs.add(
      LangClinic(
        lang: AppUtils.language,
      ),
    );

    String selectedGovernorate = '';
    String selectedGovernorateId = '';
    String selectedCity = '';
    String selectedCityId = '';
    String coverImageResult = '';
    String profileImageResult = '';
    String photosResult = '';
    String selectedSpeciality = '';

    List<File> photos = [];
    File coverImage;
    File logoImage;

    DoctorRegisterationPage
        .doctorRequest.hospitals[0].clinics[index].workingDays.saturday = 0;
    DoctorRegisterationPage
        .doctorRequest.hospitals[0].clinics[index].workingDays.sunday = 0;
    DoctorRegisterationPage
        .doctorRequest.hospitals[0].clinics[index].workingDays.monday = 0;
    DoctorRegisterationPage
        .doctorRequest.hospitals[0].clinics[index].workingDays.tuesday = 0;
    DoctorRegisterationPage
        .doctorRequest.hospitals[0].clinics[index].workingDays.wednesday = 0;
    DoctorRegisterationPage
        .doctorRequest.hospitals[0].clinics[index].workingDays.thursday = 0;
    DoctorRegisterationPage
        .doctorRequest.hospitals[0].clinics[index].workingDays.friday = 0;

    var _bloc = doctorBloc.doctorCreateDetails.value.data;

    _bloc.country.governorates.forEach((element) {
      governoratesList.add(element.name);
    });

    selectedGovernorate = governoratesList[0];

    var currentGovernment = _bloc.country.governorates
        .firstWhere((element) => element.name == selectedGovernorate);
    currentGovernment.cities.forEach((element) {
      cityList.add(element.name);
    });

    selectedCity = cityList[0];

    selectedGovernorateId = currentGovernment.id.toString();

    currentGovernment.cities.forEach(
      (element) {
        if (element.name == selectedCity) {
          selectedCityId = element.id.toString();
        }
      },
    );

    DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[index].city =
        num.parse(selectedCityId);
    DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[index]
        .governorate = num.parse(selectedGovernorateId);

    var specialities = doctorBloc.doctorCreateDetails.value.data.specialty;

    specialities.forEach((element) {
      specialityList.add(element.name);
    });

    selectedSpeciality = specialityList[0];

    specialities.forEach((element) {
      if (selectedSpeciality == element.name) {
        selectedSpecialityId = element.id.toString();
      }
    });

    return StatefulBuilder(
      builder: (context, setState) => Card(
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(0),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              index != 0
                  ? Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          onDeleteBtnTapped(index);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              Text(
                '${translate(context, 'clinic')} #${index + 1}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(12),
              ),
              MyTextFormField(
                title: translate(context, 'title'),
                onChanged: (String input) {
                  DoctorRegisterationPage
                      .doctorRequest.hospitals[0].clinics[index].title = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(4),
              ),
              Text(
                AppLocalization.of(context).translate('select_specialization'),
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
                    value: selectedSpeciality,
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.grey,
                      size: 26,
                    ),
                    items: specialityList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (result) {
                      selectedSpeciality = result;
                      var specialityList =
                          doctorBloc.doctorCreateDetails.value.data.specialty;

                      String id;
                      specialityList.forEach((element) {
                        if (selectedSpeciality == element.name) {
                          id = element.id.toString();
                        }
                      });

                      DoctorRegisterationPage.doctorRequest.hospitals[0]
                          .clinics[index].categoryId = int.parse(id);

                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              MyTextFormField(
                title: '${translate(context, 'phone')}',
                keyboardType: TextInputType.phone,
                onChanged: (String input) {
                  DoctorRegisterationPage.doctorRequest.hospitals[0]
                      .clinics[index].phone = int.parse(input);
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('description'),
                maxLines: 5,
                onChanged: (String input) {
                  print("ui description --- >>>  " + input);
                  print("ui description --- >>>  " +
                      DoctorRegisterationPage.doctorRequest.hospitals[0]
                          .clinics[index].description);
                  DoctorRegisterationPage.doctorRequest.hospitals[0]
                      .clinics[index].description = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('email'),
                onChanged: (String input) {
                  DoctorRegisterationPage
                      .doctorRequest.hospitals[0].clinics[index].email = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyTextFormField(
                title: AppLocalization.of(context).translate('website'),
                onChanged: (String input) {
                  DoctorRegisterationPage.doctorRequest.hospitals[0]
                      .clinics[index].website = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              MyUploadImageButton(
                title: '${translate(context, 'cover_image')}',
                result: coverImageResult,
                onTap: () async {
                  var selectedImage = await AppUtils.getImage(1);
                  if (selectedImage != null) {
                    var path = await FlutterAbsolutePath.getAbsolutePath(
                      selectedImage[0].identifier,
                    );

                    coverImage = File(path);
                    DoctorRegisterationPage.doctorRequest.hospitals[0]
                        .clinics[index].coverImage = coverImage;

                    String name = basename(path);
                    coverImageResult = name;
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              MyUploadImageButton(
                title: '${translate(context, 'logo_image')}',
                result: profileImageResult,
                onTap: () async {
                  var selectedImage = await AppUtils.getImage(1);
                  if (selectedImage != null) {
                    var path = await FlutterAbsolutePath.getAbsolutePath(
                      selectedImage[0].identifier,
                    );

                    logoImage = File(path);
                    DoctorRegisterationPage.doctorRequest.hospitals[0]
                        .clinics[index].logo = logoImage;

                    String name = basename(path);
                    profileImageResult = name;
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              MyUploadImageButton(
                title: translate(context, 'photos'),
                result: photosResult,
                onTap: () async {
                  List<Asset> resultList = await AppUtils.getImage(10);
                  if (resultList != null) {
                    photos.clear();
                    for (int i = 0; i < resultList.length; i++) {
                      photos.add(
                        File(
                          await FlutterAbsolutePath.getAbsolutePath(
                            resultList[i].identifier,
                          ),
                        ),
                      );
                    }

                    DoctorRegisterationPage.doctorRequest.hospitals[0]
                        .clinics[index].gallery = photos;
                    photosResult =
                        '${photos.length} ${photos.length == 1 ? '${translate(context, 'image')}' : '${translate(context, 'images')}'}';
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              photos.isEmpty
                  ? SizedBox.shrink()
                  : Container(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(90),
                      margin: EdgeInsets.only(
                        left:
                            Localizations.localeOf(context).languageCode == 'en'
                                ? 8
                                : 0,
                        right:
                            Localizations.localeOf(context).languageCode == 'en'
                                ? 0
                                : 8,
                      ),
                      child: ListView.builder(
                        physics: bouncingScrollPhysics,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(100),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.file(
                                  photos[index],
                                  fit: BoxFit.fill,
                                ),
                                margin: EdgeInsets.only(right: 8),
                              ),
                              Positioned(
                                right: 5,
                                top: -8,
                                child: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    photos.removeAt(index);
                                    if (photos.isEmpty) {
                                      photosResult = '';
                                    } else {
                                      photosResult =
                                          '${photos.length} ${photos.length == 1 ? '${translate(context, 'image')}' : '${translate(context, 'images')}'}';
                                    }

                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: photos.length,
                      ),
                    ),
              SizedBox(
                height: ScreenUtil().setWidth(15),
              ),
              Text(
                translate(context, 'working_days'),
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(4),
              ),
              WeekdaySelector(
                elevation: 4,
                onChanged: (int day) {
                  if (day == 1) {
                    DoctorRegisterationPage.doctorRequest.hospitals[index]
                        .workingDays.monday = !values[index] ? 1 : 0;
                  }
                  if (day == 2) {
                    DoctorRegisterationPage.doctorRequest.hospitals[index]
                        .workingDays.tuesday = !values[index] ? 1 : 0;
                  }
                  if (day == 3) {
                    DoctorRegisterationPage.doctorRequest.hospitals[index]
                        .workingDays.wednesday = !values[index] ? 1 : 0;
                  }
                  if (day == 4) {
                    DoctorRegisterationPage.doctorRequest.hospitals[index]
                        .workingDays.thursday = !values[index] ? 1 : 0;
                  }
                  if (day == 5) {
                    DoctorRegisterationPage.doctorRequest.hospitals[index]
                        .workingDays.friday = !values[index] ? 1 : 0;
                  }
                  if (day == 6) {
                    DoctorRegisterationPage.doctorRequest.hospitals[index]
                        .workingDays.saturday = !values[index] ? 1 : 0;
                  }
                  if (day == 7) {
                    DoctorRegisterationPage.doctorRequest.hospitals[index]
                        .workingDays.sunday = !values[index] ? 1 : 0;
                  }
                  setState(
                    () {
                      final index = day % 7;
                      values[index] = !values[index];
                    },
                  );
                },
                values: values,
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyTimePicker(
                      title: AppLocalization.of(context).translate('open_in'),
                      onTimeSelected: (String time, TimeOfDay timeOfDay) {
                        //TimeOfDayFormat.h_colon_mm_space_a();

                        final localizations = MaterialLocalizations.of(context);
                        final formattedTimeOfDay =
                            localizations.formatTimeOfDay(timeOfDay,
                                alwaysUse24HourFormat: true);

                        print("format    =====>>> ");
                        print(formattedTimeOfDay);

                        DoctorRegisterationPage.doctorRequest.hospitals[0]
                            .clinics[index].openAt = '${formattedTimeOfDay}:00';
                      },
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(16),
                  ),
                  Expanded(
                    child: MyTimePicker(
                      title: AppLocalization.of(context).translate('close_in'),
                      onTimeSelected: (String time, TimeOfDay timeOfDay) {
                        final localizations = MaterialLocalizations.of(context);
                        final formattedTimeOfDay =
                            localizations.formatTimeOfDay(timeOfDay,
                                alwaysUse24HourFormat: true);

                        print("format    =====>>> ");
                        print(formattedTimeOfDay);

                        DoctorRegisterationPage
                            .doctorRequest
                            .hospitals[0]
                            .clinics[index]
                            .closingAt = '${formattedTimeOfDay}:00';
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyTextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (String input) {
                        DoctorRegisterationPage.doctorRequest.hospitals[0]
                            .clinics[index].regularPrice = num.parse(input);
                      },
                      title: AppLocalization.of(context)
                          .translate('regular_price'),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(16),
                  ),
                  Expanded(
                    child: MyTextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (String input) {
                        DoctorRegisterationPage.doctorRequest.hospitals[0]
                            .clinics[index].urgentPrice = num.parse(input);
                      },
                      title:
                          AppLocalization.of(context).translate('urgent_price'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(15),
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
                          _bloc.country.governorates.firstWhere(
                        (element) => element.name == selectedGovernorate,
                      );

                      selectedGovernorateId = currentGovernorate.id.toString();

                      cityList.clear();
                      currentGovernorate.cities.forEach((element) {
                        cityList.add(element.name);
                      });

                      selectedCity = cityList[0];

                      DoctorRegisterationPage.doctorRequest.hospitals[index]
                          .city = num.parse(selectedCityId);
                      DoctorRegisterationPage.doctorRequest.hospitals[index]
                          .governorate = num.parse(selectedGovernorateId);

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
                          _bloc.country.governorates.firstWhere(
                        (element) => element.name == selectedGovernorate,
                      );

                      currentGovernorate.cities.forEach((element) {
                        if (element.name == selectedCity) {
                          selectedCityId = element.id.toString();
                        }
                      });

                      DoctorRegisterationPage.doctorRequest.hospitals[index]
                          .city = num.parse(selectedCityId);
                      DoctorRegisterationPage.doctorRequest.hospitals[index]
                          .governorate = num.parse(selectedGovernorateId);

                      setState(() {});
                    },
                  ),
                ),
              ),
              Text(
                '',
                style: TextStyle(color: Colors.red),
              ),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 60,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              if (index == 0) return;
                              List<LangClinic> addedLangs =
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddClinicLangPage(
                                    title: langs[index].title,
                                    address: langs[index].address,
                                    lang: langs[index].lang,
                                    description: langs[index].description,
                                  ),
                                ),
                              );
                              if (addedLangs != null && addedLangs.isNotEmpty) {
                                langs.addAll(addedLangs);
                                setState(() {});
                              }
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              margin: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: mainColor,
                              ),
                              child: Center(
                                child: Text(
                                  langs[index].lang,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: langs.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: langs.length >= 2 ? null : () async {
                      List<LangClinic> addedLangs = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddClinicLangPage(),
                        ),
                      );
                      if (addedLangs != null && addedLangs.isNotEmpty) {
                        langs.addAll(addedLangs);
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: mainColor,
                      ),
                      child: Center(
                        child: Text(
                          translate(context, 'add_another_language'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  Future<void> validateAndContinue(AsyncSnapshot<DoctorDetailsCreateResponse> snapshot, BuildContext context) {
    if (DoctorRegisterationPage.doctorRequest.hospitals[0].title == null) {
      AppUtils.showToast(msg: translate(context, 'enter_hospital_name'));
    }
    if (DoctorRegisterationPage.doctorRequest.hospitals[0].description == null) {
      AppUtils.showToast(msg: translate(context, 'enter_description_of_you'));
    }
    if (DoctorRegisterationPage.doctorRequest.hospitals[0].phone == null) {
      AppUtils.showToast(msg: translate(context, 'enter_mobile_number_of'));
    }
    if (DoctorRegisterationPage.doctorRequest.hospitals[0].address == null) {
      AppUtils.showToast(msg: translate(context, 'enter_the_address_of'));
    }
    if (DoctorRegisterationPage.doctorRequest.hospitals[0].coverImage == null) {
      AppUtils.showToast(msg: translate(context, 'select_cover_image'));
    }
    if (DoctorRegisterationPage.doctorRequest.hospitals[0].logo == null) {
      AppUtils.showToast(msg: translate(context, 'select_logo_image'));
    }
    if (DoctorRegisterationPage.doctorRequest.hospitals[0].gallery == null) {
      AppUtils.showToast(msg: translate(context, 'select_photos_of'));
    }

    // clinics
    for (int i = 0; i < DoctorRegisterationPage.doctorRequest.hospitals[0].clinics.length; i++) {
      if (DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[i].title == null) {
        AppUtils.showToast(msg: '${translate(context, 'enter_the_title_of')} ${i + 1} ${translate(context, 'clinic')}');
      }
      else if (DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[i].coverImage == null) {
        AppUtils.showToast(msg: '${translate(context, 'select_cover_image')} ${i + 1} ${translate(context, 'clinic')}');
      }
      else if (DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[i].logo ==
          null) {
        AppUtils.showToast(msg: '${translate(context, 'select_logo_image')}  ${i + 1} ${translate(context, 'clinic')}');
      }
      else if (DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[i].gallery == null) {
        AppUtils.showToast(msg: '${translate(context, 'select_photos_of')} ${i + 1} ${translate(context, 'clinic')}');
      }
      else if (DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[i].regularPrice == null) {
        AppUtils.showToast(msg: '${translate(context, 'determine_regular_price')} ${i + 1} ${translate(context, 'clinic')}');
      }
      else if (DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[i].urgentPrice == null) {
        AppUtils.showToast(msg: '${translate(context, 'determine_urgent_price')} ${i + 1} ${translate(context, 'clinic')}');
      }
      else if (DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[i].phone == null) {
        AppUtils.showToast(msg: '${translate(context, 'enter_mobile_number_of')} ${i + 1} ${translate(context, 'clinic')}');
      }
      else if (DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[i].email != '') {
        if (!PatternUtils.emailIsValid(email: DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[i].email)) {
          AppUtils.showToast(msg: '${translate(context, 'enter_valid_email')} ${i + 1} ${translate(context, 'clinic')}');
        }
      }
      else if (DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[i].website != '') {
        if (!PatternUtils.urlIsValid(url: DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[i].website)) {
          AppUtils.showToast(msg: '${translate(context, 'enter_valid_url')} ${i + 1} ${translate(context, 'clinic')}');
        }
      }
      else if (DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[i].openAt == null) {
        AppUtils.showToast(msg: '${translate(context, 'enter_time_of_opining')} ${i + 1} ${translate(context, 'clinic')}');
      }
      else if (DoctorRegisterationPage.doctorRequest.hospitals[0].clinics[i].openAt == null) {
        AppUtils.showToast(msg: '${translate(context, 'enter_time_of_closing')} ${i + 1} ${translate(context, 'clinic')}');
      }
    }

    DoctorRegisterationPageState.currentIndicatorNumber = (3);
    setState(() {});
  }
}
