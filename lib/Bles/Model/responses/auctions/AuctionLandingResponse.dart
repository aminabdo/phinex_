class AuctionLandingResponse {
  List<AuctionsCat> data;
  dynamic message;
  int code;

  static AuctionLandingResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AuctionLandingResponse auctionLandingResponseBean = AuctionLandingResponse();
    auctionLandingResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => AuctionsCat.fromMap(o))
    );
    auctionLandingResponseBean.message = map['message'];
    auctionLandingResponseBean.code = map['code'];
    return auctionLandingResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class AuctionsCat {
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
  String imageUrl;

  static AuctionsCat fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AuctionsCat dataBean = AuctionsCat();
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


class Auction {
  int id;
  String title;
  int sellerId;
  dynamic reference;
  dynamic videoId;
  int imageId;
  int categoryId;
  String description;
  String opensFrom;
  String endsAt;
  num incrementValue;
  num openPrice;
  String status;
  dynamic totalPaids;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String mainImage;
  List<String> gallary;
  List<AuctioneeBean> auctionee;
  List<MakeDealBean> makeDeal;
  WinedUser winedUser;
  SellerBean seller;
  String imageUrl;
  
  
  static Auction fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Auction dataBean = Auction();
    dataBean.id = map['id'];
    dataBean.title = map['title'];
    dataBean.sellerId = map['seller_id'];
    dataBean.reference = map['reference'];
    dataBean.videoId = map['video_id'];
    dataBean.imageId = map['image_id'];
    dataBean.categoryId = map['category_id'];
    dataBean.description = map['description'];
    dataBean.opensFrom = map['opens_from'];
    dataBean.endsAt = map['ends_at'];
    dataBean.incrementValue = num.parse(map['increment_value'].toString());
    dataBean.openPrice = num.parse(map['open_price'].toString());
    dataBean.status = map['status'];
    dataBean.totalPaids = map['total_paids'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.mainImage = map['main_image'];
    dataBean.imageUrl = map['image_url'];
    dataBean.gallary = List()..addAll(
        (map['gallary'] as List ?? []).map((o) => o.toString())
    );
    dataBean.auctionee = List()..addAll(
        (map['auctionee'] as List ?? []).map((o) => AuctioneeBean.fromMap(o))
    );
    dataBean.makeDeal = List()..addAll(
        (map['makeDeal'] as List ?? []).map((o) => MakeDealBean.fromMap(o))
    );
    dataBean.winedUser = map['winnedUser'] != null ? WinedUser.fromMap(map['winnedUser']) : null;
    dataBean.seller = SellerBean.fromMap(map['seller']);
    return dataBean;
  }

  Map toJson() => {
    "id": id,
    "title": title,
    "seller_id": sellerId,
    "reference": reference,
    "video_id": videoId,
    "image_id": imageId,
    "category_id": categoryId,
    "description": description,
    "opens_from": opensFrom,
    "ends_at": endsAt,
    "increment_value": incrementValue,
    "open_price": openPrice,
    "status": status,
    "total_paids": totalPaids,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "main_image": mainImage,
    "gallary": gallary,
    "auctionee": auctionee,
    "makeDeal": makeDeal,
    "winnedUser": winedUser,
    "seller": seller,
    "image_url": imageUrl,
  };
}

class SellerBean {
  int id;
  String firstName;
  String lastName;
  String username;
  String phone;
  String verificationCode;
  String apiToken;
  String phoneVerifiedAt;
  String type;
  String chanel;
  DetailsBean details;

  static SellerBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SellerBean sellerBean = SellerBean();
    sellerBean.id = map['id'];
    sellerBean.firstName = map['first_name'];
    sellerBean.lastName = map['last_name'];
    sellerBean.username = map['username'];
    sellerBean.phone = map['phone'];
    sellerBean.verificationCode = map['verification_code'];
    sellerBean.apiToken = map['api_token'];
    sellerBean.phoneVerifiedAt = map['phone_verified_at'];
    sellerBean.type = map['type'];
    sellerBean.chanel = map['chanel'];
    sellerBean.details = DetailsBean.fromMap(map['details']);
    return sellerBean;
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
    "details": details,
  };
}

