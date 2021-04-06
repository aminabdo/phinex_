import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/cart/AddToCartRequest.dart';
import 'package:phinex/Bles/Model/requests/wish_list/AddToWishListRequest.dart';
import 'package:phinex/Bles/Model/responses/store/store_responses/ProductsBean.dart';
import 'package:phinex/Bles/bloc/store/CartBloc.dart';
import 'package:phinex/Bles/bloc/store/WishListBloc.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'store_item_details_page.dart';

class StoreCartItem extends StatefulWidget {
  final ProductsBean productsBean;

  const StoreCartItem({
    Key key,
    this.productsBean,
  }) : super(key: key);

  @override
  _StoreCartItemState createState() => _StoreCartItemState();
}

class _StoreCartItemState extends State<StoreCartItem> {
  bool favourite = false;
  int counter = 0;
  bool addToCart = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    favourite = widget.productsBean.wishlis ?? false;
    counter = widget.productsBean.cartQty ?? 0;

    print(widget.productsBean.toJson());
  }

  @override
  Widget build(BuildContext context) {
    print(widget.productsBean.hotOffer);
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
                    builder: (_) => StoreCartItemDetailsPage(
                      productId: widget.productsBean.id,
                      quantity: counter,
                      price: double.parse(widget.productsBean.regularPrice.toString()),
                      productName: widget.productsBean.name,
                      isFavourite: favourite,
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
                              fit: BoxFit.fill,
                              height: ScreenUtil().setHeight(200),
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.productsBean.imageUrl,
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
                  Positioned(
                    top: ScreenUtil().setHeight(16),
                    left: ScreenUtil().setWidth(16),
                    child: GestureDetector(
                      onTap: () {
                        if (AppUtils.userData == null) {
                          AppUtils.showNeedToRegisterDialog(context);
                          return;
                        }
                        favourite = !favourite;
                        if (favourite) {
                          wishlistBloc.addToWishList(
                            WishListRequest(
                              user_id: AppUtils.userData.id,
                              product_id: widget.productsBean.id,
                            ),
                          );
                        } else {
                          wishlistBloc.deleteFromWishList(
                            WishListRequest(
                              user_id: AppUtils.userData.id,
                              product_id: widget.productsBean.id,
                            ),
                          );
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: ScreenUtil().setWidth(40),
                        padding: EdgeInsets.all(8),
                        height: ScreenUtil().setHeight(40),
                        decoration: BoxDecoration(
                          color: Color(0xffFCFCFC),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: FlareActor(
                            "assets/flare/Favorite.flr",
                            shouldClip: false,
                            animation: favourite ? "Favorite" : "Unfavorite",
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget.productsBean.hotOffer == null || widget.productsBean.hotOffer == '' ? SizedBox.shrink() : Positioned(
                    right: 0,
                    child: Container(
                      height: ScreenUtil().setHeight(50),
                      width: ScreenUtil().setWidth(50),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(.4),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text('${widget.productsBean.hotOffer}'),
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
                  widget.productsBean.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4),
                ),
                Text(
                  '${widget.productsBean.regularPrice} ${AppUtils.currency}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: widget.productsBean.totalRates.toDouble(),
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
                      '(${widget.productsBean.totalRates})',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                counter > 0
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
                    if (counter < 1) {
                      counter = 0;
                      addToCart = false;
                      removeItemFromCart(AppUtils.userData.id, widget.productsBean.id);
                      counter = 0;
                      setState(() {});
                      return;
                    } else {
                      isLoading = true;
                      setState(() {});
                      updateCartCounter();
                    }
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
    counter++;
    AddToCartRequest requestObject = AddToCartRequest();
    requestObject.cartProducts.add(
      CartProductsBean(
        userId: AppUtils.userData.id,
        vendorId: widget.productsBean.vendorId,
        quantity: counter,
        productId: widget.productsBean.id,
      ),
    );
    await cartBloc.addToMyCart(requestObject);
    isLoading = false;
    setState(() {});
  }

  void removeItemFromCart(userId, productId) async {
    isLoading = true;
    setState(() {});
    await cartBloc.deleteCartItem(null, userId: userId, productId: productId);
    isLoading = false;
    setState(() {});
  }

  void updateCartCounter() async {
    isLoading = true;
    setState(() {});
    await cartBloc.updateCartItem(AppUtils.userData.id, widget.productsBean.id, counter);
    isLoading = false;
    setState(() {});
  }
}
