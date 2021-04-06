import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/index/IndexLandingResponse.dart';
import 'package:phinex/Bles/bloc/index/IndexBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'add_company_page.dart';
import 'comapnies_categories_page.dart';
import 'index_search_page.dart';

class CompaniesIndexPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _CompaniesIndexPageState createState() => _CompaniesIndexPageState();
}

class _CompaniesIndexPageState extends State<CompaniesIndexPage> {
  @override
  void initState() {
    super.initState();

    indexBloc.clear();
    indexBloc.getLanding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: myAppBar(
        AppLocalization.of(context).translate('companies_index'),
        context,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => IndexSearchPage(),
                ),
              );
            },
            color: Colors.black,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddCompanyPage(),
                ),
              );
            },
            color: Colors.black,
          ),
        ],
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, HomeContents());
        },
      ),
      body: WillPopScope(
        child: StreamBuilder<IndexLandingResponse>(
          stream: indexBloc.landing.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return SingleChildScrollView(
                physics: bouncingScrollPhysics,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          translate(context, 'popular_categories'),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GridView.builder(
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
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  snapshot.data.data[index].imageUrl == null ||
                                          snapshot.data.data[index].imageUrl ==
                                              ''
                                      ? Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Provider.of<PageProvider>(context,
                                                      listen: false)
                                                  .setPage(
                                                CompaniesCategoriesPage
                                                    .pageIndex,
                                                CompaniesCategoriesPage(
                                                  categoryId: snapshot
                                                      .data.data[index].id,
                                                  categoryName: snapshot
                                                      .data.data[index].name,
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
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Provider.of<PageProvider>(context,
                                                      listen: false)
                                                  .setPage(
                                                CompaniesCategoriesPage
                                                    .pageIndex,
                                                CompaniesCategoriesPage(
                                                  categoryId: snapshot
                                                      .data.data[index].id,
                                                  categoryName: snapshot
                                                      .data.data[index].name,
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
                                                fit: BoxFit.fill,
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
                                  myButton(
                                    snapshot.data.data[index].name,
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    onTap: () {
                                      Provider.of<PageProvider>(context,
                                              listen: false)
                                          .setPage(
                                        CompaniesCategoriesPage.pageIndex,
                                        CompaniesCategoriesPage(
                                          categoryId:
                                              snapshot.data.data[index].id,
                                          categoryName:
                                              snapshot.data.data[index].name,
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
          },
        ),
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, HomeContents());
          return false;
        },
      ),
    );
  }
}
