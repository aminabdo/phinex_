import 'package:phinex/Bles/Model/requests/store/FilterRequest.dart';
import 'package:phinex/Bles/Model/requests/store/RateByProductRequest.dart';
import 'package:phinex/Bles/Model/responses/store/filter/FilterByProductsResponse.dart';
import 'package:phinex/Bles/Model/responses/store/filter/FilterResponse.dart';
import 'package:phinex/Bles/Model/responses/store/rating_by_product_id/RatingByProductIDResponse.dart';
import 'package:phinex/Bles/Model/responses/store/single_product/SingleProductResponse.dart';
import 'package:phinex/Bles/api_provider/store/StoreApiProvider.dart';
import 'package:phinex/utils/base/BaseRepository.dart';

class StoreRepository extends BaseRepository {
  StoreApiProvider _apiProvider = StoreApiProvider();

  //
  // Future<FilterResponse> getMyProducts(){
  //   return _apiProvider.getMyProducts();
  // }

  Future<FilterByProductsResponse> getProductsByCategory(
      FilterRequest request) {
    print('repository <-> Category id: >>> ${request.categories}');

    return _apiProvider.getProductsByCategory(request);
  }

  Future<FilterResponse> getFiltered(FilterRequest product) {
    return _apiProvider.getFiltered(product);
  }

  Future<SingleProductResponse> getSingleProduct(int productID) {
    return _apiProvider.getSingleProduct(productID);
  }

  Future<RatingByProductIDResponse> getRatingByProductID(
      RateByProductRequest rateByProductRequest) {
    return _apiProvider.getRatingByProductID(rateByProductRequest);
  }
}
