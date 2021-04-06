
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/jobs/JobSingleResponse.dart';
import 'package:phinex/Bles/bloc/jobs/JobBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_contacts_info.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_rating_bar.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class TourismDetailsPage extends StatefulWidget {
  final int id;
  final String name;

  const TourismDetailsPage(
      {Key key, @required this.id, @required this.name})
      : super(key: key);

  @override
  _TourismDetailsPageState createState() => _TourismDetailsPageState();
}

class _TourismDetailsPageState extends State<TourismDetailsPage> {
  bool readMore = false;
  int skip = 0;
  int take = 10;

  int currentItem = 0;

  @override
  void initState() {
    super.initState();

    jobBloc.getsingle(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.name ?? '', context),
      backgroundColor: scaffoldBackgroundColor,
      body: StreamBuilder<JobSingleResponse>(
        stream: jobBloc.single.stream,
        builder: (context, snapshot) {
          if (jobBloc.loading.value) {
            return Loader();
          } else {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CarouselSlider(
                          items: []
                              .map(
                                (imageUrl) => Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Container(
                                child: imageUrl == null ||
                                    imageUrl.isEmpty
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
                                        size: 30,
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
                            Duration(milliseconds: 800),
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
                                [].length,
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
                            snapshot.data.data.title ?? '',
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
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppUtils.translate(context, 'description'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(8),
                                  ),
                                  Text(
                                    snapshot.data.data.description ?? '',
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
                        MyContactsInfoContainer(
                          snapshot.data.data.recruiter.addressLatitude.toString(),
                          snapshot.data.data.recruiter.addressLongitude.toString(),
                          phone: snapshot.data.data.mobile,
                          address: snapshot.data.data.recruiter.address,
                          email: snapshot.data.data.email,
                          website: null,
                        ),
                        Container(
                          width: double.infinity,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('user.username'),
                                    MyRatingBar(
                                        rate: 3),
                                  ],
                                ),
                                subtitle: Text(
                                 ' theVendor.rating[index].comment',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: CircleAvatar(
                                  backgroundImage:
                                  // [].imageUrl ==
                                  //     null ||
                                  //     theVendor.rating[index].user.imageUrl
                                  //         .isEmpty
                                  //     ?
                                  Image.asset(
                                    'assets/images/avatar.png',
                                  ).image
                                  //     : CachedNetworkImageProvider(
                                  //   theVendor.rating[index].user.imageUrl,
                                  // ),
                                ),
                              );
                            },
                            itemCount: 4, // theVendor.rating.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                height: ScreenUtil().setHeight(6),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
