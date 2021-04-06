import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/auctions/SubmitDealReplyRequest.dart';
import 'package:phinex/Bles/Model/responses/auctions/AuctionLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/auctions/AuctionSingleResponse.dart';
import 'package:phinex/Bles/bloc/auction/HighestPriceBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';


class DayCircle extends StatefulWidget {
  final String text;

  const DayCircle({Key key, this.text}) : super(key: key);

  @override
  _DayCircleState createState() => _DayCircleState();
}

class _DayCircleState extends State<DayCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      height: ScreenUtil().setHeight(50),
      decoration: BoxDecoration(
        color: mainColor,
        border: Border.all(color: deepBlueColor, width: 1),
      ),
      child: Center(
        child: Text(
          widget.text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class LotOwnerViewPage extends StatefulWidget {
  final int id;
  final String name;

  const LotOwnerViewPage({Key key, @required this.id, @required this.name})
      : super(key: key);

  @override
  _LotOwnerViewPageState createState() => _LotOwnerViewPageState();
}

class _LotOwnerViewPageState extends State<LotOwnerViewPage> {
  bool readMore = false;
  bool auctionIsNotStarted = false;

  int currentItem = 0;

  String day = '';
  String hour = '';
  String min = '';
  String sec = '';

  ScrollController _scrollController = ScrollController();
  ScrollController _dealsScrollController = ScrollController();

  int skip = 0;
  int take = 10;

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  @override
  void initState() {
    super.initState();

    highestPriceBloc.getAuctionSingle(BaseRequestSkipTake(
      id: widget.id,
      skip: skip,
      take: take,
    ));
    pusher();
  }

  pusher()async{
    await highestPriceBloc.initPusher();
    await highestPriceBloc.connect();
    await highestPriceBloc.subscribeSingle(widget.id);
    await highestPriceBloc.bindSingle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        widget.name,
        context,
      ),
      backgroundColor: scaffoldBackgroundColor,
      body: StreamBuilder<AuctionSingleResponse>(
        stream: highestPriceBloc.auctionSingle.stream,
        builder: (context, snapshot) {
          if (highestPriceBloc.loading.value) {
            return Loader();
          } else {
              calcDate(snapshot.data.data.endsAt, snapshot.data.data.opensFrom);
              _scrollController
                ..addListener(
                  () {
                    if (_scrollController.position.pixels ==
                        _scrollController.position.maxScrollExtent) {
                      skip += 10;
                      take = 10;
                      highestPriceBloc.getAuctionBids(
                        BaseRequestSkipTake(
                          take: take,
                          skip: skip,
                          id: widget.id,
                        ),
                      );
                    }
                  },
                );

              _dealsScrollController
                ..addListener(
                  () {
                    if (_dealsScrollController.position.pixels ==
                        _dealsScrollController.position.maxScrollExtent) {
                      skip += 10;
                      take = 10;
                      highestPriceBloc.getAuctionDeals(
                        BaseRequestSkipTake(
                          take: take,
                          skip: skip,
                          id: widget.id,
                        ),
                      );
                    }
                  },
                );

              return SingleChildScrollView(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CarouselSlider(
                          items: snapshot.data.data.gallary
                              .map(
                                (imageUrl) => Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Container(
                                    child: imageUrl == null || imageUrl.isEmpty
                                        ? Image.asset(
                                            'assets/images/no-product-image.png',
                                            // fit: BoxFit.fill,
                                          )
                                        : Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: CachedNetworkImage(
                                              imageUrl: imageUrl,
                                              placeholder: (context, url) {
                                                return Loader(
                                                  size: 60,
                                                );
                                              },
                                              // fit: BoxFit.fill,
                                              errorWidget: (_, __, ___) {
                                                return Icon(Icons.error);
                                              },
                                            ),
                                          ),
                                    width: double.infinity,
                                    height: ScreenUtil().setHeight(250),
                                  ),
                                ),
                              )
                              .toList(),
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
                                Duration(milliseconds: 1000),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 10,
                          left: 10,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                snapshot.data.data.gallary.length,
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
                                        .translate('about_auction'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(8),
                                  ),
                                  Text(
                                    snapshot.data.data.description,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: readMore ? 30 : 1,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(14),
                                  ),
                                  snapshot.data.data.description.length > 70
                                      ? GestureDetector(
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
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(8),
                        ),
                      snapshot.data.data.status =='close' ? Container(
                        width: double.infinity,
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalization.of(context)
                                      .translate('auction_has_been_ended'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(10),
                                ),
                                Text(
                                  AppLocalization.of(context)
                                      .translate('owned_by') + ' ' + snapshot.data.data.winedUser.user.firstName + ' ' + snapshot.data.data.winedUser.user.lastName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ) :  Container(
                          width: double.infinity,
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalization.of(context)
                                        .translate('auction_details'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(10),
                                  ),
                                  Card(
                                    color: deepBlueColor,
                                    elevation: 5,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: ScreenUtil().setHeight(12),
                                          ),
                                          auctionIsNotStarted
                                              ? Text(
                                                  'Time remaining to start auction',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                )
                                              : SizedBox.shrink(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              DayCircle(text: day),
                                              DayCircle(text: hour),
                                              DayCircle(text: min),
                                              DayCircle(text: sec),
                                            ],
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(8),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                AppLocalization.of(context)
                                                    .translate('day'),
                                                style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Text(
                                                AppLocalization.of(context)
                                                    .translate('hr'),
                                                style: TextStyle(
                                                    color: Colors.yellow,
                                                    fontSize: 13),
                                              ),
                                              Text(
                                                AppLocalization.of(context)
                                                    .translate('min'),
                                                style: TextStyle(
                                                    color: Colors.yellow,
                                                    fontSize: 13),
                                              ),
                                              Text(
                                                AppLocalization.of(context)
                                                    .translate('sec'),
                                                style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  '${AppLocalization.of(context).translate('current_bid')}:   ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              Text(
                                                snapshot.data.data.openPrice
                                                        .toString() +
                                                    ' ${AppUtils.currency}',
                                                style: TextStyle(
                                                  color: Colors.white60,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
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
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(8),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(240),
                          width: double.infinity,
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            AppLocalization.of(context)
                                                .translate('deals'),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(8),
                                          ),
                                          Text(
                                            '${AppLocalization.of(context).translate('you_have')} ${snapshot.data.data.makeDeal.length} ${AppLocalization.of(context).translate('deals')}',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(18),
                                      ),
                                      snapshot.data.data.makeDeal.length == 0
                                          ? Text(
                                              translate(
                                                  context, 'no_deals_yet'),
                                              style: TextStyle(fontSize: 15),
                                            )
                                          : Expanded(
                                              child: ListView.builder(
                                                controller:
                                                    _dealsScrollController,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: snapshot
                                                    .data.data.makeDeal.length,
                                                physics: bouncingScrollPhysics,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return DealItem(
                                                    item: snapshot.data.data
                                                        .makeDeal[index],
                                                  );
                                                },
                                              ),
                                            )
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
                                    children: [
                                      Expanded(
                                          child: myButton(
                                        AppLocalization.of(context)
                                            .translate('auction'),
                                      )),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(8),
                                      ),
                                      Expanded(
                                        child: myButton(
                                          AppLocalization.of(context)
                                              .translate('auction_log'),
                                          btnColor: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(18),
                                  ),
                                  ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data.data.auctionee[index]
                                                .user.username,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${snapshot.data.data.auctionee[index].paidPrice} ${AppUtils.currency}',
                                            style: TextStyle(
                                              color: mainColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount:
                                        snapshot.data.data.auctionee.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Divider(
                                        thickness: .4,
                                        color: Colors.grey,
                                        height: ScreenUtil().setHeight(25),
                                      );
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
                      ],
                    ),
                  ],
                ),
              );
            }
          }
      ),
    );
  }

  void calcDate(String endAt, String startTime) {
    // check if the start time is not began yet
    // calculate how much to start
    DateTime dateStart = DateTime.parse(startTime);
    DateTime dateEnd = DateTime.parse(endAt);
    DateTime timeNow = DateTime.now();
    if (dateStart.isAfter(timeNow)) {
      auctionIsNotStarted = true;
      final difference = timeNow.difference(dateStart);
      day = difference.inDays.abs().toStringAsFixed(0);
      hour = difference.inHours.abs().toStringAsFixed(0);
      min = difference.inMinutes.abs().toStringAsFixed(0);
      sec = difference.inSeconds.abs().toStringAsFixed(0);
    } else {
      auctionIsNotStarted = false;
      final difference = dateEnd.difference(timeNow);
      day = difference.inDays.abs().toStringAsFixed(0);
      hour = difference.inHours.abs().toStringAsFixed(0);
      min = difference.inMinutes.abs().toStringAsFixed(0);
      sec = difference.inSeconds.abs().toStringAsFixed(0);
    }
  }
}

