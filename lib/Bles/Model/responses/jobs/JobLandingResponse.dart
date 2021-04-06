import 'general.dart';

/// data : [{"id":49,"name":"Plate Numbers","description":"licence plate","keywords":"licence plate","icon":null,"parent_id":3,"image_id":1018,"deleted_at":null,"created_at":"2020-07-27T15:40:38.000000Z","updated_at":"2020-09-02T08:49:12.000000Z","image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/02-Wed/YD3V8PhSXAC4n5KEh7jfd8XOuTogN765HfZGjTFe.jpeg"},{"id":74,"name":"Private Jets","description":"Participate in Private jets  Auction ","keywords":"Private Jets","icon":null,"parent_id":3,"image_id":996,"deleted_at":null,"created_at":"2020-09-02T08:02:15.000000Z","updated_at":"2020-09-02T08:02:15.000000Z","image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/02-Wed/FvBNpPqPar5OtK1VyeQ0rSPXqGAhkp5IIfuMvncw.jpeg"},{"id":75,"name":"Private Yachts","description":"Private Yachts","keywords":"Private Yachts","icon":null,"parent_id":3,"image_id":1010,"deleted_at":null,"created_at":"2020-09-02T08:46:20.000000Z","updated_at":"2020-09-02T08:46:20.000000Z","image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/02-Wed/h57zMvQPoXV56hsynbqrHnLhvaLAlNVyHtZ7DCgB.jpeg"},{"id":76,"name":"Horses","description":"Horses","keywords":"Horses","icon":null,"parent_id":3,"image_id":1019,"deleted_at":null,"created_at":"2020-09-02T08:53:35.000000Z","updated_at":"2020-09-02T08:53:35.000000Z","image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/02-Wed/i7KYBFMO1gtVXOO3Tb5sCHF9JbkDMJnlHy8OCDlH.jpeg"},{"id":77,"name":"Gems","description":"Gems","keywords":"Gems","icon":null,"parent_id":3,"image_id":1022,"deleted_at":null,"created_at":"2020-09-02T08:58:02.000000Z","updated_at":"2020-09-02T08:58:02.000000Z","image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/02-Wed/HfURj3F1n75Ps8Wg7PlYGP0jM8Y784R2Mq9q9Fek.jpeg"},{"id":78,"name":"Painting","description":"Painting","keywords":"Painting","icon":null,"parent_id":3,"image_id":1025,"deleted_at":null,"created_at":"2020-09-02T09:02:00.000000Z","updated_at":"2020-09-02T09:02:00.000000Z","image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/02-Wed/9KF9qEGOKxbU1FmtXJslc1kag71DbsXw5BjimYfd.jpeg"},{"id":79,"name":"Luxury Cars","description":"Luxury Cars","keywords":"Luxury Cars","icon":null,"parent_id":3,"image_id":1030,"deleted_at":null,"created_at":"2020-09-02T09:06:13.000000Z","updated_at":"2020-09-02T09:06:13.000000Z","image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/02-Wed/KCapGUKfmkLCugNVHVzWCD8AlII56f4vWn8IXFU0.jpeg"},{"id":83,"name":"Watches","description":"Watches","keywords":"Watches","icon":null,"parent_id":3,"image_id":1071,"deleted_at":null,"created_at":"2020-09-06T09:51:24.000000Z","updated_at":"2020-09-06T09:51:24.000000Z","image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/06-Sun/2YSzTLRZNrDNaMPyHtKFYryJnYw1heSJrjy4kP0y.jpeg"},{"id":84,"name":"Antiques","description":"Antiques","keywords":"Antiques","icon":null,"parent_id":3,"image_id":1073,"deleted_at":null,"created_at":"2020-09-06T10:10:47.000000Z","updated_at":"2020-09-06T10:10:47.000000Z","image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/06-Sun/thBwK6WSckfmSInTvbNuTiEJ17cfg1ywTrz676b1.jpeg"},{"id":246,"name":"LOT","description":"Whole Sale","keywords":"Whole Sale","icon":null,"parent_id":3,"image_id":1871,"deleted_at":null,"created_at":"2020-09-27T15:54:50.000000Z","updated_at":"2020-09-27T15:54:50.000000Z","image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/27-Sun/lot.jpeg"}]
/// message : null
/// code : 200

class JobCatResponse {
  List<JobCategory> data;
  dynamic message;
  int code;

  static JobCatResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    JobCatResponse jobLandingResponseBean = JobCatResponse();
    jobLandingResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => JobCategory.fromMap(o))
    );
    jobLandingResponseBean.message = map['message'];
    jobLandingResponseBean.code = map['code'];
    return jobLandingResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

