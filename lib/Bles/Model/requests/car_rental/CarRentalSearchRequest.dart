
class SearchRequest {

  final int skip;
  final int take;
  final String search ;

  SearchRequest({this.search, this.skip = 0, this.take = 10});

  tojson() {
    Map<String,dynamic> map = Map<String,dynamic>();
    map['search'] = this.search;
    return map;
  }

  @override
  String toString() {
    return 'SearchRequest{skip: $skip, take: $take, search: $search}';
  }
}
