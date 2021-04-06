class AuctionIODealReplyResponse {
  DataBean data;
  dynamic message;
  int code;

  static AuctionIODealReplyResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AuctionIODealReplyResponse auctionIOSubmitDealResponseBean = AuctionIODealReplyResponse();
    auctionIOSubmitDealResponseBean.data = DataBean.fromMap(map['data']);
    auctionIOSubmitDealResponseBean.message = map['message'];
    auctionIOSubmitDealResponseBean.code = map['code'];
    return auctionIOSubmitDealResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  int id;
  int auctionId;
  int price;
  int userId;
  String status;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.id = map['id'];
    dataBean.auctionId = map['auction_id'];
    dataBean.price = map['price'];
    dataBean.userId = map['user_id'];
    dataBean.status = map['status'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.deletedAt = map['deleted_at'];
    return dataBean;
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
  };
}