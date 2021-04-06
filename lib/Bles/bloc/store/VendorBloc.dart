import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/vendor/vendor_by_id/VendorByIDResponse.dart';
import 'package:phinex/Bles/Model/responses/vendor/vendor_products/VendorProductsResponse.dart';
import 'package:phinex/Bles/Model/responses/vendor/vendor_rating/VendorRatingResponse.dart';
import 'package:phinex/Bles/Repository/VendorRepository.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

class VendorBloc extends BaseBloc {
  final VendorRepository _repository = VendorRepository();

  BehaviorSubject<VendorByIDResponse> _vendor_by_id =
      BehaviorSubject<VendorByIDResponse>();
  BehaviorSubject<VendorProductsResponse> _vendor_products =
      BehaviorSubject<VendorProductsResponse>();
  BehaviorSubject<VendorRatingResponse> _vendor_rating =
      BehaviorSubject<VendorRatingResponse>();

  getVendor(dynamic vendorID) async {
    loading.value = true;
    VendorByIDResponse response = await _repository.getVendor(vendorID);
    _vendor_by_id.value = response;
    loading.value = false;
  }

  getVendorProducts(BaseRequestSkipTake request) async {
    loading.value = true;

    VendorProductsResponse response =
        await _repository.getSingleProduct(request);


    if(request.skip == 0){
      _vendor_products.value = response;

    }else{
      _vendor_products.value.data.addAll(response.data);
      _vendor_products.value = _vendor_products.value;
    }

    updateVendorroducs(response);
    loading.value = false;

  }


  getVendorRating(BaseRequestSkipTake vendor) async {
    VendorRatingResponse response = await _repository.getVendorRating(vendor);

    _vendor_rating.value = response;

    updateRate(response);

    print("vendorID --->   " + vendor.id.toString());
  }


  void updateRate(VendorRatingResponse response) {
    _vendor_by_id.value.data.rating.addAll(response.data);
    _vendor_by_id.value = _vendor_by_id.value ;
  }


  void updateVendorroducs(VendorProductsResponse response) {
    _vendor_by_id.value.data.products.addAll(response.data);
    _vendor_by_id.value = _vendor_by_id.value ;
  }

  dispose() {
    _vendor_rating.close();
    _vendor_products.close();
    _vendor_by_id.close();
  }

  clear() {
    _vendor_by_id =BehaviorSubject<VendorByIDResponse>();
    _vendor_products =BehaviorSubject<VendorProductsResponse>();
     _vendor_rating = BehaviorSubject<VendorRatingResponse>();
  }

  BehaviorSubject<VendorByIDResponse> get vendorByID => _vendor_by_id;

  BehaviorSubject<VendorProductsResponse> get VendorProducts =>
      _vendor_products;

  BehaviorSubject<VendorRatingResponse> get VendorRates => _vendor_rating;



}

// amin
final vendorBloc = VendorBloc();
