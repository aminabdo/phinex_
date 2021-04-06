import '../BaseRequestSkipTake.dart';

class CarRentalFilterationRequest extends BaseRequestSkipTake {
  final int skip;
  final int take;
  final String categories;

  final String model_ids;

  final String rent_period;

  final String max_price;

  final String min_price;

  CarRentalFilterationRequest(
      {this.categories,
      this.model_ids,
      this.rent_period,
      this.max_price,
      this.min_price,
      this.skip = 0,
      this.take = 10});

  Map<String, dynamic> tojson() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['skip'] = this.skip;
    map['take'] = this.take;

    map['categories'] = this.categories;

    if (map['model_ids'] != null) {
      map['model_ids'] = this.model_ids;
    }
    if (map['rent_period'] != null) {
      map['rent_period'] = this.rent_period;
    }

    if (map['max_price'] != null) {
      map['max_price'] = this.max_price;
    }

    if (map['min_price'] != null) {
      map['min_price'] = this.min_price;
    }

    print(map.toString());

    return map;
  }
}
