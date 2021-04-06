import 'CatalogueSingleResponse.dart';

/// data : []
/// message : null
/// code : 200

class CatalogueByCatResponse {
  List<Catalogue> data;
  dynamic message;
  int code;

  static CatalogueByCatResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CatalogueByCatResponse catalogueByCatResponseBean = CatalogueByCatResponse();
    catalogueByCatResponseBean.data = List()..addAll(
        (map['data'] as List ?? []).map((o) => Catalogue.fromMap(o))
    );
    catalogueByCatResponseBean.message = map['message'];
    catalogueByCatResponseBean.code = map['code'];
    return catalogueByCatResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}