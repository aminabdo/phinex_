
import 'package:phinex/utils/base/BaseResponse.dart';

class TechReservationsModel extends BaseResponse {
  List<Data> data;

  TechReservationsModel({this.data});

  TechReservationsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  String datetime;
  dynamic userId;
  dynamic technicianId;
  dynamic workshopId;
  dynamic notes;
  dynamic queueNumber;
  dynamic status;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  List<Workshop> workshop;
  List<Technician> technician;

  Data(
      {this.id,
        this.datetime,
        this.userId,
        this.technicianId,
        this.workshopId,
        this.notes,
        this.queueNumber,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.workshop,
        this.technician,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    datetime = json['datetime'];
    userId = json['user_id'];
    technicianId = json['technician_id'];
    workshopId = json['workshop_id'];
    notes = json['notes'];
    queueNumber = json['queue_number'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['workshop'] != dynamic) {
      workshop = new List<Workshop>();
      json['workshop'].forEach((v) {
        workshop.add(new Workshop.fromJson(v));
      });
    }
    if (json['technician'] != dynamic) {
      technician = new List<Technician>();
      json['technician'].forEach((v) {
        technician.add(new Technician.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['datetime'] = this.datetime;
    data['user_id'] = this.userId;
    data['technician_id'] = this.technicianId;
    data['workshop_id'] = this.workshopId;
    data['notes'] = this.notes;
    data['queue_number'] = this.queueNumber;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.workshop != null) {
      data['workshop'] = this.workshop.map((v) => v.toJson()).toList();
    }
    if (this.technician != null) {
      data['technician'] = this.technician.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Workshop {
  dynamic id;
  String title;
  dynamic technicianId;
  dynamic country;
  dynamic governorate;
  dynamic city;
  String address;
  dynamic long;
  dynamic lat;
  String phone;
  dynamic description;
  String openFrom;
  String openTo;
  dynamic saturday;
  dynamic sunday;
  dynamic monday;
  dynamic tuesday;
  dynamic wednesday;
  dynamic thursday;
  dynamic friday;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  Workshop(
      {this.id,
        this.title,
        this.technicianId,
        this.country,
        this.governorate,
        this.city,
        this.address,
        this.long,
        this.lat,
        this.phone,
        this.description,
        this.openFrom,
        this.openTo,
        this.saturday,
        this.sunday,
        this.monday,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.friday,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
      });

  Workshop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    technicianId = json['technician_id'];
    country = json['country'];
    governorate = json['governorate'];
    city = json['city'];
    address = json['address'];
    long = json['long'];
    lat = json['lat'];
    phone = json['phone'];
    description = json['description'];
    openFrom = json['open_from'];
    openTo = json['open_to'];
    saturday = json['saturday'];
    sunday = json['sunday'];
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thursday = json['thursday'];
    friday = json['friday'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['technician_id'] = this.technicianId;
    data['country'] = this.country;
    data['governorate'] = this.governorate;
    data['city'] = this.city;
    data['address'] = this.address;
    data['long'] = this.long;
    data['lat'] = this.lat;
    data['phone'] = this.phone;
    data['description'] = this.description;
    data['open_from'] = this.openFrom;
    data['open_to'] = this.openTo;
    data['saturday'] = this.saturday;
    data['sunday'] = this.sunday;
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thursday'] = this.thursday;
    data['friday'] = this.friday;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Technician {
  dynamic id;
  dynamic userId;
  dynamic imageId;
  dynamic categoryId;
  String commercialName;
  String shortDescription;
  String description;
  dynamic city;
  dynamic governorate;
  dynamic country;
  dynamic totalReviews;
  dynamic totalRates;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String imageUrl;

  Technician(
      {this.id,
        this.userId,
        this.imageId,
        this.categoryId,
        this.commercialName,
        this.shortDescription,
        this.description,
        this.city,
        this.governorate,
        this.country,
        this.totalReviews,
        this.totalRates,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.imageUrl,
      });

  Technician.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    imageId = json['image_id'];
    categoryId = json['category_id'];
    commercialName = json['commercial_name'];
    shortDescription = json['short_description'];
    description = json['description'];
    city = json['city'];
    governorate = json['governorate'];
    country = json['country'];
    totalReviews = json['total_reviews'];
    totalRates = json['total_rates'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['image_id'] = this.imageId;
    data['category_id'] = this.categoryId;
    data['commercial_name'] = this.commercialName;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['city'] = this.city;
    data['governorate'] = this.governorate;
    data['country'] = this.country;
    data['total_reviews'] = this.totalReviews;
    data['total_rates'] = this.totalRates;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
