import 'package:phinex/Bles/Model/responses/medical_service/medical_service/Pharmacy.dart';

/// pharmacy : [{"title":"Pharmacy title","user_id":215,"country":1,"governorate":1,"city":1,"address":"Address details","longitude":"1.2220000","latitude":"7.2554000","phone":1354684684,"home_visit":1,"delivery_status":"as_open","total_reviews":0,"total_rates":0,"saturday":0,"sunday":0,"monday":1,"tuesday":1,"wednesday":0,"thursday":1,"friday":0,"open_at":"00:00:00","closing_at":"00:00:00","pharmacyId":19,"logo_url":"https://images.phinex.net/storage/app/public/images/2020-11/30-Mon/pharmacy_title-logo-1606732178.png","cover_image_url":"https://images.phinex.net/storage/app/public/images/2020-11/30-Mon/pharmacy_title-cover-1606732178.png"},{"title":"elezzzzaby","user_id":216,"country":64,"governorate":1048,"city":15420,"address":"sdss","longitude":"1.2220000","latitude":"7.2554000","phone":2323,"home_visit":1,"delivery_status":"24/7","total_reviews":0,"total_rates":0,"saturday":1,"sunday":1,"monday":1,"tuesday":1,"wednesday":1,"thursday":1,"friday":1,"open_at":"02:03:00","closing_at":"05:00:00","pharmacyId":20,"logo_url":"https://images.phinex.net/storage/app/public/images/2020-11/30-Mon/elezzzzaby-logo-1606732267.png","cover_image_url":"https://images.phinex.net/storage/app/public/images/2020-11/30-Mon/elezzzzaby-cover-1606732267.png"},{"title":"ElEzzaby","user_id":379,"country":64,"governorate":1048,"city":15420,"address":"October","longitude":"1.2220000","latitude":"7.2554000","phone":254544,"home_visit":1,"delivery_status":"none","total_reviews":0,"total_rates":0,"saturday":1,"sunday":1,"monday":1,"tuesday":1,"wednesday":1,"thursday":1,"friday":1,"open_at":"12:00:00","closing_at":"12:00:00","pharmacyId":22,"logo_url":"https://images.phinex.net/storage/app/public/images/2020-11/30-Mon/elezzaby-logo-1606735563.png","cover_image_url":"https://images.phinex.net/storage/app/public/images/2020-11/30-Mon/elezzaby-cover-1606735563.png"},{"title":"Gamal","user_id":379,"country":64,"governorate":1048,"city":15420,"address":"Ispatis","longitude":"1.2220000","latitude":"7.2554000","phone":54854,"home_visit":1,"delivery_status":"as_open","total_reviews":0,"total_rates":0,"saturday":1,"sunday":1,"monday":1,"tuesday":0,"wednesday":0,"thursday":0,"friday":1,"open_at":"02:03:00","closing_at":"14:03:00","pharmacyId":23,"logo_url":"https://images.phinex.net/storage/app/public/images/2020-12/02-Wed/gamal-logo-1606901532.jpeg","cover_image_url":"https://images.phinex.net/storage/app/public/images/2020-12/02-Wed/gamal-cover-1606901532.jpeg"}]
/// message : null
/// code : 200

class PharmaciesResponse {
  List<Pharmacy> pharmacy;
  dynamic message;
  int code;

  static PharmaciesResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    PharmaciesResponse pharmaciesResponseBean = PharmaciesResponse();
    pharmaciesResponseBean.pharmacy = List()..addAll(
      (map['pharmacy'] as List ?? []).map((o) => Pharmacy.fromMap(o))
    );
    pharmaciesResponseBean.message = map['message'];
    pharmaciesResponseBean.code = map['code'];
    return pharmaciesResponseBean;
  }

  Map toJson() => {
    "pharmacy": pharmacy,
    "message": message,
    "code": code,
  };
}
