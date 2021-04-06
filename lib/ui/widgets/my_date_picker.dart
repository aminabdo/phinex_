import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class MyDatePicker extends StatefulWidget {
  final String title;
  final TextStyle titleStyle;
  final Function(String, DateTime) onDateSelected;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime endDate;

  const MyDatePicker(
      {Key key, @required this.title, this.titleStyle, this.onDateSelected, this.initialDate, this.firstDate, this.endDate})
      : super(key: key);

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  String selectedDate = '';

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
            var date = await showDatePicker(
              context: context,
              builder: (BuildContext context, Widget child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                  child: child,
                );
              },
              initialDate: widget.initialDate ?? DateTime.now(),
              firstDate: widget.firstDate ?? DateTime(1900), lastDate: widget.endDate ?? DateTime(2900),
            );

            if (date != null) {
              selectedDate = '${date.year}-${date.month}-${date.day}';
              widget.onDateSelected(selectedDate, date);
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
            child: Text(selectedDate),
          ),
        ),
      ],
    );
  }
}
