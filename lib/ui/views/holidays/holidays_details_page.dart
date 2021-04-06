import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/catalogue/CatalogueSingleResponse.dart';
import 'package:phinex/Bles/bloc/catalogue/CatalogueBloc.dart';
import 'package:phinex/ui/views/rate_item/rate_item_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_contacts_info.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class HolidayDetailsPage extends StatefulWidget {
  final int id;
  final String title;

  const HolidayDetailsPage({Key key, @required this.id, @required this.title})
      : super(key: key);

  @override
  _HolidayDetailsPageState createState() => _HolidayDetailsPageState();
}

class _HolidayDetailsPageState extends State<HolidayDetailsPage> {
  @override
  void initState() {
    super.initState();

    catalogueBloc.getSingle(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.title, context),
      body: StreamBuilder<CatalogueSingleResponse>(
        stream: catalogueBloc.single.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var item = snapshot.data.data;
            return SingleChildScrollView(
              physics: bouncingScrollPhysics,
              child: Column(
                children: [
                  snapshot.data.data.catalogue.imageUrl == null ||
                      snapshot.data.data.catalogue.imageUrl == ''
                      ? Image.asset(
                    'assets/images/no-product-image.png',
                    height: ScreenUtil().setHeight(280),
                  )
                      : CachedNetworkImage(
                    imageUrl: snapshot.data.data.catalogue.imageUrl,
                    fit: BoxFit.fill,
                    height: ScreenUtil().setHeight(280),
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
                                  snapshot.data.data.catalogue.title,
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
                                  '${snapshot.data.data.catalogue.totalRates}',
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
                              '${snapshot.data.data.catalogue.description}',
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
                  MyContactsInfoContainer(
                    item.catalogue.lat.toString(),
                    item.catalogue.long.toString(),
                    phone: item.catalogue.phone,
                    address: item.catalogue.address,
                    email: item.catalogue.email,
                    website: item.catalogue.website,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  reviewsContainer(snapshot),
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

  Widget reviewsContainer(AsyncSnapshot<CatalogueSingleResponse> snapshot) {
    return snapshot.data.data.rates.length == 0
        ? SizedBox.shrink()
        : Container(
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
                    AppLocalization.of(context).translate('reviews'),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (AppUtils.userData == null) {
                        AppUtils.showNeedToRegisterDialog(context);
                        return;
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RateItemPage(
                            itemName: snapshot.data.data.catalogue.title,
                            productID: snapshot.data.data.catalogue.id,
                            objectName: RateObjectName.restaurant,
                            // objectName: ,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      AppLocalization.of(context)
                          .translate('write_your_review'),
                      style: TextStyle(fontSize: 16, color: mainColor),
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
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.title),
                          // todo should return holidi reviews
                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            itemSize: 14,
                            ignoreGestures: true,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                            EdgeInsets.symmetric(horizontal: 0.0),
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
                        'good meals',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: Image.asset('assets/images/avatar.png'),
                    );
                  },
                  itemCount: snapshot.data.data.rates.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: ScreenUtil().setHeight(6),
                    );
                  },
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(14),
              ),
              Align(
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
    );
  }
}