class DetailsBean {
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
  String image;

  static DetailsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DetailsBean detailsBean = DetailsBean();
    detailsBean.userId = map['user_id'];
    detailsBean.imageId = map['image_id'];
    detailsBean.email = map['email'];
    detailsBean.country = map['country'];
    detailsBean.governorate = map['governorate'];
    detailsBean.city = map['city'];
    detailsBean.address = map['address'];
    detailsBean.addressLatitude = map['address_latitude'];
    detailsBean.addressLongitude = map['address_longitude'];
    detailsBean.deletedAt = map['deleted_at'];
    detailsBean.createdAt = map['created_at'];
    detailsBean.updatedAt = map['updated_at'];
    detailsBean.coverImageId = map['cover_image_id'];
    detailsBean.education = map['education'];
    detailsBean.jobTitle = map['job_title'];
    detailsBean.description = map['description'];
    detailsBean.image = map['image'];
    return detailsBean;
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
    "image": image,
  };
}

class MakeDealBean {
  dynamic id;
  dynamic auctionId;
  dynamic price;
  dynamic userId;
  String status;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  UserBean user;

  static MakeDealBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MakeDealBean makeDealBean = MakeDealBean();
    makeDealBean.id = map['id'];
    makeDealBean.auctionId = map['auction_id'];
    makeDealBean.price = map['price'];
    makeDealBean.userId = map['user_id'];
    makeDealBean.status = map['status'];
    makeDealBean.createdAt = map['created_at'];
    makeDealBean.updatedAt = map['updated_at'];
    makeDealBean.deletedAt = map['deleted_at'];
    makeDealBean.user = UserBean.fromMap(map['user']);
    return makeDealBean;
  }

  Map toJson() => {
    "id": id,
    "auction_id": auctionId,
    "price": price,
    "user_id": userId,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "user": user,
  };
}

class AuctioneeBean {
  dynamic id;
  dynamic auctionId;
  dynamic userId;
  dynamic paidPrice;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  UserBean user;

  static AuctioneeBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AuctioneeBean auctioneeBean = AuctioneeBean();
    auctioneeBean.id = map['id'];
    auctioneeBean.auctionId = map['auction_id'];
    auctioneeBean.userId = map['user_id'];
    auctioneeBean.paidPrice = map['paid_price'];
    auctioneeBean.createdAt = map['created_at'];
    auctioneeBean.updatedAt = map['updated_at'];
    auctioneeBean.deletedAt = map['deleted_at'];
    auctioneeBean.user = UserBean.fromMap(map['user']);
    return auctioneeBean;
  }

  Map toJson() => {
    "id": id,
    "auction_id": auctionId,
    "user_id": userId,
    "paid_price": paidPrice,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "user": user,
  };
}

class UserBean {
  dynamic id;
  String firstName;
  String lastName;
  String username;
  String phone;
  String verificationCode;
  String apiToken;
  String phoneVerifiedAt;
  String type;
  String chanel;

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
  };
}

class WinedUser {
  int id;
  int auctionId;
  int price;
  int userId;
  String status;
  String createdAt;
  String updatedAt;
  String deletedAt;
  User user;

  WinedUser(
      {this.id,
        this.auctionId,
        this.price,
        this.userId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.user});

  WinedUser.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    auctionId = json['auction_id'];
    price = json['price'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['auction_id'] = this.auctionId;
    data['price'] = this.price;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
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

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.phone,
        this.verificationCode,
        this.apiToken,
        this.phoneVerifiedAt,
        this.type,
        this.chanel});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    phone = json['phone'];
    verificationCode = json['verification_code'];
    apiToken = json['api_token'];
    phoneVerifiedAt = json['phone_verified_at'];
    type = json['type'];
    chanel = json['chanel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['verification_code'] = this.verificationCode;
    data['api_token'] = this.apiToken;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['type'] = this.type;
    data['chanel'] = this.chanel;
    return data;
  }
}