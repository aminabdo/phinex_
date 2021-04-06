import 'AuctionLandingResponse.dart';

class AuctionsByCatResponse {
  List<Auction> data;
  dynamic message;
  int code;

  static AuctionsByCatResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AuctionsByCatResponse auctionsByCatResponseBean = AuctionsByCatResponse();
    auctionsByCatResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => Auction.fromMap(o))
    );
    auctionsByCatResponseBean.message = map['message'];
    auctionsByCatResponseBean.code = map['code'];
    return auctionsByCatResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}
