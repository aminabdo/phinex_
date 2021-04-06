import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellByCatReposnse.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'buy_sell_product_details_page.dart';

class BuySellCategoryCartItem extends StatefulWidget {
  final ItemsBean productsBean;

  const BuySellCategoryCartItem({
    Key key,
    this.productsBean,
  }) : super(key: key);

  @override
  _BuySellCategoryCartItemState createState() =>
      _BuySellCategoryCartItemState();
}

class _BuySellCategoryCartItemState extends State<BuySellCategoryCartItem> {
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
                    builder: (_) => BuyAndSellProductDetailsPage(
                      itemName: widget.productsBean.title,
                      itemId: widget.productsBean.id,
                    ),
                  ),
                );
              },
              child: Stack(
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
                      child: widget.productsBean.imageUrl == null ||
                              widget.productsBean.imageUrl == ''
                          ? Image.asset(
                              'assets/images/no-product-image.png',
                              width: double.infinity,
                              height: ScreenUtil().setHeight(240),
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.productsBean.imageUrl,
                              width: double.infinity,
                              height: ScreenUtil().setHeight(260),
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
                ],
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
                  widget.productsBean.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4),
                ),
                Text(
                  '${widget.productsBean.price} ${AppUtils.currency}',
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
                            builder: (_) => BuyAndSellProductDetailsPage(
                              itemId: widget.productsBean.id,
                              itemName: widget.productsBean.title,
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
