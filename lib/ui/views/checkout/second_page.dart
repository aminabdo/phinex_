import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/general/GeneralModelGovResponse.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/ui/views/checkout/checkout_pointer.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

class StepTwo extends StatefulWidget {
  @override
  _StepTwoState createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  bool useSameAddress = false;

  String street1 = '';
  String street2 = '';

  String selectedGovernorate = '';
  String selectedGovernorateId = '';
  String selectedCity = '';
  String selectedCityId = '';
  String profileImageResult = '';
  String selectedCategory = '';

  List<String> governoratesList = [];
  List<String> cityList = [];
  List<String> categoriesList = [];

  bool gotData = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GeneralModelGovResponse>(
      stream: generalBloc.generalGovModel.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data != null) {
          if(!gotData) {
            gotData = true;

            snapshot.data.data.governorates.forEach((element) {
              governoratesList.add(element.name);
            });

            selectedGovernorate = governoratesList[0];

            var government = snapshot.data.data.governorates.firstWhere((element) => element.name == selectedGovernorate);
            government.cities.forEach((element) {
              cityList.add(element.name);
            });

            selectedCity = cityList[0];

            var currentGovernorate =
            snapshot.data.data.governorates.firstWhere((element) => element.name == selectedGovernorate,);

            selectedGovernorateId = currentGovernorate.id.toString();

            currentGovernorate.cities.forEach((element) {
                if (element.name == selectedCity) {
                  selectedCityId = element.id.toString();
                }
              },
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              // ListTile(
              //   onTap: () {
              //     useSameAddress = !useSameAddress;
              //     if (useSameAddress) {
              //       CheckoutPointer.address = 'address';
              //     } else {
              //       CheckoutPointer.address = null;
              //     }
              //     setState(() {});
              //   },
              //   title: Text('Billing address is the same as delivery address'),
              //   leading: GestureDetector(
              //     onTap: () {
              //       useSameAddress = !useSameAddress;
              //       if (useSameAddress) {
              //         CheckoutPointer.address = 'address';
              //       } else {
              //         CheckoutPointer.address = null;
              //       }
              //       setState(() {});
              //     },
              //     child: Container(
              //       width: ScreenUtil().setWidth(35),
              //       height: ScreenUtil().setHeight(35),
              //       padding: EdgeInsets.all(5),
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: deepBlueColor,
              //       ),
              //       child: useSameAddress
              //           ? Center(
              //         child: Icon(
              //           Icons.check,
              //           color: Colors.white,
              //         ),
              //       )
              //           : SizedBox.shrink(),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: ScreenUtil().setHeight(25),
              // ),
              MyTextFormField(
                enabled: !useSameAddress,
                hintText: AppLocalization.of(context).translate('street_1'),
                title: AppLocalization.of(context).translate('street_1'),
                onChanged: (String input) {
                  CheckoutPointer.address = input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              MyTextFormField(
                enabled: !useSameAddress,
                hintText: AppLocalization.of(context).translate('street_2'),
                title: AppLocalization.of(context).translate('street_2'),
                onChanged: (String input) {
                  CheckoutPointer.address += input;
                },
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(12),
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
                      snapshot.data.data.governorates.firstWhere((element) => element.name == selectedGovernorate,);

                      selectedGovernorateId = currentGovernorate.id.toString();

                      CheckoutPointer.governorate = int.parse(selectedGovernorateId.toString());

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
              SizedBox(
                height: 8,
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
                      selectedCity = newValue;var currentGovernorate = snapshot.data.data.governorates.firstWhere(
                            (element) => element.name == selectedGovernorate,);

                      currentGovernorate.cities.forEach((element) {
                        if (element.name == selectedCity) {
                          selectedCityId = element.id.toString();
                          CheckoutPointer.city = int.parse(selectedCityId.toString());
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
                height: 8,
              ),
            ],
          );
        } else {
          return Loader();
        }
      }
    );
  }
}
