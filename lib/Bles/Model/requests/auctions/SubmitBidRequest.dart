class SubmitBidRequest {
  int auctionId;
  int paidPrice;
  int userId;

  SubmitBidRequest({this.auctionId, this.paidPrice, this.userId});

  static SubmitBidRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SubmitBidRequest submitBidRequestBean = SubmitBidRequest();
    submitBidRequestBean.auctionId = map['auction_id'];
    submitBidRequestBean.paidPrice = map['paid_price'];
    return submitBidRequestBean;
  }

  Map toJson() => {
        "auction_id": auctionId,
        "paid_price": paidPrice,
        "user_id": userId,
      };
}
