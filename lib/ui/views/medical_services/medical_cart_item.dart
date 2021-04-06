import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

class MedicalCardItem extends StatefulWidget {
  final Function onTap;
  final String imageUrl;
  final String title;
  final double rate;

  const MedicalCardItem({
    Key key,
    @required this.onTap,
    @required this.imageUrl,
    @required this.title, @required this.rate,
  }) : super(key: key);

  @override
  _MedicalCardItemState createState() => _MedicalCardItemState();
}

class _MedicalCardItemState extends State<MedicalCardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: widget.onTap,
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
                  child: widget.imageUrl == null || widget.imageUrl == ''
                      ? Image.asset(
                          'assets/images/no-product-image.png',
                          fit: BoxFit.fill,
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.imageUrl,
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
                 widget.title.toString(),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4),
                ),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: widget.rate ?? 0.0,
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
                      '${widget.rate ?? 0.0}',
                      //'(${widget.currentItem.totalRates == null ? 0.0 : widget.currentItem.totalRates.toDouble()})',
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
                  onTap: widget.onTap,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
