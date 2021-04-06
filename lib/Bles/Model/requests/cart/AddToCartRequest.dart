
class AddToCartRequest {
  List<CartProductsBean> cartProducts = [];

  static AddToCartRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AddToCartRequest addToCartRequestBean = AddToCartRequest();
    addToCartRequestBean.cartProducts = List()
      ..addAll((map['cartProducts'] as List ?? [])
          .map((o) => CartProductsBean.fromMap(o)));
    return addToCartRequestBean;
  }


  Map toJson() => {
        "cartProducts": cartProducts,
      };
}

class CartProductsBean {
  dynamic productId;
  dynamic userId;
  dynamic vendorId;
  dynamic quantity;

  CartProductsBean({
    this.productId,
    this.quantity,
    this.userId,
    this.vendorId,
  });

  static CartProductsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CartProductsBean cartProductsBean = CartProductsBean();
    cartProductsBean.productId = map['product_id'];
    cartProductsBean.userId = map['user_id'];
    cartProductsBean.vendorId = map['vendor_id'];
    cartProductsBean.quantity = map['quantity'];
    return cartProductsBean;
  }

  Map toJson() => {
        "product_id": productId,
        "user_id": userId,
        "vendor_id": vendorId,
        "quantity": quantity,
      };
}
