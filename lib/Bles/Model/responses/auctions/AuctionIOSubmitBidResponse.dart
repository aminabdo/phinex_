import 'AuctionLandingResponse.dart';

class AuctionIOSubmitBidResponse {
  String auctionId;
  String userId;
  AuctioneeBean auctionee;

  AuctioneeBean get message => null;

  static AuctionIOSubmitBidResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AuctionIOSubmitBidResponse auctionIOSubmitBidResponseBean = AuctionIOSubmitBidResponse();
    auctionIOSubmitBidResponseBean.auctionId = map['auctionId'];
    auctionIOSubmitBidResponseBean.userId = map['userId'];
    auctionIOSubmitBidResponseBean.auctionee = AuctioneeBean.fromMap(map['auctionee']);
    return auctionIOSubmitBidResponseBean;
  }

  Map toJson() => {
    "auctionId": auctionId,
    "userId": userId,
    "auctionee": auctionee,
  };
}
