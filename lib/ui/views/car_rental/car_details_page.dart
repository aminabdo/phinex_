import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/car_rental/CarRentalSingleResponse.dart';
import 'package:phinex/Bles/bloc/car_rental/CarRentalBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class CarDetailsPage extends StatefulWidget {
  final String name;
  final int id;

  const CarDetailsPage({Key key, @required this.name, @required this.id})
      : super(key: key);

  @override
  _CarDetailsPageState createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  int currentItem = 0;
  bool readMore = false;

  @override
  void initState() {
    super.initState();

    carRentalBloc.clear();
    carRentalBloc.getSingle(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.name, context),
      backgroundColor: scaffoldBackgroundColor,
      body: StreamBuilder<CarRentalSingleResponse>(
        stream: carRentalBloc.single.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CarouselSlider(
                        items: List.generate(
                          snapshot.data.data.gallery.length,
                          (index) => snapshot.data.data.gallery[index] ==
                                      null ||
                                  snapshot.data.data.gallery[index] == ''
                              ? Image.asset(
                                  'assets/images/no-product-image.png',
                                  fit: BoxFit.fill,
                                )
                              : Container(
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data.data.gallery[index],
                                    fit: BoxFit.fill,
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
                                  width: double.infinity,
                                ),
                        ).toList(),
                        options: CarouselOptions(
                          height: ScreenUtil().setHeight(260),
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          onPageChanged: (int index, _) {
                            currentItem = index;
                            setState(() {});
                          },
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 0,
                        left: 0,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              snapshot.data.data.gallery.length,
                              (index) => AnimatedContainer(
                                margin: EdgeInsets.only(right: 5),
                                duration: Duration(milliseconds: 600),
                                width: ScreenUtil().setWidth(10),
                                height: ScreenUtil().setHeight(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentItem == index
                                      ? deepBlueColor
                                      : deepBlueColor.withOpacity(.3),
                                ),
                              ),
                            ).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: ScreenUtil().setHeight(8),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(11),
                        ),
                        child: Row(
                          children: [
                            Text(
                              snapshot.data.data.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(10),
                            ),
                            Text(
                              snapshot.data.data.carModel.modelName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                          ],
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
                                  AppLocalization.of(context)
                                      .translate('owner_contacts'),
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
                                          snapshot.data.data.user.email ??
                                              AppLocalization.of(context)
                                                  .translate(
                                                'no_email_address',
                                              ),
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
                                          snapshot.data.data.user.address ??
                                              AppLocalization.of(context)
                                                  .translate('no_address'),
                                          style: TextStyle(
                                            color: Colors.blue[800],
                                            fontSize: 14,
                                          ),
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

                                          AppLocalization.of(context)
                                              .translate('no_website'),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalization.of(context)
                                          .translate('car_description'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${snapshot.data.data.rentalPricePerPeriod} ${AppUtils.currency} / ${snapshot.data.data.rentalPeriod}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(8),
                                ),
                                Text(
                                  snapshot.data.data.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: readMore ? 30 : 1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(14),
                                ),
                                snapshot.data.data.description.length < 70
                                    ? SizedBox.shrink()
                                    : GestureDetector(
                                        child: Text(
                                          readMore
                                              ? AppLocalization.of(context)
                                                  .translate('read_less')
                                              : AppLocalization.of(context)
                                                  .translate('read_more'),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: deepBlueColor,
                                          ),
                                        ),
                                        onTap: () {
                                          readMore = !readMore;
                                          setState(() {});
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(8),
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
                                Text(
                                  AppLocalization.of(context)
                                      .translate('car_features'),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(8),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   AppLocalization.of(context)
                                        //       .translate('car_type'),
                                        //   style: TextStyle(
                                        //     fontSize: 15,
                                        //     fontWeight: FontWeight.bold,
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(5),
                                        ),
                                        Text(
                                          AppLocalization.of(context)
                                              .translate('car_mode'),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(5),
                                        ),
                                        Text(
                                          AppLocalization.of(context)
                                              .translate('body_type'),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(5),
                                        ),
                                        Text(
                                          AppLocalization.of(context)
                                              .translate('rental_period'),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(5),
                                        ),
                                        Text(
                                          AppLocalization.of(context)
                                              .translate('manufacture_year'),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   '${snapshot.data.'},
                                          //   style: TextStyle(
                                          //     color: deepBlueColor,
                                          //     fontSize: 15,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(5),
                                          ),
                                          Text(
                                            snapshot
                                                .data.data.carModel.modelName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: deepBlueColor,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(5),
                                          ),
                                          Text(
                                            snapshot.data.data.bodyType,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: deepBlueColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(5),
                                          ),
                                          Text(
                                            '${snapshot.data.data.rentalPricePerPeriod} ${AppUtils.currency} / ${snapshot.data.data.rentalPeriod}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: deepBlueColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(5),
                                          ),
                                          Text(
                                            snapshot.data.data.manufacturerYear
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: deepBlueColor,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(8),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('error'),
            );
          }
          return Loader();
        },
      ),
    );
  }
}
