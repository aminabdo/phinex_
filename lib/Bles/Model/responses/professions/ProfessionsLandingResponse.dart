import 'package:phinex/Bles/Model/responses/professions/ProfessionsByUserResponse.dart';

/// data : {"categories":[{"id":35,"name":"Carpenter","description":"Carpenter","keywords":"carpenter","icon":null,"parent_id":12,"image_id":94,"deleted_at":null,"created_at":"2020-06-29T00:32:09.000000Z","updated_at":"2020-06-29T00:32:09.000000Z"},{"id":36,"name":"Plumber","description":"Plumber","keywords":"Plumber","icon":null,"parent_id":12,"image_id":96,"deleted_at":null,"created_at":"2020-06-29T00:37:57.000000Z","updated_at":"2020-06-29T00:37:57.000000Z"},{"id":42,"name":"mechanic","description":"mechanic","keywords":"mechanic","icon":null,"parent_id":12,"image_id":154,"deleted_at":null,"created_at":"2020-06-29T23:22:06.000000Z","updated_at":"2020-06-29T23:22:06.000000Z"},{"id":61,"name":"Events Planner","description":"Rosa is a weddings & events planning company. Our decoration makes any simple location looks magical. We work both indoors & outdoors all over Egypt.","keywords":"Rosa is a weddings & events planning company","icon":null,"parent_id":12,"image_id":872,"deleted_at":null,"created_at":"2020-08-22T14:16:16.000000Z","updated_at":"2020-08-22T14:16:16.000000Z"},{"id":166,"name":"Hairdressers","description":"Hairdressers","keywords":"Hairdressers","icon":null,"parent_id":12,"image_id":1572,"deleted_at":null,"created_at":"2020-09-13T09:57:50.000000Z","updated_at":"2020-09-13T09:57:50.000000Z"},{"id":180,"name":"Upholsterers","description":"Upholsterers","keywords":"Upholsterers","icon":null,"parent_id":12,"image_id":1639,"deleted_at":null,"created_at":"2020-09-13T11:24:10.000000Z","updated_at":"2020-09-13T11:24:10.000000Z"},{"id":193,"name":"electrician","description":"electrician","keywords":"electrician","icon":null,"parent_id":12,"image_id":1695,"deleted_at":null,"created_at":"2020-09-14T12:16:36.000000Z","updated_at":"2020-09-14T12:16:36.000000Z"},{"id":194,"name":"blacksmith","description":"blacksmith","keywords":"blacksmith","icon":null,"parent_id":12,"image_id":1697,"deleted_at":null,"created_at":"2020-09-14T12:32:48.000000Z","updated_at":"2020-09-14T12:32:48.000000Z"},{"id":195,"name":"Dressmaker","description":"Dressmaker","keywords":"Dressmaker","icon":null,"parent_id":12,"image_id":1697,"deleted_at":null,"created_at":"2020-09-14T12:41:57.000000Z","updated_at":"2020-09-14T12:41:57.000000Z"},{"id":196,"name":"Painter","description":"Painter","keywords":"Painter","icon":null,"parent_id":12,"image_id":1701,"deleted_at":null,"created_at":"2020-09-14T12:48:21.000000Z","updated_at":"2020-09-14T12:48:21.000000Z"}],"CategoryTechnicians":[{"id":35,"name":"Carpenter","description":"Carpenter","keywords":"carpenter","icon":null,"parent_id":12,"image_id":94,"deleted_at":null,"created_at":"2020-06-29T00:32:09.000000Z","updated_at":"2020-06-29T00:32:09.000000Z","technicians":[{"id":19,"user_id":19,"image_id":1414,"category_id":35,"commercial_name":"ahmed ali","short_description":"dd","description":"ddddddddd","city":null,"governorate":null,"country":64,"total_reviews":3,"total_rates":3,"created_at":"2020-09-12 11:14:24","updated_at":"2020-09-28 10:18:35","deleted_at":null,"category":"Carpenter","first_name":"ahmed","last_name":"ali","username":"ahmed ali","phone":"01066966515","verification_code":"168909","api_token":"8bca70e6d8bc31e3e79f6ee2efe293bf","phone_verified_at":null,"type":"technician","chanel":"web","image_url":"https://images.phinex.net/storage/app/public/images/2020-09/12-Sat/ahmed_ali2020-09-12-11:14:24.png"}]},{"id":36,"name":"Plumber","description":"Plumber","keywords":"Plumber","icon":null,"parent_id":12,"image_id":96,"deleted_at":null,"created_at":"2020-06-29T00:37:57.000000Z","updated_at":"2020-06-29T00:37:57.000000Z","technicians":[]},{"id":195,"name":"Dressmaker","description":"Dressmaker","keywords":"Dressmaker","icon":null,"parent_id":12,"image_id":1697,"deleted_at":null,"created_at":"2020-09-14T12:41:57.000000Z","updated_at":"2020-09-14T12:41:57.000000Z","technicians":[]},{"id":42,"name":"mechanic","description":"mechanic","keywords":"mechanic","icon":null,"parent_id":12,"image_id":154,"deleted_at":null,"created_at":"2020-06-29T23:22:06.000000Z","updated_at":"2020-06-29T23:22:06.000000Z","technicians":[]},{"id":193,"name":"electrician","description":"electrician","keywords":"electrician","icon":null,"parent_id":12,"image_id":1695,"deleted_at":null,"created_at":"2020-09-14T12:16:36.000000Z","updated_at":"2020-09-14T12:16:36.000000Z","technicians":[]}]}
/// message : null
/// code : 200

class ProfessionsLandingResponse {
  DataBean data;
  dynamic message;
  int code;

