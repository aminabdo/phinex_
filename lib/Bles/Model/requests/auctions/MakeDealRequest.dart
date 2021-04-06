class MakeDealRequest {
  int auctionId;
  int price;
  int userId;


  MakeDealRequest({this.auctionId, this.price, this.userId});

  static MakeDealRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MakeDealRequest makeDealRequestBean = MakeDealRequest();
    makeDealRequestBean.auctionId = map['auction_id'];
    makeDealRequestBean.price = map['price'];
    makeDealRequestBean.userId = map['user_id'];
    return makeDealRequestBean;
  }

  Map toJson() => {
    "auction_id": auctionId,
    "price": price,
    "user_id": userId,
  };
}