import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/vendor/vendor_by_id/VendorByIDResponse.dart';
import 'package:phinex/Bles/Model/responses/vendor/vendor_products/VendorProductsResponse.dart';
import 'package:phinex/Bles/Model/responses/vendor/vendor_rating/VendorRatingResponse.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class VendorApiProvider extends BaseApiProvider {
  Options options = Options(
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      });
  final Dio _dio = Dio();

  Future<VendorByIDResponse> getVendorById(dynamic vendorID) async {
    try {
      print("response --------...... ---> " + ApiRoutesUpdate().getLink(ApiRoutes.getVendorByID(vendorID)));

      Response response = await _dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.getVendorByID(vendorID)),
          options: options);

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        VendorByIDResponse vendorResponse =
        VendorByIDResponse.fromMap(response.data);

        return vendorResponse;
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);
        VendorByIDResponse vendorResponse =
        VendorByIDResponse.fromMap(response.data);

        print(vendorResponse.toJson().toString());
        return vendorResponse;
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }


  Future<VendorProductsResponse> getVendorProducts(BaseRequestSkipTake vendor) async {
    try {
      print("response --------...... ---> " + ApiRoutesUpdate().getLink(ApiRoutes.getProductsByVendor(vendor)));

      Response response = await _dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.getProductsByVendor(vendor)),
          options: options);

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        VendorProductsResponse vendorProductsResponse =
        VendorProductsResponse.fromMap(response.data);

        return vendorProductsResponse;
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);
        VendorProductsResponse vendorProductsResponse =
        VendorProductsResponse.fromMap(response.data);

        print(vendorProductsResponse.toJson().toString());
        return vendorProductsResponse;
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }


  Future<VendorRatingResponse> getVendorRating(BaseRequestSkipTake vendor) async {
    try {
      print("response --------...... ---> " + ApiRoutesUpdate().getLink(ApiRoutes.getVendorRating(vendor)));

      Response response = await _dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.getVendorRating(vendor)),
          options: options);

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        VendorRatingResponse vendorRatingResponse =
        VendorRatingResponse.fromMap(response.data);

        return vendorRatingResponse;
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);
        VendorRatingResponse vendorRatingResponse =
        VendorRatingResponse.fromMap(response.data);

        print(vendorRatingResponse.toJson().toString());
        return vendorRatingResponse;
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

}