class DealItem extends StatefulWidget {
  final MakeDealBean item;

  const DealItem({Key key, this.item}) : super(key: key);

  @override
  _DealItemState createState() => _DealItemState();
}

class _DealItemState extends State<DealItem> {
  MakeDealBean item;
  bool makeAction = false;

  @override
  void initState() {
    super.initState();

    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setSate) => Container(
        width: MediaQuery.of(context).size.width * .95,
        child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
          ),
          color: mainColor,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${item.user.firstName} ${item.user.lastName} ${AppLocalization.of(context).translate('wanna_make_a_deal')} ${item.price} ${AppUtils.currency}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                makeAction
                    ? Loader(
                        size: 30,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          myButton(
                            AppLocalization.of(context).translate('no'),
                            width: ScreenUtil().setWidth(90),
                            onTap: () async {
                              makeAction = true;
                              setState(() {});
                              await highestPriceBloc
                                  .submitDealReply(SubmitDealReplyRequest(
                                auctionId: item.id,
                                status: 'rejected',
                              ));
                              makeAction = false;
                              setState(() {});
                            },
                          ),
                          myButton(
                            AppLocalization.of(context).translate('yes'),
                            width: ScreenUtil().setWidth(90),
                            onTap: () {
                              makeAction = true;
                              setState(() {});
                              highestPriceBloc
                                  .submitDealReply(SubmitDealReplyRequest(
                                auctionId: item.id,
                                status: 'accepted',
                              ));
                              makeAction = false;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
