
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/proffession/professionBookNowRequest.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsByUserResponse.dart';
import 'package:phinex/Bles/bloc/professions/Professions.dart';
import 'package:phinex/ui/widgets/done_dialog.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class ProfessionWorkShopItem extends StatefulWidget {

  final String dayName;
  final String date;
  final String price;
  final AsyncSnapshot<ProfessionsByUserResponse> snapshot;
  final int index;
  final int day;

  const ProfessionWorkShopItem(this.dayName, this.date, this.price, this.snapshot, this.index, this.day, {Key key}) : super(key: key);

  @override
  _ProfessionWorkShopItemState createState() => _ProfessionWorkShopItemState();
}

class _ProfessionWorkShopItemState extends State<ProfessionWorkShopItem> {

  int currentDay = 0;
  int dateDays = 1;
  bool booking = false;

  void getDateDay() {
    var now = new DateTime.now();
    while (now.weekday != currentDay) {
      now = now.subtract(Duration(days: 1));
    }
    setState(() {
      dateDays = now.day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: ScreenUtil().setWidth(8)),
        width: ScreenUtil().setWidth(160),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: mainColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.dayName,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(4),
              ),
              Text(
                widget.date,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(4),
              ),
              booking
                  ? Loader(
                size: 30,
              )
                  : myButton(
                AppLocalization.of(context).translate('book_now'),
                onTap: () async {
                  if (AppUtils.userData == null) {
                    AppUtils.showNeedToRegisterDialog(context);
                    return;
                  }

                  currentDay = widget.day;
                  getDateDay();

                  var selectedDate = await showDatePicker(
                    selectableDayPredicate: (day) =>
                    day.weekday == currentDay ? true : false,
                    context: context,
                    initialDate: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      dateDays + 7,
                    ),
                    firstDate: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      dateDays + 7,
                    ),
                    lastDate: DateTime(3000),
                  );

                  if (selectedDate == null) {
                    AppUtils.showToast(
                      msg: translate(context, 'select_date'),
                    );
                    return;
                  }

                  booking = true;
                  setState(() {});

                  ProfessionBookNowRequest request =
                  ProfessionBookNowRequest(
                    userId: AppUtils.userData.id,
                    technicianId: widget.snapshot.data.data.technicianId,
                    workshopId: widget.snapshot.data.data.workshops[widget.index].id,
                    notes: '',
                    datetime: selectedDate.toString(),
                  );

                  print(request.toMap());

                  Response response = await professionsBloc.bookNow(
                    request,
                  );

                  if (response.statusCode >= 200 &&
                      response.statusCode < 300) {
                    print(response.toString());

                    showDialog(
                      context: context,
                      builder: (_) => DoneDialogContent(
                        msg:
                        translate(context, 'you_booked_successfully'),
                      ),
                    );
                  } else {
                    AppUtils.showToast(msg: 'Failed');
                  }

                  booking = false;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      );
  }
}
