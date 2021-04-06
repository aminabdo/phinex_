
class RealStateSingleResponse {
  RealestatesBean data;
  dynamic message;
  int code;

  static RealStateSingleResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RealStateSingleResponse realStateSingleResponseBean = RealStateSingleResponse();
    realStateSingleResponseBean.data = RealestatesBean.fromMap(map['data']);
    realStateSingleResponseBean.message = map['message'];
    realStateSingleResponseBean.code = map['code'];
    return realStateSingleResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
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
  String realstateCategory;
  String propertyImage;
  List<String> gallery;
  DeveloperBean developer;

  static RealestatesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RealestatesBean dataBean = RealestatesBean();
    dataBean.id = map['id'];
    dataBean.sellerId = map['seller_id'];
    dataBean.country = map['country'];
    dataBean.governorate = map['governorate'];
    dataBean.city = map['city'];
    dataBean.estateType = map['estate_type'];
    dataBean.estateFurnishing = map['estate_furnishing'];
    dataBean.estateFinishing = map['estate_finishing'];
    dataBean.categoryId = map['category_id'];
    dataBean.propertyTitle = map['property_title'];
    dataBean.price = map['price'];
    dataBean.address = map['address'];
    dataBean.long = map['long'];
    dataBean.lat = map['lat'];
    dataBean.phone = map['phone'];
    dataBean.description = map['description'];
    dataBean.imageId = map['image_id'];
    dataBean.floorSpace = map['floor_space'];
    dataBean.numberOfBalconies = map['number_of_balconies'];
    dataBean.numberOfBedrooms = map['number_of_bedrooms'];
    dataBean.numberOfBathrooms = map['number_of_Bathrooms'];
    dataBean.reference = map['reference'];
    dataBean.builtAt = map['built_at'];
    dataBean.paymentMethods = map['payment_methods'];
    dataBean.hasKitchenAppliances = map['has_kitchen_appliances'];
    dataBean.hasConcierge = map['has_concierge'];
    dataBean.hasBuiltInWardrobes = map['has_built_in_wardrobes'];
    dataBean.petsAllowed = map['pets_allowed'];
    dataBean.hasView = map['has_view'];
    dataBean.hasGarden = map['has_garden'];
    dataBean.hasBbqArea = map['has_bbq_area'];
    dataBean.hasChildrenPlayArea = map['has_children_play_area'];
    dataBean.hasPool = map['has_pool'];
    dataBean.hasMaidService = map['has_maid_service'];
    dataBean.hasSecurity = map['has_security'];
    dataBean.hasCoverdParking = map['has_coverd_parking'];
    dataBean.featured = map['featured'];
    dataBean.unit = map['unit'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.realstateCategory = map['realstate_category'];
    dataBean.propertyImage = map['property_image'];
    dataBean.gallery = List()..addAll(
      (map['gallery'] as List ?? []).map((o) => o.toString())
    );
    dataBean.developer = DeveloperBean.fromMap(map['developer']);
    return dataBean;
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
    "realstate_category": realstateCategory,
    "property_image": propertyImage,
    "gallery": gallery,
    "developer": developer,
  };
}

class DeveloperBean {
  int id;
  String commercialName;
  int developerId;
  dynamic accountManagerId;
  String description;
  String contactPerson;
  String contactNumber;
  String email;
  dynamic website;
  int country;
  int governorate;
  int city;
  String address;
  dynamic addressLatitude;
  dynamic addressLongitude;
  dynamic workingHours;
  int imageId;
  dynamic openFromTime;
  dynamic openToTime;
  dynamic openFromDay;
  dynamic openToDay;
  String hotline;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  String developerImage;

  static DeveloperBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DeveloperBean developerBean = DeveloperBean();
    developerBean.id = map['id'];
    developerBean.commercialName = map['commercial_name'];
    developerBean.developerId = map['developer_id'];
    developerBean.accountManagerId = map['account_manager_id'];
    developerBean.description = map['description'];
    developerBean.contactPerson = map['contact_person'];
    developerBean.contactNumber = map['contact_number'];
    developerBean.email = map['email'];
    developerBean.website = map['website'];
    developerBean.country = map['country'];
    developerBean.governorate = map['governorate'];
    developerBean.city = map['city'];
    developerBean.address = map['address'];
    developerBean.addressLatitude = map['address_latitude'];
    developerBean.addressLongitude = map['address_longitude'];
    developerBean.workingHours = map['working_hours'];
    developerBean.imageId = map['image_id'];
    developerBean.openFromTime = map['open_from_time'];
    developerBean.openToTime = map['open_to_time'];
    developerBean.openFromDay = map['open_from_day'];
    developerBean.openToDay = map['open_to_day'];
    developerBean.hotline = map['hotline'];
    developerBean.deletedAt = map['deleted_at'];
    developerBean.createdAt = map['created_at'];
    developerBean.updatedAt = map['updated_at'];
    developerBean.developerImage = map['developer_image'];
    return developerBean;
  }

  Map toJson() => {
    "id": id,
    "commercial_name": commercialName,
    "developer_id": developerId,
    "account_manager_id": accountManagerId,
    "description": description,
    "contact_person": contactPerson,
    "contact_number": contactNumber,
    "email": email,
    "website": website,
    "country": country,
    "governorate": governorate,
    "city": city,
    "address": address,
    "address_latitude": addressLatitude,
    "address_longitude": addressLongitude,
    "working_hours": workingHours,
    "image_id": imageId,
    "open_from_time": openFromTime,
    "open_to_time": openToTime,
    "open_from_day": openFromDay,
    "open_to_day": openToDay,
    "hotline": hotline,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "developer_image": developerImage,
  };
}