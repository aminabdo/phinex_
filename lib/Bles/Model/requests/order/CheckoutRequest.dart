/// userId : 1
/// country : 1
/// governorate : 1
/// city : 1
/// address : "address"
/// anotherShippingAddress : "another address"

class CheckoutRequest {
  int userId;
  int country;
  int governorate;
  int city;
  String address;
  String anotherShippingAddress;

  static CheckoutRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CheckoutRequest checkoutRequestBean = CheckoutRequest();
    checkoutRequestBean.userId = map['userId'];
    checkoutRequestBean.country = map['country'];
    checkoutRequestBean.governorate = map['governorate'];
    checkoutRequestBean.city = map['city'];
    checkoutRequestBean.address = map['address'];
    checkoutRequestBean.anotherShippingAddress = map['anotherShippingAddress'];
    return checkoutRequestBean;
  }

  Map<String ,dynamic> toJson() => {
    "userId": userId,
    "country": country,
    "governorate": governorate,
    "city": city,
    "address": address,
    "anotherShippingAddress": anotherShippingAddress,
  };
}