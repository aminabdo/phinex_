class DetailsBean {
  int id;
  String commercialName;
  dynamic vendorId;
  dynamic imageId;
  dynamic categoryId;
  dynamic accountManagerId;
  String description;
  String contactPerson;
  String contactNumber;
  dynamic email;
  dynamic country;
  dynamic governorate;
  dynamic city;
  String address;
  double addressLatitude;
  double addressLongitude;
  int workingHours;
  String openFromTime;
  String openToTime;
  String openFromDay;
  String openToDay;
  String hotline;
  dynamic totalRates;
  dynamic totalReviews;
  String deliveryStatus;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  String imageUrl;
  String category;

  static DetailsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DetailsBean detailsBean = DetailsBean();
    detailsBean.id = map['id'];
    detailsBean.commercialName = map['commercial_name'];
    detailsBean.vendorId = map['vendor_id'];
    detailsBean.imageId = map['image_id'];
    detailsBean.categoryId = map['category_id'];
    detailsBean.accountManagerId = map['account_manager_id'];
    detailsBean.description = map['description'];
    detailsBean.contactPerson = map['contact_person'];
    detailsBean.contactNumber = map['contact_number'];
    detailsBean.email = map['email'];
    detailsBean.country = map['country'];
    detailsBean.governorate = map['governorate'];
    detailsBean.city = map['city'];
    detailsBean.address = map['address'];
    detailsBean.addressLatitude = map['address_latitude'];
    detailsBean.addressLongitude = map['address_longitude'];
    detailsBean.workingHours = map['working_hours'];
    detailsBean.openFromTime = map['open_from_time'];
    detailsBean.openToTime = map['open_to_time'];
    detailsBean.openFromDay = map['open_from_day'];
    detailsBean.openToDay = map['open_to_day'];
    detailsBean.hotline = map['hotline'];
    detailsBean.totalRates = map['total_rates'];
    detailsBean.totalReviews = map['total_reviews'];
    detailsBean.deliveryStatus = map['delivery_status'];
    detailsBean.deletedAt = map['deleted_at'];
    detailsBean.createdAt = map['created_at'];
    detailsBean.updatedAt = map['updated_at'];
    detailsBean.imageUrl = map['image_url'];
    detailsBean.category = map['category'];
    return detailsBean;
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
    "image_url": imageUrl,
    "category": category,
  };
}