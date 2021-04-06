import 'General.dart';

/// data : [{"id":1,"title":"????? ?????","image":"http://taxiApi.codecaique.com/uploads/9468971602585965_?????.jpg","created_at":"2020-08-08 15:50:38","updated_at":"2020-10-16 21:40:39"},{"id":2,"title":"?????","image":"http://taxiApi.codecaique.com/uploads/7268341602877092_?????.jpg","created_at":"2020-06-18 22:05:04","updated_at":"2020-10-16 21:38:12"},{"id":3,"title":"?????","image":"http://taxiApi.codecaique.com/uploads/1712131602877497_images.jpg","created_at":"2020-10-13 10:02:55","updated_at":"2020-10-16 21:44:57"},{"id":4,"title":"??? ????? ? ??????","image":"http://taxiApi.codecaique.com/uploads/2850881602877772_????? &.jpg","created_at":"2020-10-16 21:46:57","updated_at":"2020-10-16 21:49:32"}]

class VehicleTypeResponse {
  List<VehicleType> data;

  static VehicleTypeResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    VehicleTypeResponse vehicleTypeResponseBean = VehicleTypeResponse();
    vehicleTypeResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => VehicleType.fromMap(o))
    );
    return vehicleTypeResponseBean;
  }

  Map toJson() => {
    "data": data,
  };
}


