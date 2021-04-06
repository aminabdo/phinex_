import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/store/store_responses/ProductsBean.dart';
import 'package:phinex/Bles/Model/responses/vendor/vendor_products/VendorProductsResponse.dart';
import 'package:phinex/Bles/bloc/store/VendorBloc.dart';
import 'package:phinex/ui/views/store/store_card_item.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_localization.dart';

class VendorMoreProductsPage extends StatefulWidget {
  final int vendorId;
  final String vendorName;

  const VendorMoreProductsPage({
    Key key,
    this.vendorId,
    this.vendorName,
  }) : super(key: key);

  @override
  _VendorMoreProductsPageState createState() => _VendorMoreProductsPageState();
}

class _VendorMoreProductsPageState extends State<VendorMoreProductsPage> {
  ScrollController _scrollController = new ScrollController();
  int skip = 0;
  int take = 10;

  @override
  void initState() {
    super.initState();

    vendorBloc.clear();
    vendorBloc.getVendorProducts(
      BaseRequestSkipTake(id: widget.vendorId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          '${widget.vendorName}’s ${AppLocalization.of(context).translate('products')}',
          context),
      body: StreamBuilder<VendorProductsResponse>(
        stream: vendorBloc.VendorProducts.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            _scrollController
              ..addListener(
                () {
                  if (_scrollController.position.pixels ==
                      _scrollController.position.maxScrollExtent) {
                    skip += 10;
                    take += 10;
                    vendorBloc.getVendorProducts(
                      BaseRequestSkipTake(
                        id: widget.vendorId,
                        skip: skip,
                        take: take,
                      ),
                    );
                  }
                },
              );
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate:
                  MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                height: ScreenUtil().setHeight(370),
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 5,
              ),
              itemCount: snapshot.data.data.length,
              itemBuilder: (context, index) {
                return StoreCartItem(
                  productsBean: ProductsBean(
                    id: snapshot.data.data[index].vendorId,
                    imageUrl: snapshot.data.data[index].imageUrl,
                    name: snapshot.data.data[index].name,
                    regularPrice: snapshot.data.data[index].regularPrice,
                    totalRates: snapshot.data.data[index].totalRates,
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('error'),
            );
          } else {
            return Loader();
          }
        },
      ),
    );
  }
}
