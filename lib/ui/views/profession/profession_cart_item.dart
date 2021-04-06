import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsByUserResponse.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'profession_details_page.dart';

class ProfessionCardItem extends StatefulWidget {
  final ProfessionBean currentItem;

  const ProfessionCardItem({
    Key key,
    @required this.currentItem,
  }) : super(key: key);

  @override
  _ProfessionCardItemState createState() => _ProfessionCardItemState();
}

class _ProfessionCardItemState extends State<ProfessionCardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProfessionDetailsPage(
                    title: widget.currentItem.commercialName,
                    id: widget.currentItem.userId,
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
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: widget.currentItem.imageUrl == null ||
                        widget.currentItem.imageUrl == ''
                    ? Image.asset(
                        'assets/images/no-product-image.png',
                        fit: BoxFit.fill,
                        height: ScreenUtil().setHeight(220),
                      )
                    : CachedNetworkImage(
                        imageUrl: widget.currentItem.imageUrl,
                        height: ScreenUtil().setHeight(220),
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
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(4),
                ),
                Text(
                  widget.currentItem.commercialName,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4),
                ),
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
                      '(${widget.currentItem.totalRates == null ? 0.0 : widget.currentItem.totalRates.toDouble()})',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(14),
                ),
                myButton(
                  AppLocalization.of(context).translate('see_details'),
                  btnColor: mainColor,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProfessionDetailsPage(
                          title: widget.currentItem.commercialName,
                          id: widget.currentItem.userId,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
