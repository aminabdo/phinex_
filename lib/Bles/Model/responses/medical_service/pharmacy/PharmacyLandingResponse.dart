
import 'package:phinex/Bles/Model/responses/medical_service/medical_service/Pharmacy.dart';

class PharmacyLandingResponse {
  List<Pharmacy> pharmacy;
  dynamic message;
  int code;

  static PharmacyLandingResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    print('>>>>>>> $map');
    PharmacyLandingResponse pharmaciesResponseBean = PharmacyLandingResponse();
    pharmaciesResponseBean.pharmacy = List()..addAll(
        (map['data'] as List ?? []).map((o) => Pharmacy.fromMap(o))
    );
    pharmaciesResponseBean.message = map['message'];
    pharmaciesResponseBean.code = map['code'];
    print('<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>> ${pharmaciesResponseBean.toJson()}');
    return pharmaciesResponseBean;
  }

  Map toJson() => {
    "pharmacy": pharmacy,
    "message": message,
    "code": code,
  };
}
