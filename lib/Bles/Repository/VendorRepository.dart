import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/vendor/vendor_by_id/VendorByIDResponse.dart';
import 'package:phinex/Bles/Model/responses/vendor/vendor_products/VendorProductsResponse.dart';
import 'package:phinex/Bles/Model/responses/vendor/vendor_rating/VendorRatingResponse.dart';
import 'package:phinex/Bles/api_provider/store/VendorApiProvider.dart';

class VendorRepository {
  VendorApiProvider _apiProvider = VendorApiProvider();

  Future<VendorByIDResponse> getVendor(dynamic vendorID) {
    return _apiProvider.getVendorById(vendorID);
  }

  Future<VendorRatingResponse> getVendorRating(BaseRequestSkipTake vendor) {
    return _apiProvider.getVendorRating(vendor);
  }

  Future<VendorProductsResponse> getSingleProduct(BaseRequestSkipTake vendor) {
    return _apiProvider.getVendorProducts(vendor);
  }
}
