import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacySingleResponse.dart';
import 'package:phinex/Bles/bloc/medical_service/PharmacyBloc.dart';
import 'package:phinex/ui/views/rate_item/rate_item_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'pharmacy_products_page.dart';
import 'single_product_cart_item.dart';

class SinglePharmacyDetailsPage extends StatefulWidget {
  final int id;
  final String title;

  const SinglePharmacyDetailsPage(
      {Key key, @required this.id, @required this.title})
      : super(key: key);

  @override
  _SinglePharmacyDetailsPageState createState() =>
      _SinglePharmacyDetailsPageState();
}

class _SinglePharmacyDetailsPageState extends State<SinglePharmacyDetailsPage> {

  int currentItem = -1;

  @override
  void initState() {
    super.initState();

    pharmacyBloc.getSingle(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.title, context),
      body: StreamBuilder<PharmacySingleResponse>(
        stream: pharmacyBloc.single.stream,
        builder: (context, snapshot) {
          if (pharmacyBloc.loading.value) {
            return Loader();
          } else {
            return SingleChildScrollView(
              physics: bouncingScrollPhysics,
              child: Column(
                children: [
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      CarouselSlider(
                        items: snapshot.data.data.pharmacy.gallery
                            .map(
                              (imageUrl) => Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Container(
                              child: imageUrl == null ||
                                  imageUrl.isEmpty
                                  ? Image.asset(
                                'assets/images/no-product-image.png',
                                // fit: BoxFit.fill,
                              )
                                  : Padding(
                                padding: EdgeInsets.all(12.0),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  placeholder: (context, url) {
                                    return Loader(
                                      size: 30,
                                    );
                                  },
                                  // fit: BoxFit.fill,
                                  errorWidget: (_, __, ___) {
                                    return Icon(Icons.error);
                                  },
                                ),
                              ),
                              width: double.infinity,
                              height: ScreenUtil().setHeight(250),
                            ),
                          ),
                        )
                            .toList(),
                        options: CarouselOptions(
                          height: ScreenUtil().setHeight(320),
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
                        bottom: -25,
                        left: 10,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              snapshot.data.data.pharmacy.logoUrl == null ||
                                      snapshot.data.data.pharmacy.logoUrl == ''
                                  ? null
                                  : CachedNetworkImageProvider(
                                      snapshot.data.data.pharmacy.logoUrl,
                                    ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 10,
                        left: 10,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              snapshot.data.data.pharmacy.gallery.length,
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
                                  snapshot.data.data.pharmacy.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(8),
                                ),
                                Text(
                                  snapshot.data.data.pharmacy.totalRates
                                      .toDouble()
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.yellow[800],
                                  ),
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
                              snapshot.data.data.pharmacy.description ?? '',
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
                                      snapshot.data.data.pharmacy.phone
                                          .toString(),
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
                                      snapshot.data.data.pharmacy.email ??
                                          AppLocalization.of(context)
                                              .translate('no_email_address'),
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
                                      snapshot.data.data.pharmacy.address,
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
                                      snapshot.data.data.pharmacy.website ??
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
                  snapshot.data.data.products?.length == 0 ? SizedBox.shrink() :  Container(
                    height: ScreenUtil().setHeight(420),
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${AppLocalization.of(context).translate('products')}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => PharmacyProductsPage(
                                        id: widget.id,
                                        title: widget.title,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  AppLocalization.of(context)
                                      .translate('see_all'),
                                  style: TextStyle(
                                    color: mainColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: bouncingScrollPhysics,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: ScreenUtil().setWidth(240),
                                  child: SingleMedicineCartItem(
                                      product:
                                          snapshot.data.data.products[index]),
                                );
                              },
                              itemCount: snapshot.data.data.products?.length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ],
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
                                    if (AppUtils.userData == null) {
                                      AppUtils.showNeedToRegisterDialog(
                                          context);
                                      return;
                                    }
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => RateItemPage(
                                          itemName: widget.title,
                                          productID: widget.id,
                                          objectName: 'pharmacy',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    AppLocalization.of(context)
                                        .translate('write_your_review'),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(8),
                            ),
                            ListView.separated(
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data.data.rates[index].user
                                          .username),
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
                                  leading:
                                      Image.asset('assets/images/avatar.png'),
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
                            SizedBox(
                              height: ScreenUtil().setHeight(14),
                            ),
                            snapshot.data.data.rates.isEmpty
                                ? SizedBox.shrink()
                                : Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      translate(context, 'see_more'),
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
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
