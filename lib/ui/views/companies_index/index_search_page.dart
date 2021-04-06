import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phinex/Bles/Model/responses/index/IndexSearchResponse.dart';
import 'package:phinex/Bles/bloc/index/IndexBloc.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'index_comapny_card_item.dart';

class IndexSearchPage extends StatefulWidget {
  @override
  _IndexSearchPageState createState() => _IndexSearchPageState();
}

class _IndexSearchPageState extends State<IndexSearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Material(
              elevation: 8,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(4),
                  vertical: ScreenUtil().setHeight(8),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (String input) {
                          if (input.trim().length < 1) {
                            return;
                          }

                          indexBloc.getSearch(input);
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[300],
                          ),
                          suffixIcon: searchController.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    searchController.clear();
                                    indexBloc.clear();
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.cancel_rounded,
                                    color: deepBlueColor,
                                  ),
                                )
                              : SizedBox.shrink(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(10),
                            vertical: ScreenUtil().setHeight(0),
                          ),
                          hintText:
                              AppLocalization.of(context).translate('search'),
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                              width: .8,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                              width: .8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalization.of(context).translate('cancel'),
                        style: TextStyle(
                          fontSize: 17,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            searchController.text.isEmpty
                ? SizedBox.shrink()
                : Expanded(
                    child: StreamBuilder<IndexSearchResponse>(
                      stream: indexBloc.search.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return ListView.builder(
                            // shrinkWrap: true,
                            physics: bouncingScrollPhysics,
                            itemCount: snapshot.data.data.results.length,
                            itemBuilder: (context, index) {
                              return IndexCompanyCardItem(
                                currentItem: snapshot.data.data.results[index],
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
