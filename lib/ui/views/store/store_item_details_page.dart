import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/cart/AddToCartRequest.dart';
import 'package:phinex/Bles/Model/requests/store/RateByProductRequest.dart';
import 'package:phinex/Bles/Model/requests/wish_list/AddToWishListRequest.dart';
import 'package:phinex/Bles/Model/responses/store/single_product/SingleProductResponse.dart';
import 'package:phinex/Bles/Model/responses/store/store_responses/ProductsBean.dart';
import 'package:phinex/Bles/bloc/store/CartBloc.dart';
import 'package:phinex/Bles/bloc/store/StoreBloc.dart';
import 'package:phinex/Bles/bloc/store/WishListBloc.dart';
import 'package:phinex/ui/views/photo_view/photo_view_page.dart';
import 'package:phinex/ui/views/rate_item/rate_item_page.dart';
import 'package:phinex/ui/views/vendor/vendor_profile_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_rating_bar.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'store_card_item.dart';

class StoreCartItemDetailsPage extends StatefulWidget {
  final int productId;
  final String productName;
  final int quantity;
  final bool isFavourite;
  final double price;

  const StoreCartItemDetailsPage({
    Key key,
    @required this.productId,
    @required this.productName,
    @required this.quantity,
    @required this.isFavourite,
    this.price,
  }) : super(key: key);

  @override
  _StoreCartItemDetailsPageState createState() => _StoreCartItemDetailsPageState();
}

class _StoreCartItemDetailsPageState extends State<StoreCartItemDetailsPage> {
  int currentItem = 0;
  int counter = 0;

  bool favourite = false;
  bool readMore = false;
  bool isLoading = false;
  bool addToCart = false;

  int skip = 0;
  int take = 10;

