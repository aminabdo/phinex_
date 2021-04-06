import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/cart/AddToCartRequest.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantSingleResponse.dart';
import 'package:phinex/Bles/bloc/store/CartBloc.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class RestuarntMealsCartItem extends StatefulWidget {
  final Products currentItem;

  const RestuarntMealsCartItem({Key key, @required this.currentItem})
      : super(key: key);

  @override
  _RestuarntMealsCartItemState createState() => _RestuarntMealsCartItemState();
}

class _RestuarntMealsCartItemState extends State<RestuarntMealsCartItem> {

  bool favourite = false;
  int counter = 1;
  bool addToCart = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
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
                  width: double.infinity,
                  height: ScreenUtil().setHeight(330),
                )
                    : CachedNetworkImage(
                  imageUrl: widget.currentItem.imageUrl,
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

                Row(
                  children: [
                    RatingBar.builder(
                      initialRating:  widget.currentItem.totalRates== null ? 0.0 : num.parse(widget.currentItem.totalRates).toDouble(),
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
                      '${widget.currentItem.totalRates}',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Text(
                  '${widget.currentItem.name}',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                counter > 1
                    ? counterWidget()
                    : addToCart
                    ? counterWidget()
                    : Container(
                  height: ScreenUtil().setHeight(45),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: FlatButton(
                      onPressed: () {
                        if (AppUtils.userData == null) {
                          AppUtils.showNeedToRegisterDialog(context);
                          return;
                        }

                        addToCart = true;
                        isLoading = true;
                        setState(() {});
                        addCart();
                      },
                      padding: EdgeInsets.all(0),
                      child: Center(
                        child: Text(
                          AppLocalization.of(context)
                              .translate('add_to_cart'),
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

  Widget counterWidget() {
    return Container(
      height: ScreenUtil().setHeight(45),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: mainColor, width: .5),
      ),
      child: isLoading
          ? Loader(
        size: 20,
      )
          : Row(
        children: [
          GestureDetector(
            onTap: () {
              counter--;
              if (counter <= 0) {
                counter = 0;
                addToCart = false;
                updateCartCounter();
                counter = 1;
                setState(() {});
                return;
              }

              isLoading = true;
              setState(() {});
              updateCartCounter();
            },
            child: Container(
              width: ScreenUtil().setWidth(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: mainColor,
              ),
              height: ScreenUtil().setHeight(45),
              child: Icon(
                Icons.remove,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '$counter',
                style: TextStyle(
                  color: mainColor,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              counter++;
              isLoading = true;
              setState(() {});
              updateCartCounter();
            },
            child: Container(
              width: ScreenUtil().setWidth(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: mainColor,
              ),
              height: ScreenUtil().setHeight(45),
              child: Icon(
                Icons.add,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addCart() async {
    AddToCartRequest requestObject = AddToCartRequest();
    requestObject.cartProducts.add(
      CartProductsBean(
        userId: AppUtils.userData.id,
        vendorId: widget.currentItem.vendorId,
        quantity: counter,
        productId: widget.currentItem.id,
      ),
    );

    await cartBloc.addToMyCart(requestObject);
    isLoading = false;
    setState(() {});
  }

  void updateCartCounter() async {
    isLoading = true;
    setState(() {});
    await cartBloc.updateCartItem(AppUtils.userData.id, widget.currentItem.id, counter);
    isLoading = false;
    setState(() {});
  }
}
