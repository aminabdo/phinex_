import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/cart/AddToCartRequest.dart';
import 'package:phinex/Bles/Model/requests/wish_list/AddToWishListRequest.dart';
import 'package:phinex/Bles/bloc/store/CartBloc.dart';
import 'package:phinex/Bles/bloc/store/WishListBloc.dart';
import 'package:phinex/ui/views/store/store_item_details_page.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacyProductsResponse.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';


class SingleMedicineCartItem extends StatefulWidget {
  final ProductsBean product;

  const SingleMedicineCartItem({Key key, @required this.product})
      : super(key: key);

  @override
  _SingleMedicineCartItemState createState() => _SingleMedicineCartItemState();
}

class _SingleMedicineCartItemState extends State<SingleMedicineCartItem> {
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
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => StoreCartItemDetailsPage(
                          isFavourite: favourite,
                          quantity: counter,
                          productId: widget.product.id,
                          productName: widget.product.name,
                          price: widget.product.regularPrice.toDouble(),
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
                      child: widget.product.imageUrl == null ||
                              widget.product.imageUrl == ''
                          ? Image.asset(
                              'assets/images/no-product-image.png',
                              fit: BoxFit.fill,
                              height: ScreenUtil().setHeight(200),
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.product.imageUrl,
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
                            product_id: widget.product.id,
                          ),
                        );
                      } else {
                        wishlistBloc.deleteFromWishList(
                          WishListRequest(
                            user_id: AppUtils.userData.id,
                            product_id: widget.product.id,
                          ),
                        );
                      }
                      setState(() {});
                    },
                    child: Container(
                      width: ScreenUtil().setWidth(30),
                      padding: EdgeInsets.all(8),
                      height: ScreenUtil().setHeight(30),
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
                // Positioned(
                //   right: 0,
                //   child: Container(
                //     height: ScreenUtil().setHeight(50),
                //     width: ScreenUtil().setWidth(50),
                //     padding: EdgeInsets.all(5),
                //     decoration: BoxDecoration(
                //       color: Colors.red.withOpacity(.4),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Center(
                //       child: Text('15%'),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4),
                ),
                Text(
                  '${widget.product.regularPrice} ${AppUtils.currency}',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: mainColor),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: widget.product.totalRates.toDouble(),
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
                      '(${widget.product.totalRates.toDouble()})',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(14),
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
        vendorId: widget.product.vendorId,
        quantity: counter,
        productId: widget.product.id,
      ),
    );
    await cartBloc.addToMyCart(requestObject);
    isLoading = false;
    setState(() {});
  }

  void updateCartCounter() async {
    isLoading = true;
    setState(() {});
    await cartBloc.updateCartItem(
        AppUtils.userData.id, widget.product.id, counter);
    isLoading = false;
    setState(() {});
  }
}
