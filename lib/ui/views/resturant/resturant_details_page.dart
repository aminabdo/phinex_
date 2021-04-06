import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantSingleResponse.dart';
import 'package:phinex/Bles/bloc/rate/rate_object_bloc.dart';
import 'package:phinex/Bles/bloc/restaurant/RestaurantBloc.dart';
import 'package:phinex/ui/views/rate_item/rate_item_page.dart';
import 'package:phinex/ui/views/resturant/restaurant_meals_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_contacts_info.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_rating_bar.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'resturant_meals_card_item.dart';

class RestaurantDetailsPage extends StatefulWidget {
  final int id;
  final String title;

  const RestaurantDetailsPage({Key key, @required this.id, @required this.title})
      : super(key: key);

  @override
  _RestaurantDetailsPageState createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  bool getMoreReviews = false;

  int skip = 0;
  int take = 10;

  @override
  void initState() {
    super.initState();

    restaurantBloc.clear();
    restaurantBloc.getSingle(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.title, context),
      body: StreamBuilder<RestaurantSingleResponse>(
        stream: restaurantBloc.single.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var restData = snapshot.data.data;
            return SingleChildScrollView(
              physics: bouncingScrollPhysics,
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      snapshot.data.data.coverImageUrl == null ||
                              snapshot.data.data.coverImageUrl == ''
                          ? Image.asset(
                              'assets/images/no-product-image.png',
                              height: ScreenUtil().setHeight(280),
                            )
                          : CachedNetworkImage(
                              imageUrl: snapshot.data.data.coverImageUrl,
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
                      Positioned(
                        bottom: -18,
                        left: 15,
                        child: CircleAvatar(
                          backgroundImage: snapshot.data.data.logoUrl == null ||
                                  snapshot.data.data.logoUrl == ''
                              ? Image.asset(
                                      'assets/images/no-product-image.png')
                                  .image
                              : CachedNetworkImageProvider(
                                  snapshot.data.data.logoUrl,
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
                                  snapshot.data.data.title,
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
                                  '${snapshot.data.data.totalRates}',
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
                              restData.description ?? '',
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
                    restData.longitude.toString(),
                    restData.longitude.toString(),
                    phone: restData.phone,
                    address: restData.address,
                    email: restData.email,
                    website: restData.website,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  mealsContainer(snapshot),
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

  Widget reviewsContainer(AsyncSnapshot<RestaurantSingleResponse> snapshot) {
    return Container(
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
                            itemName: snapshot.data.data.title,
                            productID: snapshot.data.data.restaurantId,
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
                          Text(snapshot.data.data.rates[index].user.username),
                          MyRatingBar(
                              rate: snapshot.data.data.rates[index].rate
                                  .toDouble(),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        snapshot.data.data.rates[index].comment,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: snapshot.data.data.rates[index].user.imageUrl ==
                                    null ||
                                snapshot.data.data.rates[index].user.imageUrl ==
                                    ''
                            ? Image.asset('assets/images/avatar.png').image
                            : CachedNetworkImageProvider(
                                snapshot.data.data.rates[index].user.imageUrl,
                              ),
                      ),
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
                alignment: Alignment.topRight,
                child: getMoreReviews
                    ? Loader(
                        size: 30,
                      )
                    : GestureDetector(
                        onTap: () async {
                          setState(() {
                            getMoreReviews = true;
                          });

                          await seeMoreBloc.getMoreReviews(
                            RateObjectName.restaurant,
                            snapshot.data.data.restaurantId.toString(),
                            BaseRequestSkipTake(
                              skip: skip,
                              take: take,
                            ),
                          );

                          skip += 10;
                          take += 10;

                          setState(() {
                            getMoreReviews = false;
                          });
                        },
                        child: Text(
                          translate(context, 'see_more'),
                          style: TextStyle(
                            fontSize: 14,
                            color: deepBlueColor,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mealsContainer(AsyncSnapshot<RestaurantSingleResponse> snapshot) {
    return snapshot.data.data.products.isEmpty
        ? SizedBox.shrink()
        : Container(
            height: ScreenUtil().setHeight(395),
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
                        '${AppLocalization.of(context).translate('meals')}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RestaurantMealsPage(
                                id: widget.id,
                                title: widget.title,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          '${AppLocalization.of(context).translate('see_all')}',
                          style: TextStyle(
                            fontSize: 16,
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
                          child: RestuarntMealsCartItem(
                            currentItem: snapshot.data.data.products[index],
                          ),
                          height: ScreenUtil().setHeight(280),
                        );
                      },
                      itemCount: snapshot.data.data.products.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
