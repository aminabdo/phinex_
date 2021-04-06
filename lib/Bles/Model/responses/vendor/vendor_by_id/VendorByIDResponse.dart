import 'package:phinex/utils/base/BaseResponse.dart';

import 'VendorBean.dart';

class VendorByIDResponse extends BaseResponse {
  VendorBean data;

  static VendorByIDResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    VendorByIDResponse vendorByIDResponseBean = VendorByIDResponse();
    vendorByIDResponseBean.data = VendorBean.fromMap(map['data']);
    vendorByIDResponseBean.message = map['message'];
    vendorByIDResponseBean.code = map['code'];
    return vendorByIDResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}





