import 'package:phinex/Bles/Model/responses/store/store_responses/ProductsBean.dart';

import 'FilterResponse.dart';

class FilterByProductsResponse {
  DataBean data;
  dynamic message;
  int code;

  static FilterByProductsResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    FilterByProductsResponse filterByProductsResponseBean = FilterByProductsResponse();
    filterByProductsResponseBean.data = DataBean.fromMap(map['data']);
    filterByProductsResponseBean.message = map['message'];
    filterByProductsResponseBean.code = map['code'];
    return filterByProductsResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  List<ProductsBean> products;
  List<CategoriesBean> categories;
  FiltrationBean filtration;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.products = List()..addAll(
      (map['products'] as List ?? []).map((o) => ProductsBean.fromMap(o))
    );
    dataBean.categories = List()..addAll(
      (map['categories'] as List ?? []).map((o) => CategoriesBean.fromMap(o))
    );
    dataBean.filtration = FiltrationBean.fromMap(map['filtration']);
    return dataBean;
  }

  Map toJson() => {
    "products": products,
    "categories": categories,
    "filtration": filtration,
  };
}

class FiltrationBean {
  int max_price;

  static FiltrationBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    FiltrationBean filtrationBean = FiltrationBean();
    filtrationBean.max_price = map['max-price'];
    return filtrationBean;
  }

  Map toJson() => {
    "max-price": max_price,
  };
}