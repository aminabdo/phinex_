import 'AuctionLandingResponse.dart';

class AuctionSingleResponse {
  Auction data;
  dynamic message;
  int code;

  static AuctionSingleResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AuctionSingleResponse auctionSingleResponseBean = AuctionSingleResponse();
    auctionSingleResponseBean.data = Auction.fromMap(map['data']);
    auctionSingleResponseBean.message = map['message'];
    auctionSingleResponseBean.code = map['code'];
    return auctionSingleResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

