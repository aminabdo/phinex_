import 'package:phinex/Bles/Model/responses/store/store_responses/ProductsBean.dart';
import 'package:phinex/utils/base/BaseResponse.dart';

class VendorProductsResponse extends BaseResponse {
  List<ProductsBean> data;

  static VendorProductsResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    VendorProductsResponse vendorProductsResponseBean = VendorProductsResponse();
    vendorProductsResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => ProductsBean.fromMap(o))
    );
    vendorProductsResponseBean.message = map['message'];
    vendorProductsResponseBean.code = map['code'];
    return vendorProductsResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

