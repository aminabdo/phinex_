import 'package:phinex/Bles/Model/responses/medical_service/medical_service/Doctor.dart';
import 'package:phinex/Bles/Model/responses/medical_service/medical_service/MedicalServiceLanding.dart';

/// data : [{"id":34,"doctor_id":34,"image_id":1694,"category_id":18,"commercial_name":"ali hussein","home_visit":1,"degree":"consultant","short_description":"short desc","description":"desc","city":5909,"governorate":42,"country":1,"total_reviews":5,"total_rates":3,"status":"published","created_at":"2020-09-14 12:06:39","updated_at":"2020-10-29 13:09:41","deleted_at":null,"image_url":"https://images.phinex.net/storage/app/public/images/2020-09/14-Mon/ali_hussein.jpeg","first_name":"ali","last_name":"hussein","username":"ali hussein","phone":"01234567895","verification_code":"675369","api_token":"fdc8cbcf95cf27f50559eedcaa715a01","phone_verified_at":null,"type":"doctor","chanel":"web","speciality":"Dentist "},{"id":186,"doctor_id":186,"image_id":2763,"category_id":18,"commercial_name":"Salama","home_visit":1,"degree":"professor","short_description":"shereen","description":"shereen","city":15400,"governorate":1044,"country":64,"total_reviews":0,"total_rates":0,"status":"pending","created_at":"2020-10-28 10:29:56","updated_at":"2020-10-28 10:29:56","deleted_at":null,"image_url":"https://images.phinex.net/storage/app/public/images/2020-10/28-Wed/salama.jpeg","first_name":"shereen","last_name":"salama","username":"shereen salama","phone":"2258496871","verification_code":"438940","api_token":"bd1a3b958650e87a45a7bce6f6388166","phone_verified_at":null,"type":"doctor","chanel":"web","speciality":"Dentist "},{"id":193,"doctor_id":193,"image_id":2780,"category_id":18,"commercial_name":"asdasd","home_visit":1,"degree":"specialist","short_description":"asdasd","description":"asdasd","city":5914,"governorate":43,"country":1,"total_reviews":0,"total_rates":0,"status":"pending","created_at":"2020-10-29 11:52:43","updated_at":"2020-10-29 11:52:43","deleted_at":null,"image_url":"https://images.phinex.net/storage/app/public/images/2020-10/29-Thu/asdasd.jpeg","first_name":"Ahmed","last_name":"Wageh","username":"ahmed wageh","phone":"46546548787","verification_code":"311984","api_token":"a36901f0448c8e4ee8a10e3d8f313db9","phone_verified_at":null,"type":"doctor","chanel":"web","speciality":"Dentist "},{"id":194,"doctor_id":194,"image_id":2782,"category_id":18,"commercial_name":"yiuoyuio","home_visit":1,"degree":"professor","short_description":"asdasd","description":"asdasdasd","city":5909,"governorate":42,"country":1,"total_reviews":0,"total_rates":0,"status":"pending","created_at":"2020-10-29 12:00:38","updated_at":"2020-10-29 12:00:38","deleted_at":null,"image_url":"https://images.phinex.net/storage/app/public/images/2020-10/29-Thu/yiuoyuio.jpeg","first_name":"yuioyuio","last_name":"yuioyuio","username":"yuioyuio yuioyuio","phone":"58447859654","verification_code":"143487","api_token":"4ed5500d696c3c17ab5094c775666b23","phone_verified_at":null,"type":"doctor","chanel":"web","speciality":"Dentist "},{"id":316,"doctor_id":316,"image_id":2942,"category_id":18,"commercial_name":"sddss","home_visit":1,"degree":"professor","short_description":"123","description":"123","city":13541,"governorate":813,"country":49,"total_reviews":0,"total_rates":0,"status":"pending","created_at":"2020-11-17 13:13:14","updated_at":"2020-11-17 13:13:14","deleted_at":null,"image_url":"https://images.phinex.net/storage/app/public/images/2020-11/17-Tue/sddss.jpeg","first_name":"Sarah","last_name":"sayed","username":"sarah sayed","phone":"01132334457","verification_code":"300315","api_token":"ee343118d14f724ba80e6682c21bf7d9","phone_verified_at":null,"type":"doctor","chanel":"web","speciality":"Dentist "}]
/// message : null
/// code : 200

class DoctorBySpecialityResponse {
  List<CommonBean> data;
  dynamic message;
  int code;

  static DoctorBySpecialityResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DoctorBySpecialityResponse doctorBySpecialityResponseBean = DoctorBySpecialityResponse();
    doctorBySpecialityResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => CommonBean.fromMap(o))
    );
    doctorBySpecialityResponseBean.message = map['message'];
    doctorBySpecialityResponseBean.code = map['code'];
    return doctorBySpecialityResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}
