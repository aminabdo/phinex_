class ProductsByCategoryRequest {
  final int categoryID;
  final int skip;
  final int take;

  ProductsByCategoryRequest({this.categoryID, this.skip = 0, this.take = 10});
}
