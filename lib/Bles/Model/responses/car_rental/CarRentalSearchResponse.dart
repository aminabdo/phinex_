import 'CarRentalFilterResponse.dart';

/// data : [{"id":1,"user_id":3,"rental_period":"hour","rental_price_per_period":99,"transmission":"automatic","color":"red","title":"99","description":"666","manufacturer_year":2020,"country":64,"governorate":null,"city":null,"has_driver":1,"body_type":"Sedan","image_id":1847,"phone":"01004746085","created_at":"2020-09-22 10:02:13","updated_at":"2020-09-22 10:02:13","deleted_at":null,"car_model":{"id":4,"model_name":"Tipo","parent_id":"2","created_at":"2020-09-20 13:45:30","updated_at":"2020-09-20 13:45:30","deleted_at":null,"image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/20-Sun/tipo.jpeg"}},{"id":2,"user_id":60,"rental_period":"hour","rental_price_per_period":222,"transmission":"manual","color":"grey","title":"car rent","description":"desc","manufacturer_year":1478,"country":64,"governorate":null,"city":null,"has_driver":1,"body_type":"Sedan","image_id":2795,"phone":"11111111111","created_at":"2020-10-31 16:01:27","updated_at":"2020-10-31 16:01:27","deleted_at":null,"car_model":{"id":40,"model_name":"Rio","parent_id":"39","created_at":"2020-10-27 14:55:48","updated_at":"2020-10-27 14:55:48","deleted_at":null,"image_url":"https://images.tbdm.net/storage/app/public/images/2020-10/27-Tue/rio.jpeg"}},{"id":3,"user_id":8,"rental_period":"day","rental_price_per_period":20,"transmission":"automatic","color":"Red","title":"20$ / h","description":"aaa aaa bbb","manufacturer_year":2012,"country":64,"governorate":null,"city":null,"has_driver":1,"body_type":"Sedan","image_id":2797,"phone":"01234567890","created_at":"2020-10-31 21:59:34","updated_at":"2020-10-31 21:59:34","deleted_at":null,"car_model":{"id":41,"model_name":"Cerato","parent_id":"39","created_at":"2020-10-27 14:55:57","updated_at":"2020-10-27 14:55:57","deleted_at":null,"image_url":"https://images.tbdm.net/storage/app/public/images/2020-10/27-Tue/cerato.jpeg"}},{"id":4,"user_id":1,"rental_period":"hour","rental_price_per_period":500,"transmission":"manual","color":"blue","title":"blue vehicle","description":"blue truck to be fixed","manufacturer_year":2008,"country":64,"governorate":null,"city":null,"has_driver":0,"body_type":"truck","image_id":2799,"phone":"01062547928","created_at":"2020-11-01 09:06:45","updated_at":"2020-11-01 09:06:45","deleted_at":null,"car_model":{"id":44,"model_name":"Tipo","parent_id":"43","created_at":"2020-10-27 14:58:56","updated_at":"2020-10-27 14:58:56","deleted_at":null,"image_url":"https://images.tbdm.net/storage/app/public/images/2020-10/27-Tue/tipo.png"}},{"id":5,"user_id":8,"rental_period":"hour","rental_price_per_period":50,"transmission":"manual","color":"hgvh","title":"hhhhhh","description":"hfcgfchg","manufacturer_year":2000,"country":64,"governorate":null,"city":null,"has_driver":0,"body_type":"hatchback","image_id":2814,"phone":"01234567890","created_at":"2020-11-02 20:22:00","updated_at":"2020-11-02 20:22:00","deleted_at":null,"car_model":{"id":40,"model_name":"Rio","parent_id":"39","created_at":"2020-10-27 14:55:48","updated_at":"2020-10-27 14:55:48","deleted_at":null,"image_url":"https://images.tbdm.net/storage/app/public/images/2020-10/27-Tue/rio.jpeg"}},{"id":6,"user_id":12,"rental_period":"day","rental_price_per_period":777,"transmission":"manual","color":"grey","title":"rent car","description":"desc","manufacturer_year":1789,"country":null,"governorate":null,"city":null,"has_driver":1,"body_type":"SUV","image_id":2816,"phone":"01122334455","created_at":"2020-11-02 20:22:25","updated_at":"2020-11-02 20:22:25","deleted_at":null,"car_model":{"id":40,"model_name":"Rio","parent_id":"39","created_at":"2020-10-27 14:55:48","updated_at":"2020-10-27 14:55:48","deleted_at":null,"image_url":"https://images.tbdm.net/storage/app/public/images/2020-10/27-Tue/rio.jpeg"}}]
/// message : null
/// code : 200

class CarRentalSearchResponse {
  List<CarsBean> data;
  dynamic message;
  int code;

  static CarRentalSearchResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CarRentalSearchResponse carRentalSearchResponseBean = CarRentalSearchResponse();
    carRentalSearchResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => CarsBean.fromMap(o))
    );
    carRentalSearchResponseBean.message = map['message'];
    carRentalSearchResponseBean.code = map['code'];
    return carRentalSearchResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

