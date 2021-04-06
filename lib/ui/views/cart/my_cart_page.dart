import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/cart/CartUserResponse.dart';
import 'package:phinex/Bles/bloc/store/CartBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/checkout/checkout_page.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'my_cart_item.dart';

class MyCart extends StatefulWidget {
  static final int pageIndex = 1;

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  void initState() {
    super.initState();
    cartBloc.clear();
    cartBloc.getUserCart(AppUtils.userData.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: myAppBar(
        AppLocalization.of(context).translate('cart'),
        context,
        withLeading: false,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false).setPage(HomeContents.pageIndex, HomeContents());
          return false;
        },
        child: StreamBuilder<CartUserResponse>(
          stream: cartBloc.userCart.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: bouncingScrollPhysics,
                      child: Column(
                        children: [
                          ListView.builder(
                            key: Key(snapshot.data.data.length.toString()),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.data.length,
                            itemBuilder: (context, index) {
                              return MyCartItem(
                                currentProduct: snapshot.data.data[index],

                                onAddBtnClicked: (dynamic price, int counter) {
                                  snapshot.data.totalPrice += price.toDouble();
                                  setState(() {});
                                },

                                onNegativeBtnClicked: (dynamic price, int counter) {
                                  snapshot.data.totalPrice -= price.toDouble();
                                  setState(() {});
                                },

                                onDeleteItemClicked: (dynamic price, int counter) async {
                                  var item = snapshot.data.data[index];
                                  cartBloc.userCart.value.data.remove(item);
                                  cartBloc.deleteCartItem(item);
                                  cartBloc.userCart.value = cartBloc.userCart.value;
                                  snapshot.data.totalPrice -= (price * counter).toDouble();
                                  setState(() {});
                                },

                              );
                            },
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(90),
                          ),
                        ],
                      ),
                    ),
                    snapshot.data.totalPrice == 0.0
                        ? SizedBox.shrink()
                        : Positioned(
                            bottom: 0,
                            left: 10,
                            right: 10,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalization.of(context).translate('total'),
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${AppUtils.currency} ${(snapshot.data.totalPrice).toStringAsFixed(1)}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(30),
                                    ),
                                    Expanded(
                                      child: myButton(
                                        AppLocalization.of(context).translate('checkout'),
                                        btnColor: mainColor,
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => CheckoutPage(
                                                totalPrice: snapshot.data.totalPrice,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('error'),
              );
            }
            return Loader();
          },
        ),
      ),
    );
  }
}
