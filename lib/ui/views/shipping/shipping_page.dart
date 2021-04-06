import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/catalogue/CatalogueLandingResponse.dart';
import 'package:phinex/Bles/bloc/catalogue/CatalogueBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/services_page.dart';
import 'package:phinex/ui/views/shipping/add_shipping_company_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'shipping_categories_page.dart';

class ShippingPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _ShippingPageState createState() =>
      _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  @override
  void initState() {
    super.initState();

    catalogueBloc.getLanding(AppUtils.catalogueParent['shipping']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        AppLocalization.of(context).translate('shipping'),
        context,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddShippingCompanyPage(),),);
            },
          ),
        ],
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(ServicesPage.pageIndex, ServicesPage());
        },
      ),
      backgroundColor: scaffoldBackgroundColor,
      body: WillPopScope(
        child: StreamBuilder<CatalogueLandingResponse>(
          stream: catalogueBloc.landing.stream,
          builder: (context, snapshot) {
            if (!catalogueBloc.loading.value) {
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
                                    snapshot.data.data[index].imageUrl == null || snapshot.data.data[index].imageUrl == ''
                                        ? Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Provider.of<PageProvider>(context,
                                              listen: false)
                                              .setPage(
                                            ShippingCategoriesPage.pageIndex,
                                            ShippingCategoriesPage(
                                              categoryId: snapshot.data.data[index].id,
                                              categoryName: snapshot.data.data[index].name,
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
                                          Provider.of<PageProvider>(context, listen: false).setPage(
                                            ShippingCategoriesPage.pageIndex,
                                            ShippingCategoriesPage(
                                              categoryId: snapshot.data.data[index].id,
                                              categoryName: snapshot.data.data[index].name,
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
                                        fontWeight: FontWeight.bold,
                                      ),
                                      onTap: () {
                                        print(snapshot.data.data[index].id);
                                        Provider.of<PageProvider>(context, listen: false).setPage(
                                          ShippingCategoriesPage.pageIndex,
                                          ShippingCategoriesPage(
                                            categoryId: snapshot.data.data[index].id,
                                            categoryName: snapshot.data.data[index].name,
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
                  )
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
              .setPage(ServicesPage.pageIndex, ServicesPage());
          return false;
        },
      ),
    );
  }
}
