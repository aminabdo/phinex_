import 'AuctionLandingResponse.dart';

class AuctionDealsResponse {
  DataBean data;

  static AuctionDealsResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AuctionDealsResponse auctionDealsResponseBean = AuctionDealsResponse();
    auctionDealsResponseBean.data = DataBean.fromMap(map['data']);
    return auctionDealsResponseBean;
  }

  Map toJson() => {
    "data": data,
  };
}

class DataBean {
  List<MakeDealBean> makeDeal;
  dynamic winnedUser;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.makeDeal = List()..addAll(
      (map['makeDeal'] as List ?? []).map((o) => MakeDealBean.fromMap(o))
    );
    dataBean.winnedUser = map['winnedUser'];
    return dataBean;
  }

  Map toJson() => {
    "makeDeal": makeDeal,
    "winnedUser": winnedUser,
  };
}
