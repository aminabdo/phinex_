/// data : [{"id":13,"category_id":89,"title":"EXECUTING ON GROWTHR","description":"Led by Ross Beaty as Chair, Equinox Gold has the properties, the people and the plan to achieve its vision of becoming a million-ounce gold producer, and is one of the only gold producers of eoperating entirely in the Americas.","business_activity":"Equinox Gold is a Canadian mining company with seven operating gold mines and a fully-funded plan to increase production by advancing a pipeline of growth projects. The Company is delivering on its growth strategy, advancing from a single-asset developer to a multi-mine producer in just two years, and is rapidly advancing toward its million-ounce vision. ","business_description":null,"country":64,"governorate":663,"city":10105,"address":"Computershare 510 Burrard, 2nd Floor Vancouver, BC V6C 3B9   Canada 1-800-564-6253","long":null,"lat":null,"email":"info@equinoxgold.com","phone":"88877788888","image_id":2770,"website":"https://companyinfo.nl/","total_rates":0,"total_reviews":0,"created_at":"2020-10-28 14:04:26","updated_at":"2020-11-26 09:20:15","deleted_at":null,"image_url":"https://images.tbdm.net/storage/app/public/images/2020-10/28-Wed/executing_on_growth.png"}]
/// message : null
/// code : 200

class IndexByCatResponse {
  List<DataBean> data;
  String message;
  int code;

  static IndexByCatResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    IndexByCatResponse indexByCatResponseBean = IndexByCatResponse();
    indexByCatResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => DataBean.fromMap(o))
    );
    indexByCatResponseBean.message = map['message'];
    indexByCatResponseBean.code = map['code'];
    return indexByCatResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

/// id : 13
/// category_id : 89
/// title : "EXECUTING ON GROWTHR"
/// description : "Led by Ross Beaty as Chair, Equinox Gold has the properties, the people and the plan to achieve its vision of becoming a million-ounce gold producer, and is one of the only gold producers of eoperating entirely in the Americas."
/// business_activity : "Equinox Gold is a Canadian mining company with seven operating gold mines and a fully-funded plan to increase production by advancing a pipeline of growth projects. The Company is delivering on its growth strategy, advancing from a single-asset developer to a multi-mine producer in just two years, and is rapidly advancing toward its million-ounce vision. "
/// business_description : null
/// country : 64
/// governorate : 663
/// city : 10105
/// address : "Computershare 510 Burrard, 2nd Floor Vancouver, BC V6C 3B9   Canada 1-800-564-6253"
/// long : null
/// lat : null
/// email : "info@equinoxgold.com"
/// phone : "88877788888"
/// image_id : 2770
/// website : "https://companyinfo.nl/"
/// total_rates : 0
/// total_reviews : 0
/// created_at : "2020-10-28 14:04:26"
/// updated_at : "2020-11-26 09:20:15"
/// deleted_at : null
/// image_url : "https://images.tbdm.net/storage/app/public/images/2020-10/28-Wed/executing_on_growth.png"

class DataBean {
  int id;
  int categoryId;
  String title;
  String description;
  String businessActivity;
  String businessDescription;
  int country;
  int governorate;
  int city;
  String address;
  dynamic long;
  dynamic lat;
  String email;
  String phone;
  num imageId;
  String website;
  num totalRates;
  num totalReviews;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String imageUrl;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.id = map['id'];
    dataBean.categoryId = map['category_id'];
    dataBean.title = map['title'];
    dataBean.description = map['description'];
    dataBean.businessActivity = map['business_activity'];
    dataBean.businessDescription = map['business_description'];
    dataBean.country = map['country'];
    dataBean.governorate = map['governorate'];
    dataBean.city = map['city'];
    dataBean.address = map['address'];
    dataBean.long = map['long'];
    dataBean.lat = map['lat'];
    dataBean.email = map['email'];
    dataBean.phone = map['phone'];
    dataBean.imageId = map['image_id'];
    dataBean.website = map['website'];
    dataBean.totalRates = map['total_rates'];
    dataBean.totalReviews = num.parse(map['total_reviews'].toString());
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.imageUrl = map['image_url'];
    return dataBean;
  }

  Map toJson() => {
    "id": id,
    "category_id": categoryId,
    "title": title,
    "description": description,
    "business_activity": businessActivity,
    "business_description": businessDescription,
    "country": country,
    "governorate": governorate,
    "city": city,
    "address": address,
    "long": long,
    "lat": lat,
    "email": email,
    "phone": phone,
    "image_id": imageId,
    "website": website,
    "total_rates": totalRates,
    "total_reviews": totalReviews,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "image_url": imageUrl,
  };
}