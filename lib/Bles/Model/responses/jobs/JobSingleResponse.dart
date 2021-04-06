import 'general.dart';

/// data : {"id":5,"email":"test@test.test","mobile":"01234567890","country_id":64,"governorate_id":151,"city_id":12154,"category_id":125,"recruiter_id":8,"type":"FullTime","created_at":"2021-01-09 02:51:30","updated_at":"2021-01-09 02:51:30","deleted_at":null,"recruiter":{"user_id":8,"image_id":null,"email":null,"country":"1","governorate":"1","city":"1","address":"address","address_latitude":null,"address_longitude":null,"deleted_at":null,"created_at":"2020-11-24T10:36:15.000000Z","updated_at":"2020-11-24T10:36:15.000000Z","cover_image_id":null,"education":null,"job_title":null,"description":null}}
/// message : null
/// code : 200

class JobSingleResponse {
  Jobs data;
  dynamic message;
  int code;

  static JobSingleResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    JobSingleResponse jobSingleResponseBean = JobSingleResponse();
    jobSingleResponseBean.data = Jobs.fromMap(map['data']);
    jobSingleResponseBean.message = map['message'];
    jobSingleResponseBean.code = map['code'];
    return jobSingleResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}
