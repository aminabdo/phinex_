import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsByUserResponse.dart';
import 'package:phinex/Bles/bloc/professions/Professions.dart';
import 'package:phinex/Bles/bloc/rate/rate_object_bloc.dart';
import 'package:phinex/ui/views/rate_item/rate_item_page.dart';

import 'package:phinex/ui/widgets/my_app_bar.dart';

import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'profession_work_shop_item.dart';

class ProfessionDetailsPage extends StatefulWidget {
  final int id;
  final String title;

  const ProfessionDetailsPage(
      {Key key, @required this.id, @required this.title})
      : super(key: key);

  @override
  _ProfessionDetailsPageState createState() => _ProfessionDetailsPageState();
}

class _ProfessionDetailsPageState extends State<ProfessionDetailsPage> {
  bool getMoreReviews = false;
  int skip = 0;
  int take = 10;

  @override
  void initState() {
    super.initState();

    professionsBloc.getSingle(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.title, context),
      body: StreamBuilder<ProfessionsByUserResponse>(
        stream: professionsBloc.single.stream,
        builder: (context, snapshot) {
          if (professionsBloc.loading.value) {
            return Loader();
          } else {
            var profession = snapshot.data.data;
            return SingleChildScrollView(
              physics: bouncingScrollPhysics,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        profession.imageUrl == null || profession.imageUrl == ''
                            ? Image.asset(
                                'assets/images/no-product-image.png',
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: ScreenUtil().setHeight(300),
                              )
                            : CachedNetworkImage(
                                imageUrl: profession.imageUrl,
                                width: double.infinity,
                                height: ScreenUtil().setHeight(300),
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
                        Positioned(
                          bottom: -25,
                          left: 10,
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: profession.imageUrl == null ||
                                    profession.imageUrl == ''
                                ? AssetImage('assets/images/avatar.png')
                                : CachedNetworkImageProvider(
                                    profession.imageUrl,
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(28),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  profession.commercialName,
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
                                  profession.totalRates.toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.yellow[800]),
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
                            Text(
                              profession.description ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
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
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalization.of(context).translate('contacts'),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      profession.phone,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
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
                                      AppLocalization.of(context)
                                          .translate('no_address'),
                                      style: TextStyle(
                                        color: Colors.blue[800],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(12),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //
                            //     Row(
                            //       children: [
                            //         Icon(
                            //           Icons.language,
                            //           color: deepBlueColor,
                            //           size: 25,
                            //         ),
                            //         SizedBox(
                            //           width: ScreenUtil().setWidth(8),
                            //         ),
                            //         Text(
                            //           AppLocalization.of(context)
                            //               .translate('no_website'),
                            //           style: TextStyle(
                            //             color: Colors.blue[800],
                            //             fontSize: 14,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     Row(
                            //       children: [
                            //         Icon(
                            //           Icons.email,
                            //           color: deepBlueColor,
                            //           size: 25,
                            //         ),
                            //         SizedBox(
                            //           width: ScreenUtil().setWidth(8),
                            //         ),
                            //         Text(
                            //           AppLocalization.of(context)
                            //               .translate('no_email_address'),
                            //           style: TextStyle(fontSize: 14),
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  ListView.builder(
                    itemCount: profession.workshops.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(325),
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profession.workshops[index].title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                          Icons.phone,
                                          color: deepBlueColor,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(8),
                                        ),
                                        Text(
                                          profession.workshops[index].phone,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
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
                                          profession.workshops[index].address ??
                                              AppLocalization.of(context)
                                                  .translate('no_address'),
                                          style: TextStyle(
                                              color: Colors.blue[800],
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(12),
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Row(
                                //       children: [
                                //         Icon(
                                //           Icons.email,
                                //           color: deepBlueColor,
                                //           size: 25,
                                //         ),
                                //         SizedBox(
                                //           width: ScreenUtil().setWidth(8),
                                //         ),
                                //         Text(
                                //           AppLocalization.of(context)
                                //               .translate('no_email_address'),
                                //           style: TextStyle(fontSize: 14),
                                //         ),
                                //       ],
                                //     ),
                                //     Row(
                                //       children: [
                                //         Icon(
                                //           Icons.language,
                                //           color: deepBlueColor,
                                //           size: 25,
                                //         ),
                                //         SizedBox(
                                //           width: ScreenUtil().setWidth(8),
                                //         ),
                                //         Text(
                                //           AppLocalization.of(context)
                                //               .translate('no_website'),
                                //           style: TextStyle(
                                //               color: Colors.blue[800],
                                //               fontSize: 14),
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: ScreenUtil().setHeight(12),
                                // ),
                                Expanded(
                                  child: ListView(
                                    physics: bouncingScrollPhysics,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      profession.workshops[index].saturday !=
                                                  null &&
                                              profession.workshops[index]
                                                      .sunday ==
                                                  1
                                          ? ProfessionWorkShopItem(
                                              translate(context, 'saturday'),
                                              '${profession.workshops[index].openFrom} - ${profession.workshops[index].openTo}',
                                              '25',
                                              snapshot,
                                              index,
                                              6,
                                            )
                                          : SizedBox.shrink(),
                                      profession.workshops[index].sunday !=
                                                  null &&
                                              profession.workshops[index]
                                                      .sunday ==
                                                  1
                                          ? ProfessionWorkShopItem(
                                              translate(context, 'sunday'),
                                              '${profession.workshops[index].openFrom} - ${profession.workshops[index].openTo}',
                                              '25',
                                              snapshot,
                                              index,
                                              7,
                                            )
                                          : SizedBox.shrink(),
                                      profession.workshops[index].monday !=
                                                  null &&
                                              profession.workshops[index]
                                                      .monday ==
                                                  1
                                          ? ProfessionWorkShopItem(
                                              translate(context, 'monday'),
                                              '${profession.workshops[index].openFrom} - ${profession.workshops[index].openTo}',
                                              '25',
                                              snapshot,
                                              index,
                                              1,
                                            )
                                          : SizedBox.shrink(),
                                      profession.workshops[index].tuesday !=
                                                  null &&
                                              profession.workshops[index]
                                                      .tuesday ==
                                                  1
                                          ? ProfessionWorkShopItem(
                                              translate(context, 'tuesday'),
                                              '${profession.workshops[index].openFrom} - ${profession.workshops[index].openTo}',
                                              '25',
                                              snapshot,
                                              index,
                                              2,
                                            )
                                          : SizedBox.shrink(),
                                      profession.workshops[index].wednesday !=
                                                  null &&
                                              profession.workshops[index]
                                                      .wednesday ==
                                                  1
                                          ? ProfessionWorkShopItem(
                                              translate(context, 'wednesday'),
                                              profession
                                                  .workshops[index].openFrom,
                                              '25',
                                              snapshot,
                                              index,
                                              3,
                                            )
                                          : SizedBox.shrink(),
                                      profession.workshops[index].thursday !=
                                                  null &&
                                              profession.workshops[index]
                                                      .thursday ==
                                                  1
                                          ? ProfessionWorkShopItem(
                                              translate(context, 'thursday'),
                                              '${profession.workshops[index].openFrom} - ${profession.workshops[index].openTo}',
                                              '25',
                                              snapshot,
                                              index,
                                              4,
                                            )
                                          : SizedBox.shrink(),
                                      profession.workshops[index].friday !=
                                                  null &&
                                              profession.workshops[index]
                                                      .friday ==
                                                  1
                                          ? ProfessionWorkShopItem(
                                              translate(context, 'friday'),
                                              '${profession.workshops[index].openFrom} - ${profession.workshops[index].openTo}',
                                              '25',
                                              snapshot,
                                              index,
                                              5,
                                            )
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalization.of(context)
                                      .translate('reviews'),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (AppUtils.userData == null) {
                                      AppUtils.showNeedToRegisterDialog(
                                        context,
                                      );

                                      return;
                                    }
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => RateItemPage(
                                          itemName: widget.title,
                                          productID: widget.id,
                                          objectName: RateObjectName.technician,
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
                            Container(
                              width: double.infinity,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: double.infinity,
                                    child: ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            profession
                                                .rate[index].user.username,
                                          ),
                                          RatingBar.builder(
                                            initialRating: profession
                                                .rate[index].rate
                                                .toDouble(),
                                            minRating: 1,
                                            itemSize: 14,
                                            ignoreGestures: true,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                              horizontal: 0.0,
                                            ),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: goldColor,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        profession.rate[index].comment,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      leading: profession.rate[index].user
                                                      .imageUrl ==
                                                  null ||
                                              profession.rate[index].user
                                                      .imageUrl ==
                                                  ''
                                          ? Image.asset(
                                              'assets/images/avatar.png',
                                            )
                                          : Container(
                                              width: 65,
                                              height: 90,
                                              child: CachedNetworkImage(
                                                imageUrl: profession
                                                    .rate[index].user.imageUrl,
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
                                  );
                                },
                                itemCount: profession.rate.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: ScreenUtil().setHeight(6),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(14),
                            ),
                            profession.rate.isEmpty
                                ? SizedBox.shrink()
                                : Align(
                                    alignment: Alignment.centerRight,
                                    child: getMoreReviews
                                        ? Loader(
                                            size: 20,
                                          )
                                        : GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                getMoreReviews = true;
                                              });

                                              await seeMoreBloc.getMoreReviews(
                                                RateObjectName.technician,
                                                widget.id.toString(),
                                                BaseRequestSkipTake(
                                                  skip: skip,
                                                  take: take,
                                                ),
                                              );

                                              skip += 10;
                                              take += 10;
                                              setState(() {
                                                getMoreReviews = false;
                                              });
                                            },
                                            child: Text(
                                              AppLocalization.of(context)
                                                  .translate('see_more'),
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
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
