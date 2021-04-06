class RealStateFilterResponse {
  DataBean data;
  dynamic message;
  int code;

  static RealStateFilterResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RealStateFilterResponse realStateFilterResponseBean = RealStateFilterResponse();
    realStateFilterResponseBean.data = DataBean.fromMap(map['data']);
    realStateFilterResponseBean.message = map['message'];
    realStateFilterResponseBean.code = map['code'];
    return realStateFilterResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  List<CategoriesBean> categories;
  List<RealestatesBean> realestates;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.categories = List()..addAll(
      (map['categories'] as List ?? []).map((o) => CategoriesBean.fromMap(o))
    );
    dataBean.realestates = List()..addAll(
      (map['realestates'] as List ?? []).map((o) => RealestatesBean.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "categories": categories,
    "realestates": realestates,
  };
}

class RealestatesBean {
  int id;
  int sellerId;
  int country;
  int governorate;
  int city;
  String estateType;
  String estateFurnishing;
  String estateFinishing;
  int categoryId;
  String propertyTitle;
  String price;
  String address;
  dynamic long;
  dynamic lat;
  int phone;
  String description;
  String imageId;
  int floorSpace;
  int numberOfBalconies;
  int numberOfBedrooms;
  int numberOfBathrooms;
  int reference;
  int builtAt;
  String paymentMethods;
  int hasKitchenAppliances;
  int hasConcierge;
  int hasBuiltInWardrobes;
  int petsAllowed;
  int hasView;
  int hasGarden;
  int hasBbqArea;
  int hasChildrenPlayArea;
  int hasPool;
  int hasMaidService;
  int hasSecurity;
  int hasCoverdParking;
  int featured;
  String unit;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  List<String> gallary;
  String propertyImage;

  static RealestatesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RealestatesBean realestatesBean = RealestatesBean();
    realestatesBean.id = map['id'];
    realestatesBean.sellerId = map['seller_id'];
    realestatesBean.country = map['country'];
    realestatesBean.governorate = map['governorate'];
    realestatesBean.city = map['city'];
    realestatesBean.estateType = map['estate_type'];
    realestatesBean.estateFurnishing = map['estate_furnishing'];
    realestatesBean.estateFinishing = map['estate_finishing'];
    realestatesBean.categoryId = map['category_id'];
    realestatesBean.propertyTitle = map['property_title'];
    realestatesBean.price = map['price'];
    realestatesBean.address = map['address'];
    realestatesBean.long = map['long'];
    realestatesBean.lat = map['lat'];
    realestatesBean.phone = map['phone'];
    realestatesBean.description = map['description'];
    realestatesBean.imageId = map['image_id'];
    realestatesBean.floorSpace = map['floor_space'];
    realestatesBean.numberOfBalconies = map['number_of_balconies'];
    realestatesBean.numberOfBedrooms = map['number_of_bedrooms'];
    realestatesBean.numberOfBathrooms = map['number_of_Bathrooms'];
    realestatesBean.reference = map['reference'];
    realestatesBean.builtAt = map['built_at'];
    realestatesBean.paymentMethods = map['payment_methods'];
    realestatesBean.hasKitchenAppliances = map['has_kitchen_appliances'];
    realestatesBean.hasConcierge = map['has_concierge'];
    realestatesBean.hasBuiltInWardrobes = map['has_built_in_wardrobes'];
    realestatesBean.petsAllowed = map['pets_allowed'];
    realestatesBean.hasView = map['has_view'];
    realestatesBean.hasGarden = map['has_garden'];
    realestatesBean.hasBbqArea = map['has_bbq_area'];
    realestatesBean.hasChildrenPlayArea = map['has_children_play_area'];
    realestatesBean.hasPool = map['has_pool'];
    realestatesBean.hasMaidService = map['has_maid_service'];
    realestatesBean.hasSecurity = map['has_security'];
    realestatesBean.hasCoverdParking = map['has_coverd_parking'];
    realestatesBean.featured = map['featured'];
    realestatesBean.unit = map['unit'];
    realestatesBean.createdAt = map['created_at'];
    realestatesBean.updatedAt = map['updated_at'];
    realestatesBean.deletedAt = map['deleted_at'];
    realestatesBean.gallary = List()..addAll(
      (map['gallary'] as List ?? []).map((o) => o.toString())
    );
    realestatesBean.propertyImage = map['property_image'];
    return realestatesBean;
  }

  Map toJson() => {
    "id": id,
    "seller_id": sellerId,
    "country": country,
    "governorate": governorate,
    "city": city,
    "estate_type": estateType,
    "estate_furnishing": estateFurnishing,
    "estate_finishing": estateFinishing,
    "category_id": categoryId,
    "property_title": propertyTitle,
    "price": price,
    "address": address,
    "long": long,
    "lat": lat,
    "phone": phone,
    "description": description,
    "image_id": imageId,
    "floor_space": floorSpace,
    "number_of_balconies": numberOfBalconies,
    "number_of_bedrooms": numberOfBedrooms,
    "number_of_Bathrooms": numberOfBathrooms,
    "reference": reference,
    "built_at": builtAt,
    "payment_methods": paymentMethods,
    "has_kitchen_appliances": hasKitchenAppliances,
    "has_concierge": hasConcierge,
    "has_built_in_wardrobes": hasBuiltInWardrobes,
    "pets_allowed": petsAllowed,
    "has_view": hasView,
    "has_garden": hasGarden,
    "has_bbq_area": hasBbqArea,
    "has_children_play_area": hasChildrenPlayArea,
    "has_pool": hasPool,
    "has_maid_service": hasMaidService,
    "has_security": hasSecurity,
    "has_coverd_parking": hasCoverdParking,
    "featured": featured,
    "unit": unit,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "gallary": gallary,
    "property_image": propertyImage,
  };
}

class CategoriesBean {
  int id;
  String name;
  String description;
  String keywords;
  dynamic icon;
  int parentId;
  int imageId;
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