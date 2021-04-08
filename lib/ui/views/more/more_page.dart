import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/bloc/auth/UserBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/auctions/my_auctions_page.dart';
import 'package:phinex/ui/views/auctions/subscriped_auctions_page.dart';
import 'package:phinex/ui/views/auth/login_page.dart';
import 'package:phinex/ui/views/became_a_partner/became_a_partner_main_page.dart';
import 'package:phinex/ui/views/help/help_page.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/views/lot/my_lot_page.dart';
import 'package:phinex/ui/views/lot/subscriped_lot_page.dart';
import 'package:phinex/ui/views/orders/my_orders_page.dart';
import 'package:phinex/ui/views/profile/profile_page.dart';
import 'package:phinex/ui/views/reservations/my_reservations_page.dart';
import 'package:phinex/ui/views/settings/settings_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

Widget drawerItem(
  BuildContext context,
  String title,
  IconData icon, {
  Function onTap,
  double iconSize,
  Color iconColor,
  Color textColor,
  Color arrowColor,
  Color containerColor,
}) {
  return ListTile(
    onTap: onTap,
    trailing: Icon(
      Localizations.localeOf(context).languageCode == 'ar'
          ? Icons.arrow_back_ios_rounded
          : Icons.arrow_forward_ios_outlined,
      color: arrowColor ?? mainColor,
    ),
    title: Text(
      title,
      style: TextStyle(fontSize: 16, color: textColor),
    ),
    leading: Container(
      width: ScreenUtil().setWidth(35),
      height: ScreenUtil().setHeight(35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: containerColor ?? deepBlueColor,
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor ?? Colors.white,
          size: iconSize ?? 18,
        ),
      ),
    ),
  );
}

class MorePage extends StatefulWidget {
  static final int pageIndex = 4;

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  bool isVIP = false;
  bool isLoggedin = false;

