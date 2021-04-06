
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellSearchResponse.dart';
import 'package:phinex/Bles/bloc/buy_sell/BuySellBloc.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'buy_sell_search_card_item.dart';

class BuySellSearchPage extends StatefulWidget {
  @override
  _BuySellSearchPageState createState() => _BuySellSearchPageState();
}

class _BuySellSearchPageState extends State<BuySellSearchPage> {
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
                          if(input.trim().length < 1) {
                            return;
                          }
                          
                          buySellBloc.getSearch(input);
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
                                    buySellBloc.clear();
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
                          hintText: AppLocalization.of(context)
                              .translate('search'),
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
            SizedBox(height: ScreenUtil().setHeight(10),),
           searchController.text.isEmpty ? SizedBox.shrink() : Expanded(
              child: StreamBuilder<BuySellSearchResponse>(
                stream: buySellBloc.search.stream,
                builder: (context, snapshot) {
                 if(snapshot.hasData && snapshot.data != null) {
                   return  GridView.builder(
                     // shrinkWrap: true,
                     physics: bouncingScrollPhysics,
                     gridDelegate:
                     MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                       height: ScreenUtil().setHeight(400),
                       crossAxisSpacing: 0,
                       mainAxisSpacing: 4,
                       crossAxisCount: 2,
                     ),
                     itemCount: snapshot.data.data.results.length,
                     itemBuilder: (context, index) {
                       return BuySellSearchCartItem(
                         productsBean: snapshot.data.data.results[index],
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
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
