import 'package:phinex/ui/views/became_a_partner/real_state/real_state_personal_data_body.dart';

import 'RealStateFilterResponse.dart';

class RealStateSearchResponse {
  RealStateSearchData data;
  dynamic message;
  int code;

  static RealStateSearchResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RealStateSearchResponse indexSearchResponseBean = RealStateSearchResponse();
    indexSearchResponseBean.data = RealStateSearchData.fromMap(map['data']);
    indexSearchResponseBean.message = map['message'];
    indexSearchResponseBean.code = map['code'];
    return indexSearchResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class RealStateSearchData {
  List<RealestatesBean> results;
  int total;

  RealStateSearchData({this.results, this.total});

  static RealStateSearchData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RealStateSearchData searchResult = RealStateSearchData();
    searchResult.results = List()..addAll((map['results'] as List ?? []).map((o) => RealestatesBean.fromMap(o)));
    searchResult.total = map['total'];
    return searchResult;
  }
}

