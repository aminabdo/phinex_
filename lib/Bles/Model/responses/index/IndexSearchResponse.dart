/// data : [{"id":3,"category_id":80,"title":"mammado textile","description":"nasee\n","business_activity":"Naseej","business_description":null,"country":64,"governorate":1048,"city":15420,"address":"address1","long":null,"lat":null,"email":"m@textile.com","phone":"01122215543","image_id":1714,"website":"http://www.tetxile.com","total_rates":0,"total_reviews":0,"created_at":"2020-09-15 17:29:31","updated_at":"2020-10-28 13:59:06","deleted_at":null,"image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/15-Tue/mammado_textile.jpeg"}]
/// message : null
/// code : 200

class IndexSearchResponse {
  IndexSearchData data;
  dynamic message;
  int code;

  static IndexSearchResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    IndexSearchResponse indexSearchResponseBean = IndexSearchResponse();
    indexSearchResponseBean.data = IndexSearchData.fromMap(map['data']);
    indexSearchResponseBean.message = map['message'];
    indexSearchResponseBean.code = map['code'];
    return indexSearchResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class IndexSearchData {
  List<IndexSearchResult> results;
  int total;

  IndexSearchData({this.results, this.total});

  static IndexSearchData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    IndexSearchData searchResult = IndexSearchData();
    searchResult.results = List()..addAll((map['results'] as List ?? []).map((o) => IndexSearchResult.fromMap(o)));
    searchResult.total = map['total'];
    return searchResult;
  }
}

class IndexSearchResult {
  dynamic id;
  dynamic categoryId;
  String title;
  String description;
  String businessActivity;
  dynamic businessDescription;
  dynamic country;
  dynamic governorate;
  dynamic city;
  String address;
  dynamic long;
  dynamic lat;
  String email;
  String phone;
  dynamic imageId;
  String website;
  dynamic totalRates;
  dynamic totalReviews;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  String imageUrl;

  static IndexSearchResult fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    IndexSearchResult dataBean = IndexSearchResult();
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
    dataBean.totalReviews = map['total_reviews'];
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