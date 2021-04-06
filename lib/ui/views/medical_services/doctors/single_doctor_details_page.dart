import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/medical/BookNowRequest.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorSingleResponse.dart';
import 'package:phinex/Bles/bloc/medical_service/DoctorBloc.dart';
import 'package:phinex/ui/views/rate_item/rate_item_page.dart';
import 'package:phinex/ui/widgets/done_dialog.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class SingleDoctorDetailsPage extends StatefulWidget {
  final String title;
  final int id;

  const SingleDoctorDetailsPage(
      {Key key, @required this.title, @required this.id})
      : super(key: key);

  @override
  _SingleDoctorDetailsPageState createState() =>
      _SingleDoctorDetailsPageState();
}

class _SingleDoctorDetailsPageState extends State<SingleDoctorDetailsPage> {
  @override
  void initState() {
    super.initState();

    doctorBloc.getSingle(widget.id);
    doctorBloc.book.onListen = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.title.toString(), context),
      body: StreamBuilder<DoctorSingleResponse>(
        stream: doctorBloc.single.stream,
        builder: (context, snapshot) {
          if (doctorBloc.loading.value) {
            return Loader();
          } else {
            return SingleChildScrollView(
              physics: bouncingScrollPhysics,
              child: Column(
                children: [
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: snapshot.data.data.imageUrl == null ||
                                  snapshot.data.data.imageUrl == ''
                              ? Image.asset(
                                  'assets/images/no-product-image.png',
                                  fit: BoxFit.fill,
                                  height: ScreenUtil().setHeight(200),
                                )
                              : CachedNetworkImage(
                                  imageUrl: snapshot.data.data.imageUrl,
                                  height: ScreenUtil().setHeight(200),
                                  errorWidget: (_, __, ___) {
                                    return Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    );
                                  },
                                  placeholder: (context, url) {
                                    return Loader(
                                      size: 40,
                                    );
                                  },
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: -25,
                        left: 10,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              snapshot.data.data.imageUrl == null ||
                                      snapshot.data.data.imageUrl == ''
                                  ? null
                                  : CachedNetworkImageProvider(
                                      snapshot.data.data.imageUrl,
                                    ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(28),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data.data.username,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(8),
                                ),
                                Text(
                                  snapshot.data.data.totalRates.toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.yellow[800]),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(8),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 18,
                                  color: Colors.yellow[800],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(8),
                            ),
                            Text(
                              snapshot.data.data.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalization.of(context).translate('contacts'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: deepBlueColor,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(8),
                                    ),
                                    Text(
                                      snapshot.data.data.phone,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: deepBlueColor,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(8),
                                    ),
                                    Text(
                                      'info@phinex.net',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(12),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: deepBlueColor,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(8),
                                    ),
                                    Text(
                                      'New Cairo, Egypt',
                                      style: TextStyle(
                                          color: Colors.blue[800],
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.language,
                                      color: deepBlueColor,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(8),
                                    ),
                                    Text(
                                      'www.phinex.net',
                                      style: TextStyle(
                                          color: Colors.blue[800],
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(420),
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot
                                      .data.data.medicalServices[index].title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(12),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: deepBlueColor,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(8),
                                        ),
                                        Text(
                                          snapshot.data.data
                                              .medicalServices[index].phone,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          color: deepBlueColor,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(8),
                                        ),
                                        Text(
                                          'info@phinex.net',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(12),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: deepBlueColor,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(8),
                                        ),
                                        Text(
                                          'New Cairo, Egypt',
                                          style: TextStyle(
                                              color: Colors.blue[800],
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.language,
                                          color: deepBlueColor,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(8),
                                        ),
                                        Text(
                                          'www.phinex.net',
                                          style: TextStyle(
                                              color: Colors.blue[800],
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(12),
                                ),
                                Expanded(
                                  child: ListView(
                                    physics: bouncingScrollPhysics,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      snapshot.data.data.medicalServices[index]
                                                      .saturday !=
                                                  null &&
                                              snapshot
                                                      .data
                                                      .data
                                                      .medicalServices[index]
                                                      .saturday ==
                                                  1
                                          ? workshopDay(
                                              translate(context, 'saturday'),
                                              '${snapshot.data.data.medicalServices[index].openAt} - ${snapshot.data.data.medicalServices[index].closingAt}',
                                              snapshot
                                                  .data
                                                  .data
                                                  .medicalServices[index]
                                                  .regularPrice
                                                  .toString(),
                                              snapshot,
                                              index,
                                              6)
                                          : SizedBox.shrink(),
                                      snapshot.data.data.medicalServices[index]
                                                      .sunday !=
                                                  null &&
                                              snapshot
                                                      .data
                                                      .data
                                                      .medicalServices[index]
                                                      .sunday ==
                                                  1
                                          ? workshopDay(
                                              translate(context, 'sunday'),
                                              '${snapshot.data.data.medicalServices[index].openAt} - ${snapshot.data.data.medicalServices[index].closingAt}',
                                              snapshot
                                                  .data
                                                  .data
                                                  .medicalServices[index]
                                                  .regularPrice
                                                  .toString(),
                                              snapshot,
                                              index,
                                              7)
                                          : SizedBox.shrink(),
                                      snapshot.data.data.medicalServices[index]
                                                      .monday !=
                                                  null &&
                                              snapshot
                                                      .data
                                                      .data
                                                      .medicalServices[index]
                                                      .monday ==
                                                  1
                                          ? workshopDay(
                                              translate(context, 'monday'),
                                              '${snapshot.data.data.medicalServices[index].openAt} - ${snapshot.data.data.medicalServices[index].closingAt}',
                                              snapshot
                                                  .data
                                                  .data
                                                  .medicalServices[index]
                                                  .regularPrice
                                                  .toString(),
                                              snapshot,
                                              index,
                                              1)
                                          : SizedBox.shrink(),
                                      snapshot.data.data.medicalServices[index]
                                                      .tuesday !=
                                                  null &&
                                              snapshot
                                                      .data
                                                      .data
                                                      .medicalServices[index]
                                                      .tuesday ==
                                                  1
                                          ? workshopDay(
                                              translate(context, 'tuesday'),
                                              '${snapshot.data.data.medicalServices[index].openAt} - ${snapshot.data.data.medicalServices[index].closingAt}',
                                              snapshot
                                                  .data
                                                  .data
                                                  .medicalServices[index]
                                                  .regularPrice
                                                  .toString(),
                                              snapshot,
                                              index,
                                              2)
                                          : SizedBox.shrink(),
                                      snapshot.data.data.medicalServices[index]
                                                      .wednesday !=
                                                  null &&
                                              snapshot
                                                      .data
                                                      .data
                                                      .medicalServices[index]
                                                      .wednesday ==
                                                  1
                                          ? workshopDay(
                                              translate(context, 'wednesday'),
                                              snapshot
                                                  .data
                                                  .data
                                                  .medicalServices[index]
                                                  .openAt,
                                              snapshot
                                                  .data
                                                  .data
                                                  .medicalServices[index]
                                                  .regularPrice
                                                  .toString(),
                                              snapshot,
                                              index,
                                              3)
                                          : SizedBox.shrink(),
                                      snapshot.data.data.medicalServices[index]
                                                      .thursday !=
                                                  null &&
                                              snapshot
                                                      .data
                                                      .data
                                                      .medicalServices[index]
                                                      .thursday ==
                                                  1
                                          ? workshopDay(
                                              translate(context, 'thursday'),
                                              '${snapshot.data.data.medicalServices[index].openAt}- ${snapshot.data.data.medicalServices[index].closingAt}',
                                              snapshot
                                                  .data
                                                  .data
                                                  .medicalServices[index]
                                                  .regularPrice
                                                  .toString(),
                                              snapshot,
                                              index,
                                              4)
                                          : SizedBox.shrink(),
                                      snapshot.data.data.medicalServices[index]
                                                      .friday !=
                                                  null &&
                                              snapshot
                                                      .data
                                                      .data
                                                      .medicalServices[index]
                                                      .friday ==
                                                  1
                                          ? workshopDay(
                                              translate(context, 'friday'),
                                              '${snapshot.data.data.medicalServices[index].openAt}- ${snapshot.data.data.medicalServices[index].closingAt}',
                                              snapshot
                                                  .data
                                                  .data
                                                  .medicalServices[index]
                                                  .regularPrice
                                                  .toString(),
                                              snapshot,
                                              index,
                                              5)
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data.data.medicalServices.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalization.of(context)
                                      .translate('reviews'),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => RateItemPage(
                                          itemName: widget.title,
                                          productID: snapshot.data.data.id,
                                          objectName: RateObjectName.doctor,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    AppLocalization.of(context)
                                        .translate('write_your_review'),
                                    style: TextStyle(
                                        fontSize: 16, color: mainColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(8),
                            ),
                            Container(
                              width: double.infinity,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: double.infinity,
                                    child: ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(widget.title),
                                          RatingBar.builder(
                                            initialRating: snapshot
                                                .data.data.rates[index].rate
                                                .toDouble(),
                                            minRating: 1,
                                            itemSize: 14,
                                            ignoreGestures: true,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 0.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: goldColor,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        snapshot.data.data.rates[index].comment,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      leading: Container(
                                        width: 80,
                                        height: 80,
                                        child: snapshot.data.data.rates[index]
                                                        .user.imageUrl ==
                                                    null ||
                                                snapshot.data.data.rates[index]
                                                        .user.imageUrl ==
                                                    ''
                                            ? Image.asset(
                                                'assets/images/avatar.png',
                                        )
                                            : CachedNetworkImage(
                                                imageUrl: snapshot.data.data
                                                    .rates[index].user.imageUrl,
                                              ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: snapshot.data.data.rates.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: ScreenUtil().setHeight(6),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(14),
                            ),
                            snapshot.data.data.rates.isEmpty
                                ? SizedBox.shrink()
                                : Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      AppLocalization.of(context)
                                          .translate('see_more'),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: deepBlueColor,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget workshopDay(String dayName, String date, String price,
      AsyncSnapshot<DoctorSingleResponse> snapshot, int index, int day) {
    bool booking = false;

    return StatefulBuilder(
      builder: (context, _) => Container(
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
                dayName,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(4),
              ),
              Text(
                date,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(4),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(8),
                  ),
                  Text(
                    '${AppUtils.currency}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
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

                        currentDay = day;
                        getDateDay();

                        var selectedDate = await showDatePicker(
                          selectableDayPredicate: (day) =>
                              day.weekday == currentDay ? true : false,
                          context: context,
                          initialDate: DateTime(DateTime.now().year,
                              DateTime.now().month, dateDays + 7),
                          firstDate: DateTime(DateTime.now().year,
                              DateTime.now().month, dateDays + 7),
                          lastDate: DateTime(3000),
                        );

                        if (selectedDate == null) {
                          AppUtils.showToast(
                              msg: translate(context, 'select_date'));
                          return;
                        }

                        booking = true;
                        setState(() {});

                        BookNowRequest request = BookNowRequest(
                          userId: AppUtils.userData.id.toString(),
                          clinicId: snapshot.data.data.medicalServices[index].id
                              .toString(),
                          doctorId: snapshot
                              .data.data.medicalServices[index].doctorId
                              .toString(),
                          notes: '',
                          datetime: selectedDate.toString(),
                        );

                        print(request.toJson());

                        await doctorBloc.bookNow(
                          request,
                        );

                        booking = false;
                        setState(() {});
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  int currentDay = 0;
  int dateDays = 1;

  void getDateDay() {
    var now = new DateTime.now();
    while (now.weekday != currentDay) {
      now = now.subtract(Duration(days: 1));
    }
    setState(() {
      dateDays = now.day;
    });
  }

  void Function() getData() {
    doctorBloc.book.stream.listen(
      (value) async {
        if (value.code >= 200 && value.code < 300) {
          await showDialog(
            context: context,
            builder: (_) => DoneDialogContent(
              msg: translate(context, 'you_booked_successfully'),
            ),
          );
        } else {
          AppUtils.showToast(msg: value.code.toString());
        }
      },
    );
  }
}
