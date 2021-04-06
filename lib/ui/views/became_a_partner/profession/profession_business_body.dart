import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/froms/ProffessionsFormRequest.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionCreateDetailsResponse.dart';
import 'package:phinex/Bles/bloc/professions/Professions.dart';
import 'package:phinex/providers/profession_provider.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/ui/widgets/my_time_picker.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';
import 'package:weekday_selector/weekday_selector.dart';

import 'add_profession_workshop_lang_page.dart';
import 'profession_registeration_page.dart';

class ProfessionBusinessBody extends StatefulWidget {
  @override
  _ProfessionBusinessBodyState createState() => _ProfessionBusinessBodyState();
}

class _ProfessionBusinessBodyState extends State<ProfessionBusinessBody> {
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

  bool gotData = false;
  bool fillForm = false;

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProfessionCreateDetailsResponse>(
      stream: professionsBloc.professionCreateDetails.stream,
      builder: (context, snapshot) {
        if (professionsBloc.loading.value) {
          return Loader();
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            if (!gotData) {
              // initialize hospitals
              ProfessionRegisterationPage.professionRequest.workshops = [];
              ProfessionRegisterationPage.professionRequest.workshops
                  .add(WorkshopsBean());

              ProfessionRegisterationPage.professionRequest.workshops[0].lat =
                  double.parse(LATITUDE);

              ProfessionRegisterationPage.professionRequest.workshops[0].long =
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

              ProfessionRegisterationPage.professionRequest.workshops[0].city =
                  num.parse(selectedCityId);
              ProfessionRegisterationPage.professionRequest.workshops[0]
                  .governorate = num.parse(selectedGovernorateId);

              gotData = true;
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  ProfessionRegisterationPage.professionRequest.workshops
                      .add(WorkshopsBean());
                  workshopsList.add(
                    workshopForm(
                      context,
                      workshopsList.length,
                      onDeleteBtnTapped: (int index) {
                        ProfessionRegisterationPage.professionRequest.workshops
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
                      translate(context, 'add_another_workshop_+'),
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
                onTap: () {
                  validateAndContinue(snapshot);
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

    String selectedGovernorate = '';
    String selectedGovernorateId = '';
    String selectedCity = '';
    String selectedCityId = '';

    List<LangWorkShopBean> langs = [];
    langs.add(
      LangWorkShopBean(
        lang: AppUtils.language,
      ),
    );

    ProfessionRegisterationPage
        .professionRequest.workshops[index].langWorkShops = [];
    ProfessionRegisterationPage
        .professionRequest.workshops[index].langWorkShops = langs;
    // ProfessionRegisterationPage.professionRequest.workshops[index].lang = ProfessionRegisterationPage.professionRequest.langs[0];

    ProfessionRegisterationPage.professionRequest.workshops[index].saturday = 0;
    ProfessionRegisterationPage.professionRequest.workshops[index].sunday = 0;
    ProfessionRegisterationPage.professionRequest.workshops[index].monday = 0;
    ProfessionRegisterationPage.professionRequest.workshops[index].tuesday = 0;
    ProfessionRegisterationPage.professionRequest.workshops[index].wednesday =
        0;
    ProfessionRegisterationPage.professionRequest.workshops[index].thursday = 0;
    ProfessionRegisterationPage.professionRequest.workshops[index].friday = 0;

    ProfessionRegisterationPage.professionRequest.workshops[index].lat =
        double.parse(LATITUDE);

    ProfessionRegisterationPage.professionRequest.workshops[index].long =
        double.parse(LONGITUDE);

    var _bloc = professionsBloc.professionCreateDetails.value.data;

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

    DateTime openFrom;
    DateTime openTo;

    currentGovernment.cities.forEach(
      (element) {
        if (element.name == selectedCity) {
          selectedCityId = element.id.toString();
        }
      },
    );

    ProfessionRegisterationPage.professionRequest.workshops[index].city =
        num.parse(selectedCityId);
    ProfessionRegisterationPage.professionRequest.workshops[index].governorate =
        num.parse(selectedGovernorateId);

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
                '${translate(context, 'workshop')} #${index + 1}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(12),
              ),
              MyTextFormField(
                title: translate(context, 'commercial_name'),
                onChanged: (String input) {
                  ProfessionRegisterationPage.professionRequest.workshops[index]
                      .langWorkShops[index].title = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(4),
              ),
              MyTextFormField(
                title: translate(context, 'description'),
                onChanged: (String input) {
                  ProfessionRegisterationPage.professionRequest.workshops[index]
                      .langWorkShops[index].description = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(4),
              ),
              MyTextFormField(
                title: translate(context, 'short_description'),
                onChanged: (String input) {
                  ProfessionRegisterationPage.professionRequest.workshops[index]
                      .langWorkShops[index].address = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(4),
              ),
              MyTextFormField(
                title: translate(context, 'phone'),
                keyboardType: TextInputType.phone,
                onChanged: (String input) {
                  ProfessionRegisterationPage.professionRequest.workshops[index]
                      .phone = int.parse(input);
                },
              ),
              SizedBox(
                height: ScreenUtil().setWidth(4),
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
                    ProfessionRegisterationPage.professionRequest
                        .workshops[index].monday = !values[index] ? 1 : 0;
                  }
                  if (day == 2) {
                    ProfessionRegisterationPage.professionRequest
                        .workshops[index].tuesday = !values[index] ? 1 : 0;
                  }
                  if (day == 3) {
                    ProfessionRegisterationPage.professionRequest
                        .workshops[index].wednesday = !values[index] ? 1 : 0;
                  }
                  if (day == 4) {
                    ProfessionRegisterationPage.professionRequest
                        .workshops[index].thursday = !values[index] ? 1 : 0;
                  }
                  if (day == 5) {
                    ProfessionRegisterationPage.professionRequest
                        .workshops[index].friday = !values[index] ? 1 : 0;
                  }
                  if (day == 6) {
                    ProfessionRegisterationPage.professionRequest
                        .workshops[index].saturday = !values[index] ? 1 : 0;
                  }
                  if (day == 7) {
                    ProfessionRegisterationPage.professionRequest
                        .workshops[index].sunday = !values[index] ? 1 : 0;
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
                        var minites = Duration(minutes: timeOfDay.minute);
                        List<String> parts = minites.toString().split(':');

                        var hours = Duration(hours: timeOfDay.hour);
                        List<String> parts2 = hours.toString().split(':');

                        ProfessionRegisterationPage.professionRequest.workshops[index].openFrom = '${parts2[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}:00';

                        openFrom = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            timeOfDay.hour,
                            timeOfDay.minute,
                        );
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
                        var minites = Duration(minutes: timeOfDay.minute);
                        List<String> parts = minites.toString().split(':');

                        var hours = Duration(hours: timeOfDay.hour);
                        List<String> parts2 = hours.toString().split(':');

                        openTo = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            timeOfDay.hour,
                            timeOfDay.minute,
                        );

                        if (openTo.isAfter(openFrom)) {
                          ProfessionRegisterationPage
                                  .professionRequest.workshops[index].openTo =
                              '${parts2[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}:00';
                        } else {
                          AppUtils.showToast(
                              msg: 'select time after start time');
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setWidth(25),
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

                      ProfessionRegisterationPage.professionRequest
                          .workshops[index].city = num.parse(selectedCityId);
                      ProfessionRegisterationPage
                          .professionRequest
                          .workshops[index]
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

                      ProfessionRegisterationPage.professionRequest
                          .workshops[index].city = num.parse(selectedCityId);
                      ProfessionRegisterationPage
                          .professionRequest
                          .workshops[index]
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
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 60,
                      child: ListView.builder(
                        itemBuilder: (context, index1) {
                          return GestureDetector(
                            onTap: () async {
                              if (index == 0) return;
                              print(ProfessionRegisterationPage
                                  .professionRequest.workshops[index]);
                              List<LangWorkShopBean> addedLangs =
                                  await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AddProfessionWorkshopLangPage(
                                    commercialName: ProfessionRegisterationPage
                                        .professionRequest
                                        .workshops[index]
                                        .langWorkShops[index1]
                                        .title,
                                    shortDescription:
                                        ProfessionRegisterationPage
                                            .professionRequest
                                            .workshops[index]
                                            .langWorkShops[index1]
                                            .address,
                                    lang: ProfessionRegisterationPage
                                        .professionRequest.langs[index].lang,
                                    description: ProfessionRegisterationPage
                                        .professionRequest
                                        .langs[index]
                                        .description,
                                  ),
                                ),
                              );
                              if (addedLangs != null && addedLangs.isNotEmpty) {
                                ProfessionRegisterationPage.professionRequest
                                    .workshops[index1].langWorkShops
                                    .addAll(addedLangs);
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
                                  ProfessionRegisterationPage
                                      .professionRequest
                                      .workshops[index]
                                      .langWorkShops[index1]
                                      .lang,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: ProfessionRegisterationPage.professionRequest
                            .workshops[index].langWorkShops.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: langs.length >= 2
                        ? null
                        : () async {
                            List<LangWorkShopBean> addedLangs =
                                await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddProfessionWorkshopLangPage(),
                              ),
                            );
                            if (addedLangs != null && addedLangs.isNotEmpty) {
                              ProfessionRegisterationPage.professionRequest
                                  .workshops[index].langWorkShops
                                  .addAll(addedLangs);
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
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateAndContinue(AsyncSnapshot<ProfessionCreateDetailsResponse> snapshot) {
    print(ProfessionRegisterationPage.professionRequest.workshops[0].toString());

    // working shop
    for (int i = 0; i < ProfessionRegisterationPage.professionRequest.workshops.length; i++) {

      if (ProfessionRegisterationPage.professionRequest.workshops[i].langWorkShops[i].title == null) {
        AppUtils.showToast(msg: '${translate(context, 'enter_the_title_of')} ${i + 1} ${translate(context, 'workshop')}');
        return;
      }
      if (ProfessionRegisterationPage.professionRequest.workshops[i].langWorkShops[i].address == null) {
        AppUtils.showToast(msg: '${translate(context, 'enter_the_title_of')} ${i + 1} ${translate(context, 'workshop')}');
        return;
      }
      if (ProfessionRegisterationPage.professionRequest.workshops[i].phone == null) {
        AppUtils.showToast(msg: '${translate(context, 'enter_mobile_number_of')} ${i + 1} ${translate(context, 'workshop')}');
        return;
      }
      if (ProfessionRegisterationPage.professionRequest.workshops[i].langWorkShops[i].description == null) {
        AppUtils.showToast(msg: '${translate(context, 'enter_description_of_you')} ${i + 1} ${translate(context, 'workshop')}');
        return;
      }
      if (ProfessionRegisterationPage.professionRequest.workshops[i].openFrom == null) {
        AppUtils.showToast(msg: '${translate(context, 'enter_time_of_opining')}  ${i + 1} ${translate(context, 'workshop')}');
        return;
      }
      if (ProfessionRegisterationPage.professionRequest.workshops[i].openTo == null) {
        AppUtils.showToast(msg: '${translate(context, 'enter_time_of_cloning')}  ${i + 1} ${translate(context, 'workshop')}');
        return;
      }
    }

    professionProvider.setCurrentIndicatorNumber(3);
  }
}
