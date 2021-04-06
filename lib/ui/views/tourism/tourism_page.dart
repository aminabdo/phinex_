
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/jobs/JobsByCatResponse.dart';
import 'package:phinex/Bles/bloc/jobs/JobBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/views/home/services_page.dart';
import 'package:phinex/ui/views/tourism/add_tourism_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_rating_bar.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'tourism_details_page.dart';

class TourismPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _TourismPageState createState() => _TourismPageState();
}

class _TourismPageState extends State<TourismPage> {

  @override
  void initState() {
    super.initState();

    jobBloc.getLanding(50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: myAppBar(
        AppLocalization.of(context).translate('tourism'),
        context,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddTourismPage(),
                ),
              );
            },
            color: Colors.black,
          ),
        ],
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, ServicesPage());
        },
      ),
      body: WillPopScope(
        child: StreamBuilder<JobsByCatResponse>(
          stream: jobBloc.landing.stream,
          builder: (context, snapshot) {
            if (jobBloc.loading.value) {
              return Loader();
            } else {
              return SingleChildScrollView(
                physics: bouncingScrollPhysics,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          childAspectRatio: 1 / 1.1,
                          crossAxisCount: 2,
                        ),
                        itemCount: snapshot.data.data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var currentItem = snapshot.data.data[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                TourismDetailsPage(
                                              name: currentItem.title,
                                              id: currentItem.id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          currentItem.title ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        MyRatingBar(rate: 3),
                                      ],
                                    ),
                                  ),
                                  myButton(
                                    AppUtils.translate(context, 'see_details'),
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => TourismDetailsPage(
                                            name: currentItem.title,
                                            id: currentItem.id,
                                          ),
                                        ),
                                      );
                                    },
                                    decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, ServicesPage());
          return false;
        },
      ),
    );
  }
}