  static ProfessionsLandingResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProfessionsLandingResponse professionsLandingResponseBean = ProfessionsLandingResponse();
    professionsLandingResponseBean.data = DataBean.fromMap(map['data']);
    professionsLandingResponseBean.message = map['message'];
    professionsLandingResponseBean.code = map['code'];
    return professionsLandingResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  List<CategoriesBean> categories;
  List<CategoryTechniciansBean> CategoryTechnicians;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.categories = List()..addAll(
      (map['categories'] as List ?? []).map((o) => CategoriesBean.fromMap(o))
    );
    dataBean.CategoryTechnicians = List()..addAll(
      (map['CategoryTechnicians'] as List ?? []).map((o) => CategoryTechniciansBean.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "categories": categories,
    "CategoryTechnicians": CategoryTechnicians,
  };
}


class CategoryTechniciansBean {
  int id;
  String name;
  String description;
  String keywords;
  dynamic icon;
  dynamic parentId;
  dynamic imageId;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  List<ProfessionBean> technicians;

  static CategoryTechniciansBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CategoryTechniciansBean categoryTechniciansBean = CategoryTechniciansBean();
    categoryTechniciansBean.id = map['id'];
    categoryTechniciansBean.name = map['name'];
    categoryTechniciansBean.description = map['description'];
    categoryTechniciansBean.keywords = map['keywords'];
    categoryTechniciansBean.icon = map['icon'];
    categoryTechniciansBean.parentId = map['parent_id'];
    categoryTechniciansBean.imageId = map['image_id'];
    categoryTechniciansBean.deletedAt = map['deleted_at'];
    categoryTechniciansBean.createdAt = map['created_at'];
    categoryTechniciansBean.updatedAt = map['updated_at'];
    categoryTechniciansBean.technicians = List()..addAll(
      (map['technicians'] as List ?? []).map((o) => ProfessionBean.fromMap(o))
    );
    return categoryTechniciansBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "keywords": keywords,
    "icon": icon,
    "parent_id": parentId,
    "image_id": imageId,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "technicians": technicians,
  };
}

// class TechniciansBean {
//   int id;
//   int userId;
//   int imageId;
//   int categoryId;
//   String commercialName;
//   String shortDescription;
//   String description;
//   dynamic city;
//   dynamic governorate;
//   int country;
//   int totalReviews;
//   int totalRates;
//   String createdAt;
//   String updatedAt;
//   dynamic deletedAt;
//   String category;
//   String firstName;
//   String lastName;
//   String username;
//   String phone;
//   String verificationCode;
//   String apiToken;
//   dynamic phoneVerifiedAt;
//   String type;
//   String chanel;
//   String imageUrl;
//
//   static TechniciansBean fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
//     TechniciansBean techniciansBean = TechniciansBean();
//     techniciansBean.id = map['id'];
//     techniciansBean.userId = map['user_id'];
//     techniciansBean.imageId = map['image_id'];
//     techniciansBean.categoryId = map['category_id'];
//     techniciansBean.commercialName = map['commercial_name'];
//     techniciansBean.shortDescription = map['short_description'];
//     techniciansBean.description = map['description'];
//     techniciansBean.city = map['city'];
//     techniciansBean.governorate = map['governorate'];
//     techniciansBean.country = map['country'];
//     techniciansBean.totalReviews = map['total_reviews'];
//     techniciansBean.totalRates = map['total_rates'];
//     techniciansBean.createdAt = map['created_at'];
//     techniciansBean.updatedAt = map['updated_at'];
//     techniciansBean.deletedAt = map['deleted_at'];
//     techniciansBean.category = map['category'];
//     techniciansBean.firstName = map['first_name'];
//     techniciansBean.lastName = map['last_name'];
//     techniciansBean.username = map['username'];
//     techniciansBean.phone = map['phone'];
//     techniciansBean.verificationCode = map['verification_code'];
//     techniciansBean.apiToken = map['api_token'];
//     techniciansBean.phoneVerifiedAt = map['phone_verified_at'];
//     techniciansBean.type = map['type'];
//     techniciansBean.chanel = map['chanel'];
//     techniciansBean.imageUrl = map['image_url'];
//     return techniciansBean;
//   }
//
//   Map toJson() => {
//     "id": id,
//     "user_id": userId,
//     "image_id": imageId,
//     "category_id": categoryId,
//     "commercial_name": commercialName,
//     "short_description": shortDescription,
//     "description": description,
//     "city": city,
//     "governorate": governorate,
//     "country": country,
//     "total_reviews": totalReviews,
//     "total_rates": totalRates,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//     "deleted_at": deletedAt,
//     "category": category,
//     "first_name": firstName,
//     "last_name": lastName,
//     "username": username,
//     "phone": phone,
//     "verification_code": verificationCode,
//     "api_token": apiToken,
//     "phone_verified_at": phoneVerifiedAt,
//     "type": type,
//     "chanel": chanel,
//     "image_url": imageUrl,
//   };
// }


class CategoriesBean {
  int id;
  String name;
  String description;
  String keywords;
  dynamic icon;
  dynamic parentId;
  dynamic imageId;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;

  static CategoriesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CategoriesBean categoriesBean = CategoriesBean();
    categoriesBean.id = map['id'];
    categoriesBean.name = map['name'];
    categoriesBean.description = map['description'];
    categoriesBean.keywords = map['keywords'];
    categoriesBean.icon = map['icon'];
    categoriesBean.parentId = map['parent_id'];
    categoriesBean.imageId = map['image_id'];
    categoriesBean.deletedAt = map['deleted_at'];
    categoriesBean.createdAt = map['created_at'];
    categoriesBean.updatedAt = map['updated_at'];
    return categoriesBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "keywords": keywords,
    "icon": icon,
    "parent_id": parentId,
    "image_id": imageId,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}