  @override
  void initState() {
    super.initState();

    storeBloc.clear();
    storeBloc.getSingleProduct(widget.productId);
    this.counter = widget.quantity ?? 0;
    favourite = widget.isFavourite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.productName, context),
      body: StreamBuilder<SingleProductResponse>(
        stream: storeBloc.singleProductSubject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            SingleProductResponse productDetails = snapshot.data;
            return Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CarouselSlider(
                            items: productDetails.data.product.gallery.map(
                                  (imageUrl) => Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Container(
                                      child: imageUrl == null || imageUrl.isEmpty
                                          ? Image.asset(
                                              'assets/images/no-product-image.png',
                                              // fit: BoxFit.fill,
                                            )
                                          : Padding(
                                              padding: EdgeInsets.all(12.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (_) => PhotoViewPage(imageUrl: imageUrl,),),);
                                                },
                                                child: Hero(
                                                  tag: imageUrl,
                                                  child: CachedNetworkImage(
                                                    imageUrl: imageUrl,
                                                    placeholder: (context, url) {
                                                      return Loader(
                                                        size: 30,
                                                      );
                                                    },
                                                    // fit: BoxFit.fill,
                                                    errorWidget: (_, __, ___) {
                                                      return Icon(Icons.error);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                      width: double.infinity,
                                      height: ScreenUtil().setHeight(320),
                                    ),
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                              height: ScreenUtil().setHeight(320),
                              aspectRatio: 16 / 9,
                              viewportFraction: 1,
                              onPageChanged: (int index, _) {
                                currentItem = index;
                                setState(() {});
                              },
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: GestureDetector(
                              onTap: () {
                                if (AppUtils.userData == null) {
                                  AppUtils.showNeedToRegisterDialog(context);
                                  return;
                                }

                                favourite = !favourite;
                                if (favourite) {
                                  wishlistBloc.addToWishList(
                                    WishListRequest(
                                      user_id: AppUtils.userData.id,
                                      product_id: snapshot.data.data.product.id,
                                    ),
                                  );
                                } else {
                                  wishlistBloc.deleteFromWishList(
                                    WishListRequest(
                                      user_id: AppUtils.userData.id,
                                      product_id: snapshot.data.data.product.id,
                                    ),
                                  );
                                }
                                setState(() {});
                              },
                              child: Container(
                                width: ScreenUtil().setWidth(40),
                                padding: EdgeInsets.all(3),
                                height: ScreenUtil().setHeight(60),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Icon(
                                    favourite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 20,
                                    color: favourite ? mainColor : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 10,
                            left: 10,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  productDetails.data.product.gallery.length,
                                  (index) => AnimatedContainer(
                                    margin: EdgeInsets.only(right: 5),
                                    duration: Duration(milliseconds: 600),
                                    width: ScreenUtil().setWidth(10),
                                    height: ScreenUtil().setHeight(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentItem == index
                                          ? mainColor
                                          : mainColor.withOpacity(.3),
                                    ),
                                  ),
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: ScreenUtil().setHeight(8),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(11),
                            ),
                            child: Text(
                              productDetails.data.product.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(8),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(11),
                            ),
                            child: Row(
                              children: [
                                MyRatingBar(rate: double.parse(productDetails.data.product.totalRates.toString())) ?? 0.toDouble(),
                                SizedBox(
                                  width: ScreenUtil().setWidth(12),
                                ),
                                Text(
                                  '( ${productDetails.data.product.totalRates} )',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(12),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => VendorProfilePage(
                                          vendorId: productDetails.data.product.vendorId,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    AppLocalization.of(context).translate('view_vendor_profile'),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(8),
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
                                          .translate('description'),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      productDetails.data.product.description,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: readMore ? 100 : 1,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(14),
                                    ),
                                    productDetails.data.product.description
                                                .length >
                                            100
                                        ? GestureDetector(
                                            child: Text(
                                              readMore
                                                  ? AppLocalization.of(context)
                                                      .translate('read_less')
                                                  : AppLocalization.of(context)
                                                      .translate('read_more'),
                                            ),
                                            onTap: () {
                                              readMore = !readMore;
                                              setState(() {});
                                            },
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          relatedProductsContainer(productDetails),
                          SizedBox(
                            height: ScreenUtil().setHeight(12),
                          ),
                          reviewContainer(productDetails),
                          SizedBox(
                            height: ScreenUtil().setHeight(120),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(140),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalization.of(context).translate('price'),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Flexible(
                                    child: Text(
                                      '${counter > 0 ? (snapshot.data.data.product.regularPrice * counter) : snapshot.data.data.product.regularPrice} ${AppUtils.currency}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(12),
                            ),
                            Expanded(
                              child: counter > 0 ? counterWidget(snapshot) : addToCart
                                      ? counterWidget(snapshot)
                                      : Container(
                                          height: ScreenUtil().setHeight(55),
                                          decoration: BoxDecoration(
                                            color: mainColor,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(6),
                                            child: FlatButton(
                                              onPressed: () {
                                                if (AppUtils.userData == null) {
                                                  AppUtils.showNeedToRegisterDialog(context);
                                                  return;
                                                }

                                                addCart(snapshot);
                                                addToCart = true;
                                                setState(() {});
                                              },
                                              padding: EdgeInsets.all(0),
                                              child: Center(
                                                child: Text(AppLocalization.of(context).translate('add_to_cart'),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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

  Widget relatedProductsContainer(SingleProductResponse productDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        productDetails.data.relatedByCategory.length == 0
            ? SizedBox.shrink()
            : SizedBox(
                height: ScreenUtil().setHeight(12),
              ),
        productDetails.data.relatedByCategory.length == 0
            ? SizedBox.shrink()
            : Container(
                height: ScreenUtil().setHeight(480),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(
                    ScreenUtil().setHeight(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalization.of(context)
                            .translate('related_products'),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(8),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: bouncingScrollPhysics,
                          itemBuilder: (context, index) {
                            return Container(
                              width: ScreenUtil().setWidth(260),
                              child: StoreCartItem(
                                productsBean: ProductsBean(
                                  regularPrice: productDetails.data.relatedByCategory[index].regularPrice,
                                  id: productDetails.data.relatedByCategory[index].id,
                                  imageUrl: productDetails.data.relatedByCategory[index].imageUrl,
                                  name: productDetails.data.relatedByCategory[index].name,
                                  totalRates: productDetails.data.relatedByCategory[index].totalRates,
                                ),
                              ),
                              height: ScreenUtil().setHeight(280),
                            );
                          },
                          itemCount: productDetails.data.relatedByCategory.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                ),
              )
      ],
    );
  }

  Widget reviewContainer(SingleProductResponse productDetails) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalization.of(context).translate('reviews'),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (AppUtils.userData == null) {
                      AppUtils.showNeedToRegisterDialog(context);
                      return;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RateItemPage(
                          objectName: RateObjectName.product,
                          productID: productDetails.data.product.id,
                          itemName: productDetails.data.product.name,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalization.of(context).translate('write_your_review'),
                    style: TextStyle(
                      fontSize: 16,
                      color: mainColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(8),
            ),
            productDetails.data.rates.isEmpty
                ? Text(
                    AppLocalization.of(context).translate('no_reviews_yet'),
                  )
                : Container(
                    width: double.infinity,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                productDetails.data.rates[index].user.username,
                              ),
                              MyRatingBar(
                                  rate: productDetails.data.rates[index].rate
                                      .toDouble()),
                            ],
                          ),
                          subtitle: Text(
                            productDetails.data.rates[index].comment,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: Container(
                            width: 70,
                            height: 90,
                            child: CachedNetworkImage(
                              imageUrl: productDetails
                                      .data.rates[index].user.imageUrl ??
                                  '',
                              errorWidget: (_, __, ___) {
                                return Image.asset(
                                  'assets/images/avatar.png',
                                );
                              },
                            ),
                          ),
                        );
                      },
                      itemCount: productDetails.data.rates.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: ScreenUtil().setHeight(6),
                        );
                      },
                    ),
                  ),
            SizedBox(
              height: ScreenUtil().setHeight(14),
            ),
            productDetails.data.rates == null ||
                    productDetails.data.rates.length == 0
                ? SizedBox.shrink()
                : Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        skip += 10;
                        take += 10;
                        storeBloc.getRatesByProductID(
                          RateByProductRequest(
                            productID: productDetails.data.product.id,
                            skip: skip,
                            take: take,
                          ),
                        );
                      },
                      child: Text(
                        AppLocalization.of(context).translate('see_all'),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget counterWidget(AsyncSnapshot<SingleProductResponse> snapshot) {
    return Container(
      height: ScreenUtil().setHeight(45),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: mainColor, width: .5),
      ),
      child: isLoading
          ? Loader(
              size: 20,
            )
          : Row(
              children: [
                GestureDetector(
                  onTap: () {
                    counter--;
                    if (counter <= 1) {
                      counter = 0;
                      addToCart = true;
                      setState(() {});
                      removeItemFromCart(AppUtils.userData.id, snapshot.data.data.product.id);
                    } else {
                      snapshot.data.data.product.regularPrice -= (widget.price).toInt();
                      isLoading = true;
                      setState(() {});
                      updateItemQuantity(snapshot);
                    }
                  },
                  child: Container(
                    width: ScreenUtil().setWidth(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: mainColor,
                    ),
                    height: ScreenUtil().setHeight(45),
                    child: Icon(
                      Icons.remove,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '$counter',
                      style: TextStyle(
                        color: mainColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    counter++;
                    isLoading = true;
                    snapshot.data.data.product.regularPrice += (widget.price).toInt();

                    setState(() {});
                    updateItemQuantity(snapshot);
                  },
                  child: Container(
                    width: ScreenUtil().setWidth(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: mainColor,
                    ),
                    height: ScreenUtil().setHeight(45),
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void updateItemQuantity(AsyncSnapshot<SingleProductResponse> snapshot) async {
    var currentProduct = snapshot.data.data.product;
    currentProduct.cartQty = counter;

    await cartBloc.updateCartItem(AppUtils.userData.id, currentProduct.id, counter);

    isLoading = false;
    setState(() {});
  }

  void addCart(AsyncSnapshot<SingleProductResponse> snapshot) async {
    counter++;
    setState(() {});
    AddToCartRequest requestObject = AddToCartRequest();
    requestObject.cartProducts.add(
      CartProductsBean(
        userId: AppUtils.userData.id,
        vendorId: snapshot.data.data.product.vendorId,
        quantity: counter,
        productId: snapshot.data.data.product.id,
      ),
    );
    await cartBloc.addToMyCart(requestObject);
    isLoading = false;
    setState(() {});
  }

  void removeItemFromCart(userId, productId) async {
    isLoading = true;
    addToCart = false;
    setState(() {});
    await cartBloc.deleteCartItem(null, userId: userId, productId: productId);
    isLoading = false;
    setState(() {});
  }
}
