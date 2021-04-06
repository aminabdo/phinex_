import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/real_state/RealStateFilterResponse.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'real_state_details_page.dart';

class RealStateCartItem extends StatefulWidget {
  final RealestatesBean currentItem;

  const RealStateCartItem({Key key, @required this.currentItem})
      : super(key: key);

  @override
  _RealStateCartItemState createState() => _RealStateCartItemState();
}

class _RealStateCartItemState extends State<RealStateCartItem> {
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
                    builder: (_) => RealStateDetailsPage(
                      title: widget.currentItem.propertyTitle,
                      id: widget.currentItem.id,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: widget.currentItem.propertyImage == null ||
                        widget.currentItem.propertyImage == ''
                    ? Image.asset('assets/images/no-product-image.png')
                    : CachedNetworkImage(
                        imageUrl: widget.currentItem.propertyImage,
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
          ),
          Padding(
            padding: EdgeInsets.all(
              ScreenUtil().setWidth(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.currentItem.propertyTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4),
                ),
                Text(
                  '${widget.currentItem.price} ${AppUtils.currency}',
                  //'${widget.productsBean.regularPrice} ${AppUtils.currency}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  height: ScreenUtil().setHeight(45),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RealStateDetailsPage(
                              title: widget.currentItem.propertyTitle,
                              id: widget.currentItem.id,
                            ),
                          ),
                        );
                      },
                      padding: EdgeInsets.all(0),
                      child: Center(
                        child: Text(
                          AppLocalization.of(context).translate('see_details'),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
