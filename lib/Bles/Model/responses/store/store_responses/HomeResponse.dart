import 'package:phinex/utils/base/BaseResponse.dart';

import 'CategoriesBean.dart';

// class StoreHomeResponse extends BaseResponse{
//   List<CategoriesBean> data;
//
//   static StoreHomeResponse fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
//     StoreHomeResponse myProductsResponseBean = StoreHomeResponse();
//     myProductsResponseBean.data = List()..addAll(
//       (map['data'] as List ?? []).map((o) => CategoriesBean.fromMap(o))
//     );
//
//
//     if(map[map['message']] == null){
//       print("message == null");
//       myProductsResponseBean.message = null;
//     }
//     else {
//       print("message != null");
//       myProductsResponseBean.message = map['message'];
//     }
//     myProductsResponseBean.code = map['code'];
//     return myProductsResponseBean;
//
//   }
//
//   Map toJson() => {
//     "data": data,
//     "message": message,
//     "code": code,
//   };
// }



