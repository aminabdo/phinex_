class RateByProductRequest {
  final int productID;
  final int skip;
  final int take;

  RateByProductRequest({this.productID, this.skip = 0, this.take = 10});
}