  @override
  void initState() {
    super.initState();

    isLoggedin = AppUtils.userData == null ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        AppLocalization.of(context).translate('more'),
        context,
        withLeading: false,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, HomeContents());
          return false;
        },
        child: SingleChildScrollView(
          physics: bouncingScrollPhysics,
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                width: MediaQuery.of(context).size.width,
                height: ScreenUtil().setHeight(isVIP ? 120 : 160),
                color: isVIP ? Color(0xffFAF7EC) : Colors.white,
                child: isLoggedin
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: ScreenUtil().setHeight(isVIP ? 15 : 5),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Stack(
                                          overflow: Overflow.visible,
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage: AppUtils.userData.imageUrl == null || AppUtils.userData.imageUrl == ''
                                                  ? AssetImage(
                                                      'assets/images/avatar.png',
                                                    )
                                                  : CachedNetworkImageProvider(
                                                      AppUtils
                                                          .userData.imageUrl,
                                                    ),
                                            ),
                                            isVIP
                                                ? Positioned(
                                                    top: Localizations.localeOf(
                                                                    context)
                                                                .languageCode ==
                                                            'ar'
                                                        ? -15
                                                        : -9,
                                                    child: Transform(
                                                      transform: Localizations
                                                                      .localeOf(
                                                                          context)
                                                                  .languageCode ==
                                                              'ar'
                                                          ? (Matrix4.identity()
                                                            ..rotateZ(30 *
                                                                2.7415927 /
                                                                180))
                                                          : (Matrix4.identity()
                                                            ..rotateZ(-40 *
                                                                2.0415927 /
                                                                180)),
                                                      child: Icon(
                                                        FontAwesomeIcons.crown,
                                                        color: goldColor,
                                                        size: 16,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ],
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(14),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppUtils.userData.firstName + ' ' + AppUtils.userData.lastName,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Provider.of<PageProvider>(
                                                        context,
                                                        listen: false)
                                                    .setPage(
                                                        ProfilePage.pageIndex,
                                                        ProfilePage());
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    AppLocalization.of(context)
                                                        .translate(
                                                      'profile',
                                                    ),
                                                    style: TextStyle(
                                                      color: mainColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: ScreenUtil()
                                                        .setWidth(5),
                                                  ),
                                                  Icon(
                                                    FontAwesomeIcons.solidEdit,
                                                    size: 13,
                                                    color: mainColor,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(5),
                            ),
                            // isVIP
                            //     ? SizedBox.shrink()
                            //     : Container(
                            //         margin: EdgeInsets.symmetric(
                            //           horizontal: ScreenUtil().setWidth(30),
                            //         ),
                            //         height: ScreenUtil().setHeight(40),
                            //         width: MediaQuery.of(context).size.width,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(20),
                            //           color: Color(0xffF3F0E5),
                            //         ),
                            //         child: ClipRRect(
                            //           borderRadius: BorderRadius.circular(20),
                            //           child: FlatButton(
                            //             onPressed: () {
                            //               isVIP = true;
                            //               setState(() {});
                            //             },
                            //             child: Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.center,
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.center,
                            //               children: [
                            //                 Text(
                            //                   AppLocalization.of(context)
                            //                       .translate('upgrade_to_vip'),
                            //                   style: TextStyle(
                            //                     color: goldColor,
                            //                     fontSize: 12,
                            //                   ),
                            //                 ),
                            //                 SizedBox(
                            //                   width: ScreenUtil().setWidth(15),
                            //                 ),
                            //                 Icon(
                            //                   FontAwesomeIcons.crown,
                            //                   color: goldColor,
                            //                   size: 14,
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            SizedBox(
                              height: ScreenUtil().setHeight(isVIP ? 16 : 25),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (_) => LoginPage(),
                              ),
                            )
                                .then(
                              (value) {
                                Provider.of<PageProvider>(context,
                                        listen: false)
                                    .setPage(
                                        HomeContents.pageIndex, HomeContents());
                              },
                            );
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: ScreenUtil().setWidth(18),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xffBEBEBE),
                                child: Icon(
                                  Icons.person,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(12),
                              ),
                              Text(
                                AppLocalization.of(context)
                                    .translate('login_signup'),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(6),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.grey,
                      width: .5,
                    ),
                  ),
                ),
                child: drawerItem(
                  context,
                  AppLocalization.of(context).translate('orders'),
                  FontAwesomeIcons.shoppingBag,
                  onTap: () {
                    if (AppUtils.userData == null) {
                      AppUtils.showNeedToRegisterDialog(context);
                      return;
                    }
                    Provider.of<PageProvider>(context, listen: false)
                        .setPage(MyOrdersPage.pageIndex, MyOrdersPage());
                  },
                  arrowColor: Colors.grey,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.grey,
                      width: .5,
                    ),
                  ),
                ),
                child: drawerItem(
                  context,
                  AppLocalization.of(context).translate('reservations'),
                  FontAwesomeIcons.stethoscope,
                  onTap: () {
                    if (AppUtils.userData == null) {
                      AppUtils.showNeedToRegisterDialog(context);
                      return;
                    }

                    Provider.of<PageProvider>(context, listen: false).setPage(MyReservationsPage.pageIndex, MyReservationsPage());
                  },
                  arrowColor: Colors.grey,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(25),
              ),
              isLoggedin
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: Colors.grey,
                            width: .5,
                          ),
                        ),
                      ),
                      child: drawerItem(
                        context,
                        AppLocalization.of(context)
                            .translate('subscribed_auction'),
                        FontAwesomeIcons.gavel,
                        onTap: () {
                          if (AppUtils.userData == null) {
                            AppUtils.showNeedToRegisterDialog(context);
                            return;
                          }
                          // Provider.of<PageProvider>(context, listen: false)
                          //     .setPage(SubscribedAuctionsPage.pageIndex,
                          //         SubscribedAuctionsPage());
                        },
                        arrowColor: Colors.grey,
                      ),
                    )
                  : SizedBox.shrink(),
              isLoggedin
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: Colors.grey,
                            width: .5,
                          ),
                        ),
                      ),
                      child: drawerItem(
                        context,
                        AppLocalization.of(context).translate('my_auctions'),
                        FontAwesomeIcons.gavel,
                        onTap: () {
                          if (AppUtils.userData == null) {
                            AppUtils.showNeedToRegisterDialog(context);
                            return;
                          }
                          // Provider.of<PageProvider>(context, listen: false)
                          //     .setPage(
                          //         MyAuctionsPage.pageIndex, MyAuctionsPage());
                        },
                        arrowColor: Colors.grey,
                      ),
                    )
                  : SizedBox.shrink(),
              Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.grey,
                      width: .5,
                    ),
                  ),
                ),
                child: drawerItem(
                  context,
                  AppLocalization.of(context).translate('settings'),
                  Icons.settings,
                  iconSize: 20,
                  onTap: () {
                    Provider.of<PageProvider>(context, listen: false)
                        .setPage(SettingsPage.pageIndex, SettingsPage());
                  },
                  arrowColor: Colors.grey,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.grey,
                      width: .5,
                    ),
                  ),
                ),
                child: drawerItem(
                  context,
                  AppLocalization.of(context).translate('help'),
                  FontAwesomeIcons.infoCircle,
                  arrowColor: Colors.grey,
                  onTap: () {
                    if (AppUtils.userData == null) {
                      AppUtils.showNeedToRegisterDialog(context);
                      return;
                    }
                    Provider.of<PageProvider>(context, listen: false)
                        .setPage(HelpPage.pageIndex, HelpPage());
                  },
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(25),
              ),
              isLoggedin
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: Colors.grey,
                            width: .5,
                          ),
                        ),
                      ),
                      child: drawerItem(
                        context,
                        AppLocalization.of(context).translate('logout'),
                        Icons.logout,
                        textColor: Colors.red,
                        containerColor: Colors.transparent,
                        iconSize: 22,
                        arrowColor: Colors.grey,
                        iconColor: Colors.red,
                        onTap: () async {
                          authBloc.clear();
                          await AppUtils.clearUserData();
                          setState(() {

                          });
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (_) => LoginPage(),
                              ),
                              (_) => false);
                        },
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BecameAPartnerMainPage(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        width: 1,
                        color: Colors.grey[350],
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalization.of(context).translate('became_a_partner'),
                      style: TextStyle(color: mainColor, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
