
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/cart/my_cart_page.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/views/more/more_page.dart';
import 'package:phinex/ui/views/notifications/notifications_page.dart';
import 'package:phinex/ui/views/wishlist/wishlist_page.dart';
import 'package:phinex/utils/consts.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          ListTile(
            onTap: () {
              Provider.of<PageProvider>(context, listen: false).setPage(HomeContents.pageIndex, HomeContents());
            },
            leading: Icon(Icons.home, color: deepBlueColor,),
            title: Text(translate(context, 'home'), style: TextStyle(color: deepBlueColor),),
            trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey,),
          ),
          ListTile(
            onTap: () {
              Provider.of<PageProvider>(context, listen: false).setPage(MyCart.pageIndex, MyCart());
            },
            leading: Icon(Icons.shopping_cart_outlined, color: deepBlueColor,),
            title: Text(translate(context, 'cart'), style: TextStyle(color: deepBlueColor),),
            trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey,),
          ),
          ListTile(
            onTap: () {
              Provider.of<PageProvider>(context, listen: false).setPage(WishlistPage.pageIndex, WishlistPage());
            },
            leading: Icon(Icons.favorite, color: deepBlueColor,),
            title: Text(translate(context, 'wishlist'), style: TextStyle(color: deepBlueColor),),
            trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey,),
          ),
          ListTile(
            onTap: () {
              Provider.of<PageProvider>(context, listen: false).setPage(NotificationPage.pageIndex, NotificationPage());
            },
            leading: Icon(Icons.notifications_rounded, color: deepBlueColor,),
            title: Text(translate(context, 'notifications'), style: TextStyle(color: deepBlueColor),),
            trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey,),
          ),
          ListTile(
            onTap: () {
              Provider.of<PageProvider>(context, listen: false).setPage(MorePage.pageIndex, MorePage());
            },
            leading: Icon(Icons.menu, color: deepBlueColor,),
            title: Text(translate(context, 'more'), style: TextStyle(color: deepBlueColor),),
            trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey,),
          ),
        ],
      ),
    );
  }
}
