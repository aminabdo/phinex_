class JobCategory {
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
  String imageUrl;

  static JobCategory fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    JobCategory dataBean = JobCategory();
    dataBean.id = map['id'];
    dataBean.name = map['name'];
    dataBean.description = map['description'];
    dataBean.keywords = map['keywords'];
    dataBean.icon = map['icon'];
    dataBean.parentId = map['parent_id'];
    dataBean.imageId = map['image_id'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.imageUrl = map['image_url'];
    return dataBean;
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
    "image_url": imageUrl,
  };
}


class Jobs {
  int id;
  String email;
  String mobile;
  dynamic countryId;
  dynamic governorateId;
  dynamic cityId;
  dynamic categoryId;
  dynamic recruiterId;
  String type;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String about;
  String title;
  String description;
  String requirements;
  String address;
  Recruiter recruiter;
  JobImage image;

  Jobs(
      {this.id,
      this.email,
      this.mobile,
      this.countryId,
      this.governorateId,
      this.cityId,
      this.categoryId,
      this.recruiterId,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.about,
      this.title,
      this.description,
      this.requirements,
      this.address,
      this.recruiter,
      this.image});

  static Jobs fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Jobs dataBean = Jobs();
    dataBean.id = map['id'];
    dataBean.email = map['email'];
    dataBean.mobile = map['mobile'];
    dataBean.countryId = map['country_id'];
    dataBean.governorateId = map['governorate_id'];
    dataBean.cityId = map['city_id'];
    dataBean.categoryId = map['category_id'];
    dataBean.recruiterId = map['recruiter_id'];
    dataBean.type = map['type'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.about = map['about'];
    dataBean.title = map['title'];
    dataBean.address = map['address'];
    dataBean.description = map['description'];
    dataBean.requirements = map['requirements'];
    dataBean.recruiter = Recruiter.fromMap(map['recruiter']);
    dataBean.image = JobImage.fromMap(map['image']);
    return dataBean;
  }

  Map toJson() => {
    "id": id,
    "email": email,
    "mobile": mobile,
    "country_id": countryId,
    "governorate_id": governorateId,
    "city_id": cityId,
    "category_id": categoryId,
    "recruiter_id": recruiterId,
    "type": type,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "about": about,
    "title": title,
    "description": description,
    "requirements": requirements,
    "recruiter": recruiter,
    "address": address,
    "image": image,
  };
}


class Recruiter {
  int userId;
  dynamic imageId;
  dynamic email;
  String country;
  String governorate;
  String city;
  String address;
  dynamic addressLatitude;
  dynamic addressLongitude;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  dynamic coverImageId;
  dynamic education;
  dynamic jobTitle;
  dynamic description;

  static Recruiter fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Recruiter recruiterBean = Recruiter();
    recruiterBean.userId = map['user_id'];
    recruiterBean.imageId = map['image_id'];
    recruiterBean.email = map['email'];
    recruiterBean.country = map['country'];
    recruiterBean.governorate = map['governorate'];
    recruiterBean.city = map['city'];
    recruiterBean.address = map['address'];
    recruiterBean.addressLatitude = map['address_latitude'];
    recruiterBean.addressLongitude = map['address_longitude'];
    recruiterBean.deletedAt = map['deleted_at'];
    recruiterBean.createdAt = map['created_at'];
    recruiterBean.updatedAt = map['updated_at'];
    recruiterBean.coverImageId = map['cover_image_id'];
    recruiterBean.education = map['education'];
    recruiterBean.jobTitle = map['job_title'];
    recruiterBean.description = map['description'];
    return recruiterBean;
  }

  Map toJson() => {
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
    "cover_image_id": coverImageId,
    "education": education,
    "job_title": jobTitle,
    "description": description,
  };
}

class JobImage {
  dynamic id;
  String imageUrl;


  JobImage({this.id, this.imageUrl});

  static JobImage fromMap(Map<String, dynamic> map) {
    JobImage image = JobImage();
    if (map == null) return null;
    image.id = map['id'];
    image.imageUrl = map['image_url'];

    return image;
  }

  Map toJson() => {
    "id": this.id,
    'image_url': this.imageUrl,
  };
}