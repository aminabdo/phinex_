
import 'ProfessionsByUserResponse.dart';

class ProfessionsSearchResponse {
  DataBean data;
  dynamic message;
  int code;

  static ProfessionsSearchResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProfessionsSearchResponse professionsSearchResponseBean = ProfessionsSearchResponse();
    professionsSearchResponseBean.data = DataBean.fromMap(map['data']);
    professionsSearchResponseBean.message = map['message'];
    professionsSearchResponseBean.code = map['code'];
    return professionsSearchResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  List<ProfessionBean> results;
  int total;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.results = List()..addAll(
      (map['results'] as List ?? []).map((o) => ProfessionBean.fromMap(o))
    );
    dataBean.total = map['total'];
    return dataBean;
  }

  Map toJson() => {
    "results": results,
    "total": total,
  };
}
