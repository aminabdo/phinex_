/// data : {"id":1,"user_id":3,"rental_period":"hour","rental_price_per_period":99,"transmission":"automatic","color":"red","title":"99","description":"666","manufacturer_year":2020,"country":64,"governorate":null,"city":null,"has_driver":1,"body_type":"Sedan","image_id":1847,"phone":"01004746085","created_at":"2020-09-22 10:02:13","updated_at":"2020-09-22 10:02:13","deleted_at":null,"image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/22-Tue/995f69cba51e57b.jpg","gallery":["https://images.tbdm.net/storage/app/public/images/2020-09/22-Tue/995f69cba51e57b.jpg","https://images.tbdm.net/storage/app/public/images/2020-09/22-Tue/092220201002130.jpg"],"user":{"id":3,"first_name":"ahmednegm","last_name":"ahmednegm","username":"ossama ossama","phone":"012345678933","verification_code":"767590","api_token":"913d779a8b7b12ee95fe16e86a4c9244","phone_verified_at":null,"type":"driver","chanel":"mobile","user_id":3,"image_id":null,"email":null,"country":null,"governorate":null,"city":null,"address":null,"address_latitude":null,"address_longitude":null,"deleted_at":null,"created_at":"2020-11-30T15:15:39.000000Z","updated_at":"2020-11-30T15:15:39.000000Z"},"car_model":{"id":4,"model_name":"Tipo","parent_id":"2","created_at":"2020-09-20 13:45:30","updated_at":"2020-09-20 13:45:30","deleted_at":null,"image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/20-Sun/tipo.jpeg"}}
/// message : null
/// code : 200

class CarRentalSingleResponse {
  DataBean data;
  dynamic message;
  int code;

  static CarRentalSingleResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CarRentalSingleResponse carRentalSingleResponseBean = CarRentalSingleResponse();
    carRentalSingleResponseBean.data = DataBean.fromMap(map['data']);
    carRentalSingleResponseBean.message = map['message'];
    carRentalSingleResponseBean.code = map['code'];
    return carRentalSingleResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

/// id : 1
/// user_id : 3
/// rental_period : "hour"
/// rental_price_per_period : 99
/// transmission : "automatic"
/// color : "red"
/// title : "99"
/// description : "666"
/// manufacturer_year : 2020
/// country : 64
/// governorate : null
/// city : null
/// has_driver : 1
/// body_type : "Sedan"
/// image_id : 1847
/// phone : "01004746085"
/// created_at : "2020-09-22 10:02:13"
/// updated_at : "2020-09-22 10:02:13"
/// deleted_at : null
/// image_url : "https://images.tbdm.net/storage/app/public/images/2020-09/22-Tue/995f69cba51e57b.jpg"
/// gallery : ["https://images.tbdm.net/storage/app/public/images/2020-09/22-Tue/995f69cba51e57b.jpg","https://images.tbdm.net/storage/app/public/images/2020-09/22-Tue/092220201002130.jpg"]
/// user : {"id":3,"first_name":"ahmednegm","last_name":"ahmednegm","username":"ossama ossama","phone":"012345678933","verification_code":"767590","api_token":"913d779a8b7b12ee95fe16e86a4c9244","phone_verified_at":null,"type":"driver","chanel":"mobile","user_id":3,"image_id":null,"email":null,"country":null,"governorate":null,"city":null,"address":null,"address_latitude":null,"address_longitude":null,"deleted_at":null,"created_at":"2020-11-30T15:15:39.000000Z","updated_at":"2020-11-30T15:15:39.000000Z"}
/// car_model : {"id":4,"model_name":"Tipo","parent_id":"2","created_at":"2020-09-20 13:45:30","updated_at":"2020-09-20 13:45:30","deleted_at":null,"image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/20-Sun/tipo.jpeg"}

class DataBean {
  int id;
  int userId;
  String rentalPeriod;
  num rentalPricePerPeriod;
  String transmission;
  String color;
  String title;
  String description;
  int manufacturerYear;
  int country;
  dynamic governorate;
  dynamic city;
  int hasDriver;
  String bodyType;
  int imageId;
  String phone;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String imageUrl;
  List<String> gallery;
  UserBean user;
  Car_modelBean carModel;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.id = map['id'];
    dataBean.userId = map['user_id'];
    dataBean.rentalPeriod = map['rental_period'];
    dataBean.rentalPricePerPeriod = num.parse((map['rental_price_per_period']).toString());
    dataBean.transmission = map['transmission'];
    dataBean.color = map['color'];
    dataBean.title = map['title'];
    dataBean.description = map['description'];
    dataBean.manufacturerYear = map['manufacturer_year'];
    dataBean.country = map['country'];
    dataBean.governorate = map['governorate'];
    dataBean.city = map['city'];
    dataBean.hasDriver = map['has_driver'];
    dataBean.bodyType = map['body_type'];
    dataBean.imageId = map['image_id'];
    dataBean.phone = map['phone'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.imageUrl = map['image_url'];
    dataBean.gallery = List()..addAll(
      (map['gallery'] as List ?? []).map((o) => o.toString())
    );
    dataBean.user = UserBean.fromMap(map['user']);
    dataBean.carModel = Car_modelBean.fromMap(map['car_model']);
    return dataBean;
  }

