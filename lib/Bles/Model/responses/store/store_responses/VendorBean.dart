class VendorBean {
  int id;
  String commercialName;
  int vendorId;
  String imageId;
  int categoryId;
  int accountManagerId;
  String description;
  String contactPerson;
  String contactNumber;
  dynamic email;
  String country;
  int governorate;
  String city;
  String address;
  double addressLatitude;
  double addressLongitude;
  int workingHours;
  String openFromTime;
  String openToTime;
  String openFromDay;
  String openToDay;
  String hotline;
  int totalRates;
  int totalReviews;
  String deliveryStatus;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;

  static VendorBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    VendorBean vendorBean = VendorBean();
    vendorBean.id = map['id'];
    vendorBean.commercialName = map['commercial_name'];
    vendorBean.vendorId = map['vendor_id'];
    vendorBean.imageId = map['image_id'];
    vendorBean.categoryId = map['category_id'];
    vendorBean.accountManagerId = map['account_manager_id'];
    vendorBean.description = map['description'];
    vendorBean.contactPerson = map['contact_person'];
    vendorBean.contactNumber = map['contact_number'];
    vendorBean.email = map['email'];
    vendorBean.country = map['country'];
    vendorBean.governorate = map['governorate'];
    vendorBean.city = map['city'];
    vendorBean.address = map['address'];
    vendorBean.addressLatitude = map['address_latitude'];
    vendorBean.addressLongitude = map['address_longitude'];
    vendorBean.workingHours = map['working_hours'];
    vendorBean.openFromTime = map['open_from_time'];
    vendorBean.openToTime = map['open_to_time'];
    vendorBean.openFromDay = map['open_from_day'];
    vendorBean.openToDay = map['open_to_day'];
    vendorBean.hotline = map['hotline'];
    vendorBean.totalRates = map['total_rates'];
    vendorBean.totalReviews = map['total_reviews'];
    vendorBean.deliveryStatus = map['delivery_status'];
    vendorBean.deletedAt = map['deleted_at'];
    vendorBean.createdAt = map['created_at'];
    vendorBean.updatedAt = map['updated_at'];
    return vendorBean;
  }

  Map toJson() => {
    "id": id,
    "commercial_name": commercialName,
    "vendor_id": vendorId,
    "image_id": imageId,
    "category_id": categoryId,
    "account_manager_id": accountManagerId,
    "description": description,
    "contact_person": contactPerson,
    "contact_number": contactNumber,
    "email": email,
    "country": country,
    "governorate": governorate,
    "city": city,
    "address": address,
    "address_latitude": addressLatitude,
    "address_longitude": addressLongitude,
    "working_hours": workingHours,
    "open_from_time": openFromTime,
    "open_to_time": openToTime,
    "open_from_day": openFromDay,
    "open_to_day": openToDay,
    "hotline": hotline,
    "total_rates": totalRates,
    "total_reviews": totalReviews,
    "delivery_status": deliveryStatus,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}