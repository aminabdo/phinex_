import 'package:phinex/Bles/Model/responses/medical_service/common/CommonSingleResponse.dart';

class CommonPaginResponse {
  List<CommonBean> data;
  String message;
  int code;

  static CommonPaginResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CommonPaginResponse commonPaginResponseBean = CommonPaginResponse();
    commonPaginResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => CommonBean.fromMap(o))
    );
    commonPaginResponseBean.message = map['message'];
    commonPaginResponseBean.code = map['code'];
    return commonPaginResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}