  Map toJson() => {
    "id": id,
    "user_id": userId,
    "rental_period": rentalPeriod,
    "rental_price_per_period": rentalPricePerPeriod,
    "transmission": transmission,
    "color": color,
    "title": title,
    "description": description,
    "manufacturer_year": manufacturerYear,
    "country": country,
    "governorate": governorate,
    "city": city,
    "has_driver": hasDriver,
    "body_type": bodyType,
    "image_id": imageId,
    "phone": phone,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "image_url": imageUrl,
    "gallery": gallery,
    "user": user,
    "car_model": carModel,
  };
}

/// id : 4
/// model_name : "Tipo"
/// parent_id : "2"
/// created_at : "2020-09-20 13:45:30"
/// updated_at : "2020-09-20 13:45:30"
/// deleted_at : null
/// image_url : "https://images.tbdm.net/storage/app/public/images/2020-09/20-Sun/tipo.jpeg"

class Car_modelBean {
  int id;
  String modelName;
  String parentId;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String imageUrl;

  static Car_modelBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Car_modelBean car_modelBean = Car_modelBean();
    car_modelBean.id = map['id'];
    car_modelBean.modelName = map['model_name'];
    car_modelBean.parentId = map['parent_id'];
    car_modelBean.createdAt = map['created_at'];
    car_modelBean.updatedAt = map['updated_at'];
    car_modelBean.deletedAt = map['deleted_at'];
    car_modelBean.imageUrl = map['image_url'];
    return car_modelBean;
  }

  Map toJson() => {
    "id": id,
    "model_name": modelName,
    "parent_id": parentId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "image_url": imageUrl,
  };
}

/// id : 3
/// first_name : "ahmednegm"
/// last_name : "ahmednegm"
/// username : "ossama ossama"
/// phone : "012345678933"
/// verification_code : "767590"
/// api_token : "913d779a8b7b12ee95fe16e86a4c9244"
/// phone_verified_at : null
/// type : "driver"
/// chanel : "mobile"
/// user_id : 3
/// image_id : null
/// email : null
/// country : null
/// governorate : null
/// city : null
/// address : null
/// address_latitude : null
/// address_longitude : null
/// deleted_at : null
/// created_at : "2020-11-30T15:15:39.000000Z"
/// updated_at : "2020-11-30T15:15:39.000000Z"

class UserBean {
  int id;
  String firstName;
  String lastName;
  String username;
  String phone;
  String verificationCode;
  String apiToken;
  dynamic phoneVerifiedAt;
  String type;
  String chanel;
  int userId;
  dynamic imageId;
  dynamic email;
  dynamic country;
  dynamic governorate;
  dynamic city;
  dynamic address;
  dynamic addressLatitude;
  dynamic addressLongitude;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;

  static UserBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserBean userBean = UserBean();
    userBean.id = map['id'];
    userBean.firstName = map['first_name'];
    userBean.lastName = map['last_name'];
    userBean.username = map['username'];
    userBean.phone = map['phone'];
    userBean.verificationCode = map['verification_code'];
    userBean.apiToken = map['api_token'];
    userBean.phoneVerifiedAt = map['phone_verified_at'];
    userBean.type = map['type'];
    userBean.chanel = map['chanel'];
    userBean.userId = map['user_id'];
    userBean.imageId = map['image_id'];
    userBean.email = map['email'];
    userBean.country = map['country'];
    userBean.governorate = map['governorate'];
    userBean.city = map['city'];
    userBean.address = map['address'];
    userBean.addressLatitude = map['address_latitude'];
    userBean.addressLongitude = map['address_longitude'];
    userBean.deletedAt = map['deleted_at'];
    userBean.createdAt = map['created_at'];
    userBean.updatedAt = map['updated_at'];
    return userBean;
  }

  Map toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "phone": phone,
    "verification_code": verificationCode,
    "api_token": apiToken,
    "phone_verified_at": phoneVerifiedAt,
    "type": type,
    "chanel": chanel,
    "user_id": userId,
    "image_id": imageId,
    "email": email,
    "country": country,
    "governorate": governorate,
    "city": city,
    "address": address,
    "address_latitude": addressLatitude,
    "address_longitude": addressLongitude,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}