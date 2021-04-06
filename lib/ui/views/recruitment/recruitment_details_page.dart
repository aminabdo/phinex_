
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/jobs/JobSingleResponse.dart';
import 'package:phinex/Bles/bloc/jobs/JobBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_contacts_info.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class RecruitmentDetailsPage extends StatefulWidget {
  final int id;
  final String name;

  const RecruitmentDetailsPage(
      {Key key, @required this.id, @required this.name})
      : super(key: key);

  @override
  _RecruitmentDetailsPageState createState() => _RecruitmentDetailsPageState();
}

class _RecruitmentDetailsPageState extends State<RecruitmentDetailsPage> {
  bool readMore = false;

  int skip = 0;
  int take = 10;

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
                    snapshot.data.data.image?.imageUrl == null ||
                        snapshot.data.data.image?.imageUrl == ''
                        ? Image.asset(
                            'assets/images/no-product-image.png',
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: ScreenUtil().setHeight(250),
                          )
                        : CachedNetworkImage(
                            imageUrl: snapshot.data.data.image.imageUrl,
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
                                    AppUtils.translate(context, 'address'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(8),
                                  ),
                                  Text(
                                    snapshot.data.data.address ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: readMore ? 30 : 1,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(14),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                    'Employment Type',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(8),
                                  ),
                                  Text(
                                    snapshot.data.data.type ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: readMore ? 30 : 1,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        MyContactsInfoContainer(
                          null,
                          null,
                          phone: snapshot.data.data.mobile,
                          address: snapshot.data.data.address,
                          email: snapshot.data.data.email,
                          website: null,
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
