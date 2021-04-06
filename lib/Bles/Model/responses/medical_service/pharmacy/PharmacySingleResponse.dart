
import 'package:phinex/Bles/Model/responses/medical_service/medical_service/Pharmacy.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsByUserResponse.dart';

import 'PharmacyProductsResponse.dart';

class PharmacySingleResponse {
  DataBean data;
  dynamic message;
  int code;

  static PharmacySingleResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    PharmacySingleResponse pharmacySingleResponseBean = PharmacySingleResponse();
    pharmacySingleResponseBean.data = DataBean.fromMap(map['data']);
    pharmacySingleResponseBean.message = map['message'];
    pharmacySingleResponseBean.code = map['code'];
    return pharmacySingleResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  Pharmacy pharmacy;
  List<RateBean> rates;
  List<ProductsBean> products;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.pharmacy = Pharmacy.fromMap(map['pharmacy']);
    dataBean.rates = List()..addAll(
        (map['rates'] as List ?? []).map((o) => RateBean.fromMap(o))
    );
    dataBean.products = List()..addAll(
      (map['products'] as List ?? []).map((o) => ProductsBean.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "pharmacy": pharmacy,
    "rates": rates,
    "products": products,
  };
}
