import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/bloc/store/CartBloc.dart';
import 'package:phinex/Bles/bloc/store/WishListBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/cart/my_cart_page.dart';
import 'package:phinex/ui/views/more/more_page.dart';
import 'package:phinex/ui/views/notifications/notifications_page.dart';
import 'package:phinex/ui/views/wishlist/wishlist_page.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'home_contents.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays(
      [
        SystemUiOverlay.bottom,
        SystemUiOverlay.top,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: wishlistBloc.wishlistCounter.stream,
        builder: (context, wishlistSnapshot) {
          return StreamBuilder<int>(
              stream: cartBloc.cartCounter.stream,
              builder: (context, cartSnapshot) {
                return Scaffold(
                  backgroundColor: scaffoldBackgroundColor,
                  bottomNavigationBar: BottomNavigationBar(
                    showSelectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    showUnselectedLabels: true,
                    selectedIconTheme: IconThemeData(color: mainColor),
                    selectedLabelStyle: TextStyle(color: mainColor),
                    unselectedItemColor: Colors.grey,
                    selectedItemColor: mainColor,
                    unselectedIconTheme: IconThemeData(color: Colors.grey),
                    unselectedLabelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    currentIndex: Provider.of<PageProvider>(context).pageIndex,
                    onTap: (pageIndex) {
                      if (pageIndex == 1 || pageIndex == 2) {
                        if (AppUtils.userData == null) {
                          AppUtils.showNeedToRegisterDialog(context);
                          return;
                        }
                      }
                      Provider.of<PageProvider>(context, listen: false).setPage(
                        pageIndex,
                        pageIndex == 0
                            ? HomeContents()
                            : pageIndex == 1
                                ? MyCart()
                                : pageIndex == 2
                                    ? WishlistPage()
                                    // : pageIndex == 3
                                    //     ? NotificationPage()
                                        : MorePage(),
                      );
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: AppLocalization.of(context).translate('home'),
                      ),
                      BottomNavigationBarItem(
                        icon: cartSnapshot.data == null
                            ? Icon(Icons.shopping_cart)
                            : Badge(
                                badgeColor: deepBlueColor,
                                child: Icon(Icons.shopping_cart),
                                badgeContent: Text(
                                  cartSnapshot.data.toString() ?? '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                        label: AppLocalization.of(context).translate('cart'),
                      ),
                      BottomNavigationBarItem(
                        icon: wishlistSnapshot.data == null
                            ? Icon(Icons.favorite)
                            : Badge(
                                badgeColor: deepBlueColor,
                                child: Icon(Icons.favorite),
                                badgeContent: Text(
                                  wishlistSnapshot.data.toString() ?? '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                        label:
                            AppLocalization.of(context).translate('wishlist'),
                      ),
                      // BottomNavigationBarItem(
                      //   icon: Icon(Icons.notifications),
                      //   label: AppLocalization.of(context).translate('notifications'),
                      // ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.menu),
                        label: AppLocalization.of(context).translate('more'),
                      ),
                    ],
                  ),
                  body: Consumer<PageProvider>(
                    builder: (context, pageProvider, child) {
                      return pageProvider.page;
                    },
                  ),
                );
              },
          );
        },
    );
  }
}
