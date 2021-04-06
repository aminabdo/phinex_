import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellSingleResponse.dart';
import 'package:phinex/Bles/bloc/buy_sell/BuySellBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class BuyAndSellProductDetailsPage extends StatefulWidget {
  final int itemId;
  final String itemName;

  const BuyAndSellProductDetailsPage(
      {Key key, @required this.itemId, @required this.itemName})
      : super(key: key);

  @override
  _BuyAndSellProductDetailsPageState createState() =>
      _BuyAndSellProductDetailsPageState();
}

class _BuyAndSellProductDetailsPageState
    extends State<BuyAndSellProductDetailsPage> {
  bool readMore = false;

  int currentItem;

  @override
  void initState() {
    super.initState();

    print(widget.itemId);
    print(AppUtils.userData.token);

    buySellBloc.clear();
    buySellBloc.getSingle(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.itemName, context),
      backgroundColor: scaffoldBackgroundColor,
      body: StreamBuilder<BuySellSingleResponse>(
          stream: buySellBloc.single.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              print(snapshot.data.data);
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      child: Stack(
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
                              height: ScreenUtil().setHeight(330),
                              viewportFraction: .8,
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
                                          ? mainColor
                                          : mainColor.withOpacity(.3),
                                    ),
                                  ),
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                          child: Text(
                            snapshot.data.data.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(12),
                        ),
                        Container(
                          width: double.infinity,
                          child: Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalization.of(context)
                                        .translate('seller_contacts'),
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
                                            snapshot.data.data.email ??
                                                AppLocalization.of(context)
                                                    .translate(
                                                        'no_email_address'),
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
                                            snapshot.data.data.address ??
                                                AppLocalization.of(context)
                                                    .translate('no_address'),
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
                            margin: EdgeInsets.symmetric(horizontal: 10),
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
                                            .translate('product_details'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "${AppUtils.currency} ${snapshot.data.data.price.toString()}",
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
                                        fontSize: 14, color: Colors.black54),
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
          }),
    );
  }
}
