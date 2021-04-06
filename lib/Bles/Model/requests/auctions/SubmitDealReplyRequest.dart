class SubmitDealReplyRequest {
  int auctionId;
  String status;

  SubmitDealReplyRequest({this.auctionId, this.status});

  Map toJson() => {
    "auction_id": auctionId,
    "status": status,
  };
}