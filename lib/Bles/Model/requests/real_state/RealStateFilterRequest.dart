class RealStateFilterRequest {
  String category_id;

  String estate_finishing;

  String estate_furnishing;

  String estate_type;

  String has_coverd_parking;

  String has_garden;

  String has_maid_service;

  String has_security;

  String skip;

  String take;

  RealStateFilterRequest(
      {this.skip,
      this.take,
      this.category_id,
      this.estate_finishing,
      this.estate_furnishing,
      this.estate_type,
      this.has_coverd_parking,
      this.has_garden,
      this.has_maid_service,
      this.has_security});

  Map tojson() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['skip'] = this.skip;
    map['take'] = this.take;
    map['category_id'] = this.category_id;
    map['estate_finishing'] = this.estate_finishing;
    map['estate_furnishing'] = this.estate_furnishing;
    map['estate_type'] = this.estate_type;
    map['has_coverd_parking'] = this.has_coverd_parking;
    map['has_garden'] = this.has_garden;
    map['has_maid_service'] = this.has_maid_service;
    map['has_security'] = this.has_security;
    return map;
  }
}

enum enum_estate_finishing { full, half, none }
enum enum_estate_furnishing { unfurnished, furnished }
enum enum_estate_type { rental, sale }
