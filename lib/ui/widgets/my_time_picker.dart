import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class MyTimePicker extends StatefulWidget {
  final String title;
  final TextStyle titleStyle;
  final Function(String, TimeOfDay) onTimeSelected;

  const MyTimePicker(
      {Key key, @required this.title, this.titleStyle, this.onTimeSelected})
      : super(key: key);

  @override
  _MyTimePickerState createState() => _MyTimePickerState();
}

class _MyTimePickerState extends State<MyTimePicker> {
  String selectedTime = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: widget.titleStyle ?? TextStyle(color: Colors.grey),
        ),
        GestureDetector(
          onTap: () async {
            var time = await showTimePicker(
              context: context,
              builder: (BuildContext context, Widget child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: false),
                  child: child,
                );
              },
              initialTime: TimeOfDay(hour: 12, minute: 00),
            );

            if (time != null) {
              String amPm = '';
              if (time.period == DayPeriod.am) {
                amPm = 'AM';
              } else {
                amPm = 'PM';
              }
              selectedTime = '${time.hour}:${time.minute} $amPm';
              widget.onTimeSelected(selectedTime, time);
              setState(() {});
            }
          },
          child: Container(
            padding: EdgeInsets.all(
              ScreenUtil().setWidth(12),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xffEEEEEE),
            ),
            child: Text(selectedTime),
          ),
        ),
      ],
    );
  }
}
