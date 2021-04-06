import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/store/FilterRequest.dart';
import 'package:phinex/Bles/Model/requests/store/RateByProductRequest.dart';
import 'package:phinex/Bles/Model/responses/store/filter/FilterByProductsResponse.dart';
import 'package:phinex/Bles/Model/responses/store/filter/FilterResponse.dart';
import 'package:phinex/Bles/Model/responses/store/rating_by_product_id/RatingByProductIDResponse.dart';
import 'package:phinex/Bles/Model/responses/store/single_product/SingleProductResponse.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class StoreApiProvider extends BaseApiProvider {
  Future<FilterResponse> getMyProducts() async {
    try {
      print("response --------...... ---> " +
          ApiRoutesUpdate().getLink(ApiRoutes.my_products));

      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.my_products),
          options: options);

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        FilterResponse myProductsResponse =
            FilterResponse.fromMap(response.data);

        return myProductsResponse;
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);
        FilterResponse myProductsResponse =
            FilterResponse.fromMap(response.data);

        print(myProductsResponse.toString());
        return myProductsResponse;
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<FilterResponse> getFiltered(FilterRequest request) async {
    try {
      print("the request --------...... ---> " +
          ApiRoutesUpdate().getLink(ApiRoutes.filter));
      Response response;
      if (request.categories == null &&
          request.discount == null &&
          request.maxPrice == null &&
          request.minPrice == null &&
          request.order == null &&
          request.rates == null) {
        response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.filter),
          options: options,
        );
      } else {
        response = await dio.post(ApiRoutesUpdate().getLink(ApiRoutes.filter),
            options: options, data: request);
      }

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        return FilterResponse.fromMap(response.data);
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);

        return FilterResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<FilterByProductsResponse> getProductsByCategory(
      FilterRequest request) async {
    print('provider <-> Category id: >>> ${request.categories}');
    formData = new FormData.fromMap({"category_id": request.categories});

    // test
    try {
      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.getProductsByCategory(request)),
          options: options,
          data: formData);

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        FilterByProductsResponse productResponse =
            FilterByProductsResponse.fromMap(response.data);

        return productResponse;
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);
        FilterByProductsResponse productResponse =
            FilterByProductsResponse.fromMap(response.data);

        print(productResponse.toJson().toString());
        return productResponse;
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<SingleProductResponse> getSingleProduct(int productID) async {
    try {
      print("getSingleProduct --> 1");
      print("getSingleProduct --> 1" + ApiRoutes.getSignleProduct(productID));
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.getSignleProduct(productID)),
          options: options);

      print("getSingleProduct --> 2");

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        print("getSingleProduct --> 3");

        SingleProductResponse productResponse =
            SingleProductResponse.fromMap(response.data);

        print("getSingleProduct --> 4");
        print("getSingleProduct --> 4" + productResponse.toJson().toString());

        return productResponse;
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);
        SingleProductResponse productResponse =
            SingleProductResponse.fromMap(response.data);

        print(productResponse.toJson().toString());
        return productResponse;
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("getSingleProduct --> 1");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<RatingByProductIDResponse> getRatingByProductID(
      RateByProductRequest rate) async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.getRatingByProductID(rate)),
          options: options);

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        RatingByProductIDResponse ratingByProductIDResponse =
            RatingByProductIDResponse.fromMap(response.data);

        return ratingByProductIDResponse;
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);
        RatingByProductIDResponse ratingByProductIDResponse =
            RatingByProductIDResponse.fromMap(response.data);

        print(ratingByProductIDResponse.toJson().toString());
        return ratingByProductIDResponse;
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
