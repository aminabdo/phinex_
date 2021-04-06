import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/store/store_responses/ProductsBean.dart';
import 'package:phinex/Bles/Model/responses/vendor/vendor_by_id/VendorBean.dart';
import 'package:phinex/Bles/Model/responses/vendor/vendor_by_id/VendorByIDResponse.dart';
import 'package:phinex/Bles/bloc/store/VendorBloc.dart';
import 'package:phinex/ui/views/rate_item/rate_item_page.dart';
import 'package:phinex/ui/views/store/store_card_item.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_contacts_info.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_rating_bar.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'vendor_products_page.dart';

class VendorProfilePage extends StatefulWidget {
  final dynamic vendorId;

  const VendorProfilePage({Key key, this.vendorId}) : super(key: key);

  @override
  _VendorProfilePageState createState() => _VendorProfilePageState();
}

class _VendorProfilePageState extends State<VendorProfilePage> {
  int skip = 0;
  int take = 10;

  @override
  void initState() {
    super.initState();

    vendorBloc.clear();
    vendorBloc.getVendor(widget.vendorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        '${AppLocalization.of(context).translate('profile')}',
        context,
      ),
      body: StreamBuilder<VendorByIDResponse>(
        stream: vendorBloc.vendorByID.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            VendorBean theVendor = snapshot.data.data;
            return SingleChildScrollView(
              physics: bouncingScrollPhysics,
              child: Column(
                children: [
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        child: CachedNetworkImage(
                          imageUrl: theVendor.details.imageUrl,
                          fit: BoxFit.fill,
                          errorWidget: (_, __, ___) {
                            return Image.asset(
                              'assets/images/avatar.png',
                              fit: BoxFit.fill,
                            );
                          },
                          placeholder: (context, url) {
                            return Loader(
                              size: 40,
                            );
                          },
                        ),
                        width: double.infinity,
                        height: ScreenUtil().setHeight(220),
                      ),
                      Positioned(
                        bottom: -25,
                        left: 10,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          backgroundImage: CachedNetworkImageProvider(
                            theVendor.details.imageUrl,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(28),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setHeight(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  theVendor.username.length > 30
                                      ? theVendor.username.substring(0, 30)
                                      : theVendor.username,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(8),
                                ),
                                Text(
                                  theVendor.details.totalRates.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.yellow[800],
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(8),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 18,
                                  color: Colors.yellow[800],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(8),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(8),
                              ),
                              child: Text(
                                theVendor.details.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  contactsContainer(theVendor),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  theVendor.products.length == 0
                      ? SizedBox.shrink()
                      : relatedProductsContainer(theVendor),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  reviewContainer(theVendor),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('error'),
            );
          } else {
            return Loader();
          }
        },
      ),
    );
  }

  Widget contactsContainer(VendorBean theVendor) {
    return MyContactsInfoContainer(
      theVendor.details.addressLatitude.toString(),
      theVendor.details.addressLongitude.toString(),
      phone: theVendor.details.contactNumber,
      address: theVendor.details.address,
      email: theVendor.details.email,
      website: null,
    );
  }

  Widget relatedProductsContainer(VendorBean theVendor) {
    return Container(
      height: ScreenUtil().setHeight(400),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${theVendor.products.length} ${AppLocalization.of(context).translate('products')}',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => VendorMoreProductsPage(
                          vendorId: theVendor.details.vendorId,
                          vendorName: theVendor.username,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalization.of(context).translate('see_all'),
                    style: TextStyle(
                      color: mainColor,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: ScreenUtil().setWidth(8),
            ),
            Expanded(
              child: ListView.builder(
                physics: bouncingScrollPhysics,
                itemBuilder: (context, index) {
                  return Container(
                    width: ScreenUtil().setWidth(240),
                    child: StoreCartItem(
                      productsBean: ProductsBean(
                          totalRates: theVendor.products[index].totalRates,
                          regularPrice: theVendor.products[index].regularPrice,
                          name: theVendor.products[index].name,
                          imageUrl: theVendor.products[index].imageUrl,
                          vendorId: theVendor.products[index].vendorId,
                          id: theVendor.products[index].id),
                    ),
                    height: ScreenUtil().setHeight(280),
                  );
                },
                itemCount: theVendor.products.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewContainer(VendorBean theVendor) {
    return Container(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalization.of(context).translate('reviews'),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (AppUtils.userData == null) {
                        AppUtils.showNeedToRegisterDialog(context);
                        return;
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RateItemPage(
                            itemName: theVendor.username,
                            productID: theVendor.details.vendorId,
                            objectName: RateObjectName.vendor,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      AppLocalization.of(context)
                          .translate('write_your_review'),
                      style: TextStyle(
                        fontSize: 16,
                        color: mainColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(8),
              ),
              theVendor.rating.length == 0
                  ? Text(
                      AppLocalization.of(context).translate('no_reviews_yet'))
                  : Container(
                      width: double.infinity,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(theVendor.rating[index].user.username),
                                MyRatingBar(
                                    rate: theVendor.rating[index].rate ?? 0),
                              ],
                            ),
                            subtitle: Text(
                              theVendor.rating[index].comment,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CircleAvatar(
                              backgroundImage:
                                  theVendor.rating[index].user.imageUrl ==
                                              null ||
                                          theVendor.rating[index].user.imageUrl
                                              .isEmpty
                                      ? Image.asset(
                                          'assets/images/avatar.png',
                                        ).image
                                      : CachedNetworkImageProvider(
                                          theVendor.rating[index].user.imageUrl,
                                        ),
                            ),
                          );
                        },
                        itemCount: theVendor.rating.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: ScreenUtil().setHeight(6),
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: ScreenUtil().setHeight(14),
              ),
              theVendor.rating.length == 0
                  ? SizedBox.shrink()
                  : Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          skip += 10;
                          take += 10;
                          vendorBloc.getVendorRating(
                            BaseRequestSkipTake(
                              id: widget.vendorId,
                              take: take,
                              skip: skip,
                            ),
                          );
                        },
                        child: Text(
                          AppLocalization.of(context).translate('see_more'),
                          style: TextStyle(
                            fontSize: 14,
                            color: deepBlueColor,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
