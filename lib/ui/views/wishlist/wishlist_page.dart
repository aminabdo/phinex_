import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/wish_list/AddToWishListRequest.dart';

import 'package:phinex/Bles/Model/responses/wish_list/wish_list_by_user/WishListResponse.dart';
import 'package:phinex/Bles/bloc/store/WishListBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';

import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'wishlist_item.dart';

class WishlistPage extends StatefulWidget {
  static final int pageIndex = 2;

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    wishlistBloc.clear();
    wishlistBloc.getWishListUser(AppUtils.userData.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: myAppBar(
        AppLocalization.of(context).translate('wishlist'),
        context,
        withLeading: false,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, HomeContents());
          return false;
        },
        child: StreamBuilder<WishListResponse>(
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              print('products length stream  ${snapshot.data.data.length}');
              return ListView.builder(
                physics: bouncingScrollPhysics,
                itemBuilder: (context, index) {
                  return snapshot.data.data.isEmpty
                      ? SizedBox.shrink()
                      : WishlistItem(
                          index: index,
                          products: snapshot.data.data,
                          onDeletedBtnTapped: () {
                            setState(() {});
                            wishlistBloc.deleteFromWishList(
                              WishListRequest(
                                product_id: snapshot.data.data[index].productId,
                                user_id: AppUtils.userData.id,
                              ),
                            );
                            snapshot.data.data.removeAt(index);
                          },
                          onMoveToCartBtbClicked: () {
                            wishlistBloc.deleteFromWishList(
                              WishListRequest(
                                product_id: snapshot.data.data[index].productId,
                                user_id: AppUtils.userData.id,
                              ),
                            );
                            snapshot.data.data.removeAt(index);
                            setState(() {});
                          },
                        );
                },
                itemCount: snapshot.data.data.length,
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('error'),
              );
            }
            return Loader();
          },
          stream: wishlistBloc.wishList.stream,
        ),
      ),
    );
  }
}
