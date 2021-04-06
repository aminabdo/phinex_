import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/index/indexByCatResponse.dart';
import 'package:phinex/Bles/bloc/index/IndexBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'comapines_details_page.dart';
import 'companie_index_page.dart';

class CompaniesCategoriesPage extends StatefulWidget {
  static final int pageIndex = 0;
  final int categoryId;
  final String categoryName;

  const CompaniesCategoriesPage(
      {Key key, @required this.categoryId, @required this.categoryName})
      : super(key: key);

  @override
  _CompaniesCategoriesPageState createState() =>
      _CompaniesCategoriesPageState();
}

class _CompaniesCategoriesPageState extends State<CompaniesCategoriesPage> {
  ScrollController _scrollController = ScrollController();
  int skip = 0;
  int take = 10;

  @override
  void initState() {
    super.initState();

    print(widget.categoryId);

    indexBloc.clear();
    indexBloc.getByCatID(
      BaseRequestSkipTake(
        skip: skip,
        take: take,
        id: widget.categoryId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: myAppBar(
        widget.categoryName,
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(CompaniesIndexPage.pageIndex, CompaniesIndexPage());
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(CompaniesIndexPage.pageIndex, CompaniesIndexPage());
          return false;
        },
        child: StreamBuilder<IndexByCatResponse>(
          stream: indexBloc.getByCat.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              print(snapshot.data.data);
              _scrollController
                ..addListener(
                  () {
                    if (_scrollController.position.pixels ==
                        _scrollController.position.maxScrollExtent) {
                      skip += 10;
                      take = 10;
                      indexBloc.getByCatID(
                        BaseRequestSkipTake(
                          skip: skip,
                          take: take,
                          id: widget.categoryId,
                        ),
                      );
                    }
                  },
                );
              return ListView.builder(
                controller: _scrollController,
                physics: bouncingScrollPhysics,
                itemCount: snapshot.data.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: ScreenUtil().setHeight(360),
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(4),
                      vertical: ScreenUtil().setHeight(4),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            snapshot.data.data[index].imageUrl == null ||
                                    snapshot.data.data[index].imageUrl == ''
                                ? Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                CompaniesDetailsPage(
                                              id: snapshot
                                                  .data.data[index].id,
                                              name: snapshot
                                                  .data.data[index].title,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        child: Image.asset(
                                          'assets/images/no-product-image.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                CompaniesDetailsPage(
                                              id: snapshot
                                                  .data.data[index].id,
                                              name: snapshot
                                                  .data.data[index].title,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data.data[index].imageUrl,
                                          fit: BoxFit.contain,
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
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                            ),
                            Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data.data[index].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: deepBlueColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(8),
                                    ),
                                    Flexible(
                                      child: Text(
                                        snapshot.data.data[index].phone ?? 'No Mobile Number',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: deepBlueColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(8),
                                    ),
                                    snapshot.data.data[index].website == null ? SizedBox.shrink() : Flexible(
                                      child: Text(
                                        snapshot.data.data[index].website,
                                        style: TextStyle(
                                          color: snapshot.data.data[index].website == null ? null : Colors.blue,
                                          decoration: snapshot.data.data[index].website == null ? null : TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: deepBlueColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(8),
                                    ),
                                    Flexible(
                                      child: Text(
                                        snapshot.data.data[index].address ?? AppLocalization.of(context).translate('no_address'),
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
                  );
                },
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
      ),
    );
  }
}
