import 'general.dart';

/// data : [{"id":15,"email":"test@test.test","mobile":"01234567890","country_id":64,"governorate_id":151,"city_id":12154,"category_id":125,"recruiter_id":8,"type":"FullTime","created_at":"2021-01-09 02:57:25","updated_at":"2021-01-09 02:57:25","deleted_at":null,"about":"universal group for recruitment","title":"aaaaaaaaaaaaaaaaaaaaaaaaaaa","description":"aaaaaaaaaaa","requirements":"aaaaaaaaaaaa","recruiter":{"user_id":8,"image_id":null,"email":null,"country":"1","governorate":"1","city":"1","address":"address","address_latitude":null,"address_longitude":null,"deleted_at":null,"created_at":"2020-11-24T10:36:15.000000Z","updated_at":"2020-11-24T10:36:15.000000Z","cover_image_id":null,"education":null,"job_title":null,"description":null}},{"id":11,"email":"test@test.test","mobile":"01234567890","country_id":64,"governorate_id":151,"city_id":12154,"category_id":125,"recruiter_id":8,"type":"FullTime","created_at":"2021-01-09 02:54:51","updated_at":"2021-01-09 02:54:51","deleted_at":null,"recruiter":{"user_id":8,"image_id":null,"email":null,"country":"1","governorate":"1","city":"1","address":"address","address_latitude":null,"address_longitude":null,"deleted_at":null,"created_at":"2020-11-24T10:36:15.000000Z","updated_at":"2020-11-24T10:36:15.000000Z","cover_image_id":null,"education":null,"job_title":null,"description":null}},{"id":16,"email":"test@test.test","mobile":"01234567890","country_id":64,"governorate_id":151,"city_id":12154,"category_id":125,"recruiter_id":8,"type":"FullTime","created_at":"2021-01-09 02:58:16","updated_at":"2021-01-09 02:58:16","deleted_at":null,"about":"universal group for recruitment","title":"aaaaaaaaaaaaaaaaaaaaaaaaaaa","description":"aaaaaaaaaaa","requirements":"aaaaaaaaaaaa","recruiter":{"user_id":8,"image_id":null,"email":null,"country":"1","governorate":"1","city":"1","address":"address","address_latitude":null,"address_longitude":null,"deleted_at":null,"created_at":"2020-11-24T10:36:15.000000Z","updated_at":"2020-11-24T10:36:15.000000Z","cover_image_id":null,"education":null,"job_title":null,"description":null}},{"id":4,"email":"test@test.test","mobile":"01234567890","country_id":64,"governorate_id":151,"city_id":12154,"category_id":125,"recruiter_id":8,"type":"PartTime","created_at":"2021-01-09 02:50:38","updated_at":"2021-01-09 03:04:46","deleted_at":null,"about":"universal group for recruitment","title":"zzzzzzzzzzzzzzzzzzzzzzzzz","description":"zzzzzzzzzzzzzzzzzzzzzzzz","requirements":"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz","recruiter":{"user_id":8,"image_id":null,"email":null,"country":"1","governorate":"1","city":"1","address":"address","address_latitude":null,"address_longitude":null,"deleted_at":null,"created_at":"2020-11-24T10:36:15.000000Z","updated_at":"2020-11-24T10:36:15.000000Z","cover_image_id":null,"education":null,"job_title":null,"description":null}},{"id":9,"email":"test@test.test","mobile":"01234567890","country_id":64,"governorate_id":151,"city_id":12154,"category_id":125,"recruiter_id":8,"type":"FullTime","created_at":"2021-01-09 02:54:34","updated_at":"2021-01-09 02:54:34","deleted_at":null,"recruiter":{"user_id":8,"image_id":null,"email":null,"country":"1","governorate":"1","city":"1","address":"address","address_latitude":null,"address_longitude":null,"deleted_at":null,"created_at":"2020-11-24T10:36:15.000000Z","updated_at":"2020-11-24T10:36:15.000000Z","cover_image_id":null,"education":null,"job_title":null,"description":null}}]
/// message : null
/// code : 200

class RandomJobs {
  List<Jobs> data;
  dynamic message;
  int code;

  static RandomJobs fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RandomJobs randomJobsBean = RandomJobs();
    randomJobsBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => Jobs.fromMap(o))
    );
    randomJobsBean.message = map['message'];
    randomJobsBean.code = map['code'];
    return randomJobsBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}
