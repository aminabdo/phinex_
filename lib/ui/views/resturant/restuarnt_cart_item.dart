import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantLandinResponse.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'resturant_details_page.dart';

class RestuarntCartItem extends StatefulWidget {
  final RestaurantsBean currentItem;

  const RestuarntCartItem({Key key, @required this.currentItem})
      : super(key: key);

  @override
  _RestuarntCartItemState createState() => _RestuarntCartItemState();
}

class _RestuarntCartItemState extends State<RestuarntCartItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RestaurantDetailsPage(
                      id: widget.currentItem.id,
                      title: widget.currentItem.title,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                width: double.infinity,
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: widget.currentItem.coverImageUrl == null ||
                              widget.currentItem.coverImageUrl == ''
                          ? Image.asset(
                              'assets/images/no-product-image.png',
                              width: double.infinity,
                              height: ScreenUtil().setHeight(330),
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.currentItem.coverImageUrl,
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
                    Positioned(
                      bottom: -18,
                      left: 5,
                      child: CircleAvatar(
                        backgroundImage: widget.currentItem.logoUrl == null ||
                                widget.currentItem.logoUrl == ''
                            ? Image.asset('assets/images/no-product-image.png')
                                .image
                            : CachedNetworkImageProvider(
                                widget.currentItem.logoUrl,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(18),
          ),
          Padding(
            padding: EdgeInsets.all(
              ScreenUtil().setWidth(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: widget.currentItem.totalRates == null
                          ? 0.0
                          : widget.currentItem.totalRates.toDouble(),
                      minRating: 1,
                      itemSize: 16,
                      ignoreGestures: true,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: goldColor,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(8),
                    ),
                    Text(
                      '${widget.currentItem.totalRates.toDouble()}',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ],
                ),
                Text(
                  '${widget.currentItem.title}',
                  style: TextStyle(fontSize: 14, color: mainColor),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                myButton(
                  AppLocalization.of(context).translate('see_details'),
                  btnColor: deepBlueColor,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RestaurantDetailsPage(
                          id: widget.currentItem.id,
                          title: widget.currentItem.title,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
