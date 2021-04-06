import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/cart/AddToCartRequest.dart';
import 'package:phinex/Bles/Model/responses/wish_list/wish_list_by_user/WishListResponse.dart';
import 'package:phinex/Bles/bloc/store/CartBloc.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class WishlistItem extends StatefulWidget {
  final List<WishListBean> products;
  final int index;
  final Function onDeletedBtnTapped;
  final Function onMoveToCartBtbClicked;

  const WishlistItem({
    Key key,
    this.products,
    this.index,
    this.onDeletedBtnTapped,
    this.onMoveToCartBtbClicked,
  }) : super(key: key);

  @override
  _WishlistItemState createState() => _WishlistItemState();
}

class _WishlistItemState extends State<WishlistItem> {
  List<WishListBean> products;
  int index;

  @override
  void initState() {
    super.initState();

    this.products = widget.products;
    this.index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return products[index] == null ? Container() : Card(
      elevation: 4,
      margin: EdgeInsets.all(
        ScreenUtil().setWidth(8),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
            child: products[index].product.imageUrl == null ||
                    products[index].product.imageUrl.isEmpty
                ? Image.asset(
                    'assets/images/no-product-image.png',
                    fit: BoxFit.fill,
                    height: ScreenUtil().setHeight(155),
                    width: ScreenUtil().setWidth(130),
                  )
                : CachedNetworkImage(
                    imageUrl: products[index].product.imageUrl,
                    fit: BoxFit.fill,
                    height: ScreenUtil().setHeight(155),
                    placeholder: (_, __) {
                      return Loader(
                        size: 30,
                      );
                    },
                    width: ScreenUtil().setWidth(130),
                    errorWidget: (_, __, ___) {
                      return Icon(Icons.error);
                    },
                  ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products[index].product.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    '${products[index].product.regularPrice} ${AppUtils.currency}',
                    style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: myButton(
                          AppLocalization.of(context).translate('move_to_cart'),
                          onTap: () {
                            AppUtils.showToast(
                                msg: translate(context, 'added'), bgColor: mainColor);
                            AddToCartRequest request = AddToCartRequest();
                            request.cartProducts.add(
                              CartProductsBean(
                                userId: AppUtils.userData.id,
                                vendorId: products[index].product.vendorId,
                                quantity: 1,
                                productId: products[index].product.id,
                              ),
                            );
                            cartBloc.addToMyCart(request);
                            widget.onMoveToCartBtbClicked();
                          },
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(15),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(45),
                        width: ScreenUtil().setWidth(45),
                        decoration: BoxDecoration(
                          color: Color(0xffFDE4E5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            onPressed: widget.onDeletedBtnTapped,
                            child: Center(
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
