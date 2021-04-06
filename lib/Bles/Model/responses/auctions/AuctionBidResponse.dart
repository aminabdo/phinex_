import 'AuctionLandingResponse.dart';

class AuctionBidResponse {
  DataBean data;

  static AuctionBidResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AuctionBidResponse auctionBidResponseBean = AuctionBidResponse();
    auctionBidResponseBean.data = DataBean.fromMap(map['data']);
    return auctionBidResponseBean;
  }

  Map toJson() => {
    "data": data,
  };
}

class DataBean {
  List<AuctioneeBean> auctionee;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.auctionee = List()..addAll(
      (map['auctionee'] as List ?? []).map((o) => AuctioneeBean.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "auctionee": auctionee,
  };
}