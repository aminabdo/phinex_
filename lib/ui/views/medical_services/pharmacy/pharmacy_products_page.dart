
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacyProductsResponse.dart';
import 'package:phinex/Bles/bloc/medical_service/PharmacyBloc.dart';
import 'package:phinex/ui/views/medical_services/pharmacy/single_product_cart_item.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';

class PharmacyProductsPage extends StatefulWidget {
  final int id;
  final String title;

  const PharmacyProductsPage({Key key, @required this.id, @required this.title})
      : super(key: key);

  @override
  _PharmacyProductsPageState createState() => _PharmacyProductsPageState();
}

class _PharmacyProductsPageState extends State<PharmacyProductsPage> {
  ScrollController _scrollController = ScrollController();
  int skip = 0;
  int take = 10;

  @override
  void initState() {
    super.initState();

    pharmacyBloc.getMoreProducts(
      BaseRequestSkipTake(
        id: widget.id,
        skip: skip,
        take: take,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        widget.title,
        context,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder<PharmacyProductsResponse>(
        stream: pharmacyBloc.products.stream,
        builder: (context, snapshot) {
          if (pharmacyBloc.loading.value) {
            return Loader();
          } else {
            _scrollController
              ..addListener(
                    () {
                  if (_scrollController.position.pixels ==
                      _scrollController.position.maxScrollExtent) {
                    skip += 10;
                    take = 10;
                    pharmacyBloc.getMoreProducts(
                      BaseRequestSkipTake(
                        id: widget.id,
                        skip: skip,
                        take: take,
                      ),
                    );
                  }
                },
              );
            return GridView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              gridDelegate:
                  MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                height: ScreenUtil().setHeight(350),
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemCount: snapshot.data.product.length,
              itemBuilder: (context, index) {
                return SingleMedicineCartItem(
                  product: snapshot.data.product[index],
                );
              },
            );
          }
        },
      ),
    );
  }
}
