import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantSingleResponse.dart';
import 'package:phinex/Bles/bloc/restaurant/RestaurantBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';

import 'resturant_meals_card_item.dart';

class RestaurantMealsPage extends StatefulWidget {
  final int id;
  final String title;

  const RestaurantMealsPage({Key key, @required this.id, @required this.title})
      : super(key: key);

  @override
  _RestaurantMealsPageState createState() => _RestaurantMealsPageState();
}

class _RestaurantMealsPageState extends State<RestaurantMealsPage> {
  ScrollController _scrollController = ScrollController();
  int skip = 0;
  int take = 10;

  @override
  void initState() {
    super.initState();

    restaurantBloc.clear();
    restaurantBloc.getMeals(
      BaseRequestSkipTake(take: take, skip: skip, id: widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.title, context),
      body: StreamBuilder<RestaurantSingleResponse>(
        stream: restaurantBloc.single.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            _scrollController
              ..addListener(
                () {
                  if (_scrollController.position.pixels ==
                      _scrollController.position.maxScrollExtent) {
                    skip += 10;
                    take = 10;
                    restaurantBloc.getMeals(
                      BaseRequestSkipTake(
                        take: take,
                        skip: skip,
                        id: widget.id,
                      ),
                    );
                  }
                },
              );
            return GridView.builder(
              controller: _scrollController,
              gridDelegate:
                  MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                crossAxisCount: 2,
                height: ScreenUtil().setHeight(320),
              ),
              itemCount: snapshot.data.data.products.length,
              itemBuilder: (context, index) {
                return RestuarntMealsCartItem(
                  currentItem: snapshot.data.data.products[index],
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
    );
  }

}
