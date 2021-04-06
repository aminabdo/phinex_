import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/store/FilterRequest.dart';
import 'package:phinex/Bles/Model/requests/store/RateByProductRequest.dart';
import 'package:phinex/Bles/Model/responses/cart/CartUserResponse.dart';
import 'package:phinex/Bles/Model/responses/store/StoreCreateDetailsResponse.dart';
import 'package:phinex/Bles/Model/responses/store/filter/FilterByProductsResponse.dart';
import 'package:phinex/Bles/Model/responses/store/filter/FilterResponse.dart';
import 'package:phinex/Bles/Model/responses/store/rating_by_product_id/RatingByProductIDResponse.dart';
import 'package:phinex/Bles/Model/responses/store/single_product/SingleProductResponse.dart';
import 'package:phinex/Bles/Model/responses/wish_list/wish_list_by_user/WishListResponse.dart';
import 'package:phinex/Bles/Repository/StoreRepository.dart';
import 'package:phinex/Bles/bloc/store/CartBloc.dart';
import 'package:phinex/Bles/bloc/store/WishListBloc.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/base/BaseBloc.dart';
import 'package:phinex/utils/base/BaseRequest.dart';
import '../../ApiRoutes.dart';

class StoreBloc extends BaseBloc {
  final StoreRepository _repository = StoreRepository();

  BehaviorSubject<FilterResponse> _myProductFilterSubject =
  BehaviorSubject<FilterResponse>();
  BehaviorSubject<FilterByProductsResponse> _myProductResponseSubject =
  BehaviorSubject<FilterByProductsResponse>();
  BehaviorSubject<SingleProductResponse> _singleProductSubject =
  BehaviorSubject<SingleProductResponse>();
  BehaviorSubject<RatingByProductIDResponse> _ratesSubject =
  BehaviorSubject<RatingByProductIDResponse>();
  BehaviorSubject<StoreCreateDetailsResponse> _storeCreateDetails =
  BehaviorSubject<StoreCreateDetailsResponse>();

  filter(FilterRequest request) async {
    print("FilterRequest ---> " + request.toJson().toString());
    FilterResponse response = await _repository.getFiltered(request);
    if (AppUtils.userData == null) {
      _myProductFilterSubject.value = response;
      return;
    }

    response.data.productsCategories = checkCartWisList(response.data.productsCategories, cartBloc.userCart.value.data, wishlistBloc.wishList.value.data);
    _myProductFilterSubject.value = response;

    print("_storeProductsSubject.value --->   " + _myProductFilterSubject.value.code.toString());
    print(response.data.toJson());
    _myProductFilterSubject.value = response;
  }

  getProductsByCat(FilterRequest request) async {
    print('bloc <-> Category id: >>> ${request.categories}');

    FilterByProductsResponse response =
    await _repository.getProductsByCategory(request);

    if (request.skip == 0) {
      _myProductResponseSubject.value = response;
      //print(_myProductResponseSubject.value.data.toString());
    } else {
      _myProductResponseSubject.value.data.products.addAll(response.data.products);
      _myProductResponseSubject.value = _myProductResponseSubject.value;
      print(_myProductResponseSubject.value.data.products.length.toString() + " else");
      print(_myProductResponseSubject.value.data.toString());
    }
  }

  getSingleProduct(int productID) async {
    print("product id --- >> " + productID.toString());
    SingleProductResponse response =
    await _repository.getSingleProduct(productID);

    _singleProductSubject.value = response;
  }

  getRatesByProductID(RateByProductRequest rate) async {
    print(">>>>>>>>>>>>>>>>>>>   " +
        rate.take.toString() +
        '...' +
        rate.skip.toString());

    RatingByProductIDResponse response =
    await _repository.getRatingByProductID(rate);
    if (rate.skip == 0) {
      _ratesSubject.value = response;
    } else {
      _ratesSubject.value.data.addAll(response.data);
      _ratesSubject.value = _ratesSubject.value;
    }

    updateRates(response);

    print("_ratesSubject.value --->   " + _ratesSubject.value.code.toString());
  }

  updateRates(RatingByProductIDResponse response) {
    _singleProductSubject.value.data.rates.addAll(response.data);
    _singleProductSubject.value = _singleProductSubject.value;
  }

  Future<Response> createStore(BaseRequest request) async {
    loading.value = true;
    create.value = await _repository.post(ApiRoutes.storeCreate, request.toJson());
    loading.value = false;
    return create.value;
  }

  getCreateDetails() async {
    loading.value = true;
    get.value = await _repository.get(ApiRoutes.storeCreateDetails);
    _storeCreateDetails.value =
        StoreCreateDetailsResponse.fromMap(get.value.data);
    loading.value = false;
  }

  dispose() {
    super.dispose();
    _myProductResponseSubject.close();
    _storeCreateDetails.close();
    _singleProductSubject.close();
    _ratesSubject.close();
    _myProductFilterSubject.close();
  }

  clear() {
    super.clear();
    _storeCreateDetails = BehaviorSubject<StoreCreateDetailsResponse>();
    _myProductResponseSubject = BehaviorSubject<FilterByProductsResponse>();
    _singleProductSubject = BehaviorSubject<SingleProductResponse>();
    _ratesSubject = BehaviorSubject<RatingByProductIDResponse>();
    _myProductFilterSubject = BehaviorSubject<FilterResponse>();
  }

  BehaviorSubject<FilterByProductsResponse> get ProductsByCatSubject =>
      _myProductResponseSubject;

  BehaviorSubject<SingleProductResponse> get singleProductSubject =>
      _singleProductSubject;

  BehaviorSubject<RatingByProductIDResponse> get ratesOfProduct =>
      _ratesSubject;

  BehaviorSubject<FilterResponse> get myProductFilterSubject =>
      _myProductFilterSubject;

  BehaviorSubject<StoreCreateDetailsResponse> get storeCreateDetails =>
      _storeCreateDetails;

  List<Products_categoriesBean> checkCartWisList(
      List<Products_categoriesBean> productsByCat,
      List<CartUserBean> cartProducts,
      List<WishListBean> wishListProducs) {
    List<Products_categoriesBean> list = List<Products_categoriesBean>();

    productsByCat.forEach((cat) {
      cat.products.forEach((product) {
        print("product id --> " + product.id.toString());
        cartProducts.forEach((element) {
          print("element.id " + element.id.toString());
          if (product.id == element.productId) {
            print("cartProducts.id " + product.id.toString());
            product.cartQty = element.quantity;
            cat.products[cat.products
                .indexWhere((element) => product.id == element.id)] = product;
          }
        });

        wishListProducs.forEach((element) {
          print("element.id " + element.productId.toString());

          if (product.id == element.productId) {
            print("wishListProducs.id " + product.id.toString());

            product.wishlis = true;
            cat.products[cat.products
                .indexWhere((element) => product.id == element.id)] = product;
          }
        });
      });

      list.add(cat);
    });

    list.forEach((element) {
      element.products.forEach((element) {
        print("products id -->  " + element.id.toString());
        print("wish -->  " + element.wishlis.toString());
        print("qty --->  " + element.cartQty.toString());
      });
    });
    return list;
  }
}

// amin
final storeBloc = StoreBloc();
