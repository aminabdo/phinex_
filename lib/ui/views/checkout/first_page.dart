import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/utils/app_localization.dart';

import 'checkout_pointer.dart';

class StepOne extends StatefulWidget {
  @override
  _StepOneState createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  int selected = 1;
  String selectedDate = '';

  @override
  void initState() {
    super.initState();

    CheckoutPointer.selectedDeliveryState = selected;
  }

  void onOptionChanged(int value) async {
    selected = value;
    if (value == 3) {
      await getDate();
    } else {
      selectedDate = '';
    }

    setState(() {});
  }

  getDate() async {
    DateTime theSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (theSelectedDate != null) {
      selectedDate = '${DateTimeFormat.format(theSelectedDate, format: AmericanDateFormats.dayOfWeek)}';
      CheckoutPointer.selectedDate = selectedDate;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            AppLocalization.of(context).translate('standard_delivery'),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          onTap: () {
            onOptionChanged(1);
          },
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Text(
                AppLocalization.of(context).translate('standard_delivery_msg'),
              ),
            ],
          ),
          trailing: Radio(
            value: 1,
            groupValue: selected,
            onChanged: onOptionChanged,
          ),
        ),
        // SizedBox(
        //   height: ScreenUtil().setHeight(15),
        // ),
        // ListTile(
        //   title: Text(
        //     AppLocalization.of(context).translate('next_day_delivery'),
        //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        //   ),
        //   onTap: () {
        //     onOptionChanged(2);
        //   },
        //   subtitle: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       SizedBox(
        //         height: ScreenUtil().setHeight(10),
        //       ),
        //       Text(
        //         AppLocalization.of(context).translate('next_day_delivery_msg'),
        //       ),
        //     ],
        //   ),
        //   trailing: Radio(
        //     value: 2,
        //     groupValue: selected,
        //     onChanged: onOptionChanged,
        //   ),
        // ),
        // SizedBox(
        //   height: ScreenUtil().setHeight(15),
        // ),
        // ListTile(
        //   title: Text(
        //     AppLocalization.of(context).translate('nominated_delivery'),
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 18,
        //     ),
        //   ),
        //   onTap: () {
        //     onOptionChanged(3);
        //   },
        //   subtitle: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       SizedBox(
        //         height: ScreenUtil().setHeight(10),
        //       ),
        //       Text(
        //         AppLocalization.of(context).translate('nominated_delivery_msg',),
        //       ),
        //     ],
        //   ),
        //   trailing: Radio(
        //     value: 3,
        //     groupValue: selected,
        //     onChanged: onOptionChanged,
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
          child: Text(
            selectedDate == '' ? '' : '$selectedDate',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
