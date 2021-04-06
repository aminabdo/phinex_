import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/cart/CartUserResponse.dart';
import 'package:phinex/Bles/bloc/store/CartBloc.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class MyCartItem extends StatefulWidget {
  final CartUserBean currentProduct;
  final Function(num price, int counter) onDeleteItemClicked;
  final Function(num price, int counter) onAddBtnClicked;
  final Function(num price, int counter) onNegativeBtnClicked;

  const MyCartItem({
    Key key,
    @required this.currentProduct,
    this.onDeleteItemClicked, this.onAddBtnClicked, this.onNegativeBtnClicked,
  }) : super(key: key);

  @override
  _MyCartItemState createState() => _MyCartItemState();
}

class _MyCartItemState extends State<MyCartItem> {
  int counter;
  CartUserBean product;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    this.product = widget.currentProduct;
    counter = product.quantity ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(ScreenUtil().setWidth(12)),
      elevation: 4,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
            child: product.imageUrl == null || product.imageUrl.isEmpty
                ? Image.asset(
                    'assets/images/no-product-image.png',
                    fit: BoxFit.fill,
                    height: ScreenUtil().setHeight(140),
                    width: ScreenUtil().setWidth(130),
                  )
                : CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    fit: BoxFit.contain,
                    height: ScreenUtil().setHeight(120),
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
                    product.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Text(
                    '${AppUtils.currency} ${product.regularPrice}',
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
                      Expanded(child: counterWidget()),
                      SizedBox(
                        width: ScreenUtil().setWidth(10),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(45),
                        width: ScreenUtil().setWidth(40),
                        decoration: BoxDecoration(
                          color: Color(0xffFDE4E5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              widget.onDeleteItemClicked(product.regularPrice, counter);
                            },
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

  Widget counterWidget() {
    return Container(
      height: ScreenUtil().setHeight(45),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffF0F0F0),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Color(0xffF0F0F0), width: .5),
      ),
      child: isLoading
          ? Loader(
              size: 20,
            )
          : Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (counter == 1) {
                      return;
                    } else {
                      counter--;
                      isLoading = true;
                      widget.onNegativeBtnClicked(product.regularPrice, counter);
                      setState(() {});
                      updateItemQuantity();
                    }
                  },
                  child: Container(
                    width: ScreenUtil().setWidth(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xfF0F0F0),
                    ),
                    height: ScreenUtil().setHeight(45),
                    child: Icon(
                      Icons.remove,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '$counter',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    counter++;
                    isLoading = true;
                    setState(() {});
                    updateItemQuantity();
                    widget.onAddBtnClicked(product.regularPrice, counter);
                  },
                  child: Container(
                    width: ScreenUtil().setWidth(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xffF0F0F0),
                    ),
                    height: ScreenUtil().setHeight(45),
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void updateItemQuantity() async {
    var currentProduct = product;
    currentProduct.quantity = counter;

    await cartBloc.updateCartItem(AppUtils.userData.id, product.productId, counter);

    isLoading = false;
    setState(() {});
  }
}
