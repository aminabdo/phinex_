class WishListRequest {
  final dynamic user_id;
  final dynamic product_id;

  WishListRequest({this.user_id, this.product_id});

  WishListRequest.fromJson(Map<String, dynamic> json)
      : user_id = json['user_id'],
        product_id = json['product_id'];

  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'product_id': product_id,
      };
}
