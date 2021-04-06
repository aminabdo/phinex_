import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'doctor_clinic_form.dart';
import 'doctor_hospital_form.dart';

class DoctorBusinessBody extends StatefulWidget {
  @override
  _DoctorBusinessBodyState createState() => _DoctorBusinessBodyState();
}

class _DoctorBusinessBodyState extends State<DoctorBusinessBody> {
  bool isHospital = true;
  bool isClinic = false;
  bool isLab = false;
  bool isSpa = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            serviceType(
             AppLocalization.of(context).translate('hospital'),
              'assets/images/hospital_medical_center.png',
              isHospital,
              onTap: () {
                isHospital = true;
                isClinic = false;
                isLab = false;
                isSpa = false;
                setState(() {});
              },
            ),
            serviceType(
              AppLocalization.of(context).translate('private_clinic'),
              'assets/images/clinic.png',
              isClinic,
              onTap: () {
                isHospital = false;
                isClinic = true;
                isLab = false;
                isSpa = false;
                setState(() {});
              },
            ),
            serviceType(
              AppLocalization.of(context).translate('lab'),
              'assets/images/laboratory.png',
              isLab,
              onTap: () {
                isHospital = false;
                isClinic = false;
                isLab = true;
                isSpa = false;
                setState(() {});
              },
            ),
            serviceType(
              AppLocalization.of(context).translate('spa'),
              'assets/images/spa.png',
              isSpa,
              onTap: () {
                isHospital = false;
                isClinic = false;
                isLab = false;
                isSpa = true;
                setState(() {});
              },
            ),
          ],
        ),
        isHospital ? DoctorHospitalForm() : DoctorClinicForm(id: isClinic ? 0 : isLab ? 1 : 2,),
      ],
    );
  }

  Widget serviceType(String title, String imagePath, bool isSelected, {Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            color: isSelected ? mainColor : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
                vertical: ScreenUtil().setHeight(10),
              ),
              child: Container(
                height: ScreenUtil().setHeight(35),
                width: ScreenUtil().setWidth(35),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      imagePath,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
