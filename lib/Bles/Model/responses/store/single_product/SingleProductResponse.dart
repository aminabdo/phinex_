import 'package:phinex/Bles/Model/responses/store/store_responses/ProductsBean.dart';
import 'package:phinex/utils/base/BaseResponse.dart';

import 'RatesBean.dart';
import 'RelatedByCategoryBean.dart';
import 'RelatedByVendorBean.dart';

class SingleProductResponse extends BaseResponse {
  DataBean data;

  static SingleProductResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SingleProductResponse singleProductResponseBean = SingleProductResponse();
    singleProductResponseBean.data = DataBean.fromMap(map['data']);
    singleProductResponseBean.message = map['message'];
    singleProductResponseBean.code = map['code'];
    return singleProductResponseBean;
  }

  Map toJson() => {
        "data": data,
        "message": message,
        "code": code,
      };
}

class DataBean {
  ProductsBean product;
  List<RelatedByCategoryBean> relatedByCategory;
  List<RelatedByVendorBean> relatedByVendor;
  List<RatesBean> rates;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.product = ProductsBean.fromMap(map['product']);
    dataBean.relatedByCategory = List()
      ..addAll((map['relatedByCategory'] as List ?? [])
          .map((o) => RelatedByCategoryBean.fromMap(o)));
    dataBean.relatedByVendor = List()
      ..addAll((map['relatedByVendor'] as List ?? [])
          .map((o) => RelatedByVendorBean.fromMap(o)));
    dataBean.rates = List()
      ..addAll((map['rates'] as List ?? []).map((o) => RatesBean.fromMap(o)));
    return dataBean;
  }

  Map toJson() => {
        "product": product,
        "relatedByCategory": relatedByCategory,
        "relatedByVendor": relatedByVendor,
        "rates": rates,
      };
}
