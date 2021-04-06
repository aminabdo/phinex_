import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/real_state/RealStateSingleResponse.dart';
import 'package:phinex/Bles/bloc/real_state/RealState.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import '../photo_view/photo_view_page.dart';

class RealStateDetailsPage extends StatefulWidget {
  final int id;
  final String title;

  const RealStateDetailsPage({Key key, @required this.id, @required this.title})
      : super(key: key);

  @override
  _RealStateDetailsPageState createState() => _RealStateDetailsPageState();
}

class _RealStateDetailsPageState extends State<RealStateDetailsPage> {
  int currentItem = 0;
  bool readMore = false;

  @override
  void initState() {
    super.initState();

    realStateBloc.clear();
    realStateBloc.getSingle(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.title, context),
      backgroundColor: scaffoldBackgroundColor,
      body: StreamBuilder<RealStateSingleResponse>(
        stream: realStateBloc.single.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CarouselSlider(
                        items: List.generate(
                          snapshot.data.data.gallery.length,
                          (index) => snapshot.data.data.gallery[index] ==
                                      null ||
                                  snapshot.data.data.gallery[index] == ''
                              ? Image.asset(
                                  'assets/images/no-product-image.png')
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PhotoViewPage(
                                          imageUrl:
                                              snapshot.data.data.gallery[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: snapshot.data.data.gallery[index],
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          snapshot.data.data.gallery[index],
                                      height: ScreenUtil().setHeight(200),
                                      fit: BoxFit.fill,
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
                        options: CarouselOptions(
                          height: ScreenUtil().setHeight(320),
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          onPageChanged: (int index, _) {
                            currentItem = index;
                            setState(() {});
                          },
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 0,
                        left: 0,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              snapshot.data.data.gallery.length,
                              (index) => AnimatedContainer(
                                margin: EdgeInsets.only(right: 5),
                                duration: Duration(milliseconds: 600),
                                width: ScreenUtil().setWidth(10),
                                height: ScreenUtil().setHeight(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentItem == index
                                      ? mainColor
                                      : mainColor.withOpacity(.3),
                                ),
                              ),
                            ).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: ScreenUtil().setHeight(8),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(11)),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(12),
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalization.of(context)
                                      .translate('owner_contacts'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(10),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: deepBlueColor,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(8),
                                        ),
                                        Text(
                                          snapshot.data.data.phone.toString(),
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          color: deepBlueColor,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(8),
                                        ),
                                        Text(
                                          snapshot.data.data.developer.email ??
                                              AppLocalization.of(context)
                                                  .translate(
                                                      'no_email_address'),
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(12),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: deepBlueColor,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(8),
                                        ),
                                        Text(
                                          snapshot.data.data.developer
                                                  .address ??
                                              AppLocalization.of(context)
                                                  .translate('no_address'),
                                          style: TextStyle(
                                              color: Colors.blue[800],
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.language,
                                          color: deepBlueColor,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(8),
                                        ),
                                        Text(
                                          AppLocalization.of(context)
                                              .translate('no_website'),
                                          style: TextStyle(
                                            color: Colors.blue[800],
                                            fontSize: 14,
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
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(12),
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalization.of(context)
                                          .translate('villa_details'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${snapshot.data.data.price} ${AppUtils.currency}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(8),
                                ),
                                Text(
                                  snapshot.data.data.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: readMore ? 30 : 1,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(14),
                                ),
                                snapshot.data.data.description.length < 70
                                    ? SizedBox.shrink()
                                    : GestureDetector(
                                        child: Text(
                                          readMore
                                              ? AppLocalization.of(context)
                                                  .translate('read_less')
                                              : AppLocalization.of(context)
                                                  .translate('read_more'),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: deepBlueColor,
                                          ),
                                        ),
                                        onTap: () {
                                          readMore = !readMore;
                                          setState(() {});
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(8),
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalization.of(context)
                                      .translate('features'),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(8),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                                ListTile(
                                  leading:
                                      Image.asset('assets/images/type.png'),
                                  title: Text(translate(context, 'type')),
                                  trailing: Text(snapshot.data.data.estateType
                                      .toUpperCase()),
                                ),
                                ListTile(
                                  leading:
                                      Image.asset('assets/images/category.png'),
                                  title: Text(translate(context, 'category')),
                                  trailing: Text(snapshot
                                      .data.data.realstateCategory
                                      .toUpperCase()),
                                ),
                                ListTile(
                                  leading: Image.asset(
                                      'assets/images/finishing.png'),
                                  title: Text(translate(context, 'finishing')),
                                  trailing: Text(snapshot
                                      .data.data.estateFinishing
                                      .toUpperCase()),
                                ),
                                ListTile(
                                  leading: Image.asset(
                                      'assets/images/furnishing.png'),
                                  title: Text(translate(context, 'furnishing')),
                                  trailing: Text(snapshot
                                      .data.data.estateFurnishing
                                      .toUpperCase()),
                                ),
                                ListTile(
                                  leading: Image.asset(
                                      'assets/images/floor_space.png'),
                                  title:
                                      Text(translate(context, 'flore_space')),
                                  trailing: Text(
                                      snapshot.data.data.floorSpace.toString()),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(8),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                                ListTile(
                                  leading:
                                      Image.asset('assets/images/security.png'),
                                  title: Text(translate(context, 'security')),
                                  trailing: hasFeatureWidget(
                                    snapshot.data.data.hasSecurity == 0
                                        ? false
                                        : true,
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset(
                                      'assets/images/maid_service.png'),
                                  title:
                                      Text(translate(context, 'maid_service')),
                                  trailing: hasFeatureWidget(
                                    snapshot.data.data.hasMaidService == 0
                                        ? false
                                        : true,
                                  ),
                                ),
                                ListTile(
                                  leading:
                                      Image.asset('assets/images/garden.png'),
                                  title: Text(translate(context, 'garden')),
                                  trailing: hasFeatureWidget(
                                    snapshot.data.data.hasGarden == 0
                                        ? false
                                        : true,
                                  ),
                                ),
                                ListTile(
                                  leading:
                                      Image.asset('assets/images/bbq_area.png'),
                                  title: Text(translate(context, 'bbq_area')),
                                  trailing: hasFeatureWidget(
                                    snapshot.data.data.hasBbqArea == 0
                                        ? false
                                        : true,
                                  ),
                                ),
                                ListTile(
                                  leading:
                                      Image.asset('assets/images/wardrobe.png'),
                                  title: Text(translate(context, 'wardrobes')),
                                  trailing: hasFeatureWidget(
                                    snapshot.data.data.hasBuiltInWardrobes == 0
                                        ? false
                                        : true,
                                  ),
                                ),
                                ListTile(
                                  leading:
                                      Image.asset('assets/images/children.png'),
                                  title: Text(
                                      translate(context, 'children_play_area')),
                                  trailing: hasFeatureWidget(
                                    snapshot.data.data.hasChildrenPlayArea == 0
                                        ? false
                                        : true,
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset(
                                      'assets/images/concriege.png'),
                                  title: Text('Concierge'),
                                  trailing: hasFeatureWidget(
                                    snapshot.data.data.hasConcierge == 0
                                        ? false
                                        : true,
                                  ),
                                ),
                                ListTile(
                                  leading:
                                      Image.asset('assets/images/parking.png'),
                                  title: Text(
                                      translate(context, 'covered_parking')),
                                  trailing: hasFeatureWidget(
                                    snapshot.data.data.hasCoverdParking == 0
                                        ? false
                                        : true,
                                  ),
                                ),
                                ListTile(
                                  leading:
                                      Image.asset('assets/images/kitchen.png'),
                                  title: Text(
                                      translate(context, 'kitchen_appliance')),
                                  trailing: hasFeatureWidget(
                                    snapshot.data.data.hasKitchenAppliances == 0
                                        ? false
                                        : true,
                                  ),
                                ),
                                ListTile(
                                  leading:
                                      Image.asset('assets/images/pool.png'),
                                  title: Text(translate(context, 'pool')),
                                  trailing: hasFeatureWidget(
                                    snapshot.data.data.hasPool == 0
                                        ? false
                                        : true,
                                  ),
                                ),
                                ListTile(
                                  leading:
                                      Image.asset('assets/images/view.png'),
                                  title: Text(translate(context, 'view')),
                                  trailing: hasFeatureWidget(
                                    snapshot.data.data.hasView == 0
                                        ? false
                                        : true,
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset(
                                      'assets/images/pets_allowed.png'),
                                  title: Text(translate(context, 'pets_allow')),
                                  trailing: hasFeatureWidget(
                                    snapshot.data.data.petsAllowed == 0
                                        ? false
                                        : true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
    );
  }

  Widget hasFeatureWidget(bool hasFeature) {
    return Container(
      width: ScreenUtil().setWidth(25),
      height: ScreenUtil().setHeight(25),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: hasFeature ? mainColor : deepBlueColor,
      ),
      child: hasFeature
          ? Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
