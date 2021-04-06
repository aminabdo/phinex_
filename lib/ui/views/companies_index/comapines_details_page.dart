import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/index/IndexSingleResponse.dart';
import 'package:phinex/Bles/bloc/index/IndexBloc.dart';
import 'package:phinex/Bles/bloc/rate/rate_object_bloc.dart';
import 'package:phinex/ui/views/rate_item/rate_item_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';

import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class CompaniesDetailsPage extends StatefulWidget {
  final int id;
  final String name;

  const CompaniesDetailsPage({Key key, @required this.id, @required this.name})
      : super(key: key);

  @override
  _CompaniesDetailsPageState createState() => _CompaniesDetailsPageState();
}

class _CompaniesDetailsPageState extends State<CompaniesDetailsPage> {
  bool readMore = false;

  int skip = 0;
  int take = 10;

  bool getMoreReviews = false;

  @override
  void initState() {
    super.initState();

    indexBloc.clear();
    indexBloc.getSingle(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.name, context),
      backgroundColor: scaffoldBackgroundColor,
      body: StreamBuilder<IndexSingleResponse>(
          stream: indexBloc.single.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapshot.data.data.catalogue.imageUrl == null ||
                              snapshot.data.data.catalogue.imageUrl == ''
                          ? Image.asset(
                              'assets/images/no-product-image.png',
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: ScreenUtil().setHeight(250),
                            )
                          : CachedNetworkImage(
                              imageUrl: snapshot.data.data.catalogue.imageUrl,
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: ScreenUtil().setHeight(250),
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
                              snapshot.data.data.catalogue.title,
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
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(8)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalization.of(context)
                                          .translate('company_contacts'),
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
                                              snapshot
                                                  .data.data.catalogue.phone,
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
                                              snapshot.data.data.catalogue
                                                      .email ??
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
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: deepBlueColor,
                                                size: 25,
                                              ),
                                              SizedBox(
                                                width: ScreenUtil().setWidth(8),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  snapshot.data.data.catalogue
                                                          .address ??
                                                      AppLocalization.of(context)
                                                          .translate('no_address'),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.blue[800],
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.language,
                                                color: deepBlueColor,
                                                size: 25,
                                              ),
                                              SizedBox(
                                                width: ScreenUtil().setWidth(8),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  snapshot.data.data.catalogue
                                                          .website ??
                                                      AppLocalization.of(context)
                                                          .translate('no_website'),
                                                  style: TextStyle(
                                                      color: Colors.blue[800],
                                                      fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
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
                                    Text(
                                      AppLocalization.of(context)
                                          .translate('about'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(8),
                                    ),
                                    Text(
                                      snapshot.data.data.catalogue.description,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: readMore ? 30 : 1,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(14),
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        readMore
                                            ? AppLocalization.of(context)
                                                .translate('read_less')
                                            : AppLocalization.of(context)
                                                .translate('read_more'),
                                        style: TextStyle(
                                            fontSize: 14, color: deepBlueColor),
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
                                              .translate('reviews'),
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (AppUtils.userData == null) {
                                              AppUtils.showNeedToRegisterDialog(
                                                  context);
                                              return;
                                            }
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => RateItemPage(
                                                  catalougeType: 'index',
                                                  productID: snapshot.data.data.catalogue.id,
                                                  itemName: snapshot.data.data.catalogue.title,
                                                  objectName: RateObjectName.catalouge,
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
                                    ListView.separated(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(snapshot.data.data
                                                  .rates[index].user.username),
                                              RatingBar.builder(
                                                initialRating: snapshot
                                                    .data.data.rates[index].rate
                                                    .toDouble(),
                                                minRating: 1,
                                                itemSize: 14,
                                                ignoreGestures: true,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 0.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
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
                                            snapshot
                                                .data.data.rates[index].comment,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          leading: CircleAvatar(
                                            radius: 25,
                                            backgroundImage: snapshot
                                                            .data
                                                            .data
                                                            .rates[index]
                                                            .user
                                                            .imageUrl ==
                                                        null ||
                                                    snapshot
                                                            .data
                                                            .data
                                                            .rates[index]
                                                            .user
                                                            .imageUrl ==
                                                        ''
                                                ? AssetImage(
                                                    'assets/images/avatar.png',
                                                  )
                                                : CachedNetworkImageProvider(
                                                    snapshot
                                                        .data
                                                        .data
                                                        .rates[index]
                                                        .user
                                                        .imageUrl,
                                                  ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          snapshot.data.data.rates.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          height: ScreenUtil().setHeight(6),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(14),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: getMoreReviews
                                          ? Loader(
                                        size: 30,
                                      )
                                          : GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            getMoreReviews = true;
                                          });

                                          await seeMoreBloc.getMoreReviews(
                                            RateObjectName.catalouge,
                                            snapshot.data.data.catalogue.id.toString(),
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
                                          translate(context, 'see_more'),
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
                    ],
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('error'),
              );
            }
            return Loader();
          }),
    );
  }
}
