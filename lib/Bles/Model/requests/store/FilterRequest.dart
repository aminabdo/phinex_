

import '../BaseRequestSkipTake.dart';

class FilterRequest extends BaseRequestSkipTake {
  String categories;
  int maxPrice;
  int minPrice;
  int rates;
  String sortby;
  String order;
  int skip;
  int take;
  int discount;

  FilterRequest({this.categories, this.maxPrice, this.minPrice, this.order, this.rates, this.sortby, this.skip , this.take , this.discount});

  static FilterRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    FilterRequest filterRequestBean = FilterRequest();
    filterRequestBean.categories = map['category_id'];
    filterRequestBean.maxPrice = map['max_price'];
    filterRequestBean.minPrice = map['min_price'];
    filterRequestBean.rates = map['rates'];
    filterRequestBean.sortby = map['sortby'];
    filterRequestBean.order = map['order'];
    filterRequestBean.discount = map['discount'];
    return filterRequestBean;
  }

  Map toJson() => {
    "category_id": categories,
    "max_price": maxPrice,
    "min_price": minPrice,
    "rates": rates,
    "sortby": sortby,
    "order": order,
    "discount": discount,
  };

}