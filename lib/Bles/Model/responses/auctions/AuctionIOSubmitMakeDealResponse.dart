import 'AuctionLandingResponse.dart';

class AuctionIOSubmitMakeDealResponse {
  String auctionId;
  String userId;
  MakeDealBean makeDeal;

  static AuctionIOSubmitMakeDealResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AuctionIOSubmitMakeDealResponse auctionIOSubmitMakeDealResponseBean = AuctionIOSubmitMakeDealResponse();
    auctionIOSubmitMakeDealResponseBean.auctionId = map['auctionId'];
    auctionIOSubmitMakeDealResponseBean.userId = map['userId'];
    auctionIOSubmitMakeDealResponseBean.makeDeal = MakeDealBean.fromMap(map['makeDeal']);
    return auctionIOSubmitMakeDealResponseBean;
  }

  Map toJson() => {
    "auctionId": auctionId,
    "userId": userId,
    "makeDeal": makeDeal,
  };
}