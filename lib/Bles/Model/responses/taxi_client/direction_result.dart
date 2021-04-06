class DirectionResult {
  List<GeocodedWaypoints> _geocodedWaypoints;
  List<Routes> _routes;
  String _status;

  DirectionResult(
      {List<GeocodedWaypoints> geocodedWaypoints,
        List<Routes> routes,
        String status}) {
    this._geocodedWaypoints = geocodedWaypoints;
    this._routes = routes;
    this._status = status;
  }

  List<GeocodedWaypoints> get geocodedWaypoints => _geocodedWaypoints;
  set geocodedWaypoints(List<GeocodedWaypoints> geocodedWaypoints) =>
      _geocodedWaypoints = geocodedWaypoints;
  List<Routes> get routes => _routes;
  set routes(List<Routes> routes) => _routes = routes;
  String get status => _status;
  set status(String status) => _status = status;

  DirectionResult.fromJson(Map<String, dynamic> json) {
    if (json['geocoded_waypoints'] != null) {
      _geocodedWaypoints = new List<GeocodedWaypoints>();
      json['geocoded_waypoints'].forEach((v) {
        _geocodedWaypoints.add(new GeocodedWaypoints.fromJson(v));
      });
    }
    if (json['routes'] != null) {
      _routes = new List<Routes>();
      json['routes'].forEach((v) {
        _routes.add(new Routes.fromJson(v));
      });
    }
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._geocodedWaypoints != null) {
      data['geocoded_waypoints'] =
          this._geocodedWaypoints.map((v) => v.toJson()).toList();
    }
    if (this._routes != null) {
      data['routes'] = this._routes.map((v) => v.toJson()).toList();
    }
    data['status'] = this._status;
    return data;
  }
}

class GeocodedWaypoints {
  String _geocoderStatus;
  String _placeId;
  List<String> _types;

  GeocodedWaypoints(
      {String geocoderStatus, String placeId, List<String> types}) {
    this._geocoderStatus = geocoderStatus;
    this._placeId = placeId;
    this._types = types;
  }

  String get geocoderStatus => _geocoderStatus;
  set geocoderStatus(String geocoderStatus) => _geocoderStatus = geocoderStatus;
  String get placeId => _placeId;
  set placeId(String placeId) => _placeId = placeId;
  List<String> get types => _types;
  set types(List<String> types) => _types = types;

  GeocodedWaypoints.fromJson(Map<String, dynamic> json) {
    _geocoderStatus = json['geocoder_status'];
    _placeId = json['place_id'];
    _types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['geocoder_status'] = this._geocoderStatus;
    data['place_id'] = this._placeId;
    data['types'] = this._types;
    return data;
  }
}

class Routes {
  Bounds _bounds;
  String _copyrights;
  List<Legs> _legs;
  Polyline _overviewPolyline;
  String _summary;

  Routes(
      {Bounds bounds,
        String copyrights,
        List<Legs> legs,
        Polyline overviewPolyline,
        String summary,
        List<Null> warnings,
        List<Null> waypointOrder}) {
    this._bounds = bounds;
    this._copyrights = copyrights;
    this._legs = legs;
    this._overviewPolyline = overviewPolyline;
    this._summary = summary;
  }

  Bounds get bounds => _bounds;
  set bounds(Bounds bounds) => _bounds = bounds;
  String get copyrights => _copyrights;
  set copyrights(String copyrights) => _copyrights = copyrights;
  List<Legs> get legs => _legs;
  set legs(List<Legs> legs) => _legs = legs;
  Polyline get overviewPolyline => _overviewPolyline;
  set overviewPolyline(Polyline overviewPolyline) =>
      _overviewPolyline = overviewPolyline;
  String get summary => _summary;
  set summary(String summary) => _summary = summary;

  Routes.fromJson(Map<String, dynamic> json) {
    _bounds =
    json['bounds'] != null ? new Bounds.fromJson(json['bounds']) : null;
    _copyrights = json['copyrights'];
    if (json['legs'] != null) {
      _legs = new List<Legs>();
      json['legs'].forEach((v) {
        _legs.add(new Legs.fromJson(v));
      });
    }
    _overviewPolyline = json['overview_polyline'] != null
        ? new Polyline.fromJson(json['overview_polyline'])
        : null;
    _summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._bounds != null) {
      data['bounds'] = this._bounds.toJson();
    }
    data['copyrights'] = this._copyrights;
    if (this._legs != null) {
      data['legs'] = this._legs.map((v) => v.toJson()).toList();
    }
    if (this._overviewPolyline != null) {
      data['overview_polyline'] = this._overviewPolyline.toJson();
    }
    data['summary'] = this._summary;
    return data;
  }
}

class Bounds {
  Northeast _northeast;
  Northeast _southwest;

  Bounds({Northeast northeast, Northeast southwest}) {
    this._northeast = northeast;
    this._southwest = southwest;
  }

  Northeast get northeast => _northeast;
  set northeast(Northeast northeast) => _northeast = northeast;
  Northeast get southwest => _southwest;
  set southwest(Northeast southwest) => _southwest = southwest;

  Bounds.fromJson(Map<String, dynamic> json) {
    _northeast = json['northeast'] != null
        ? new Northeast.fromJson(json['northeast'])
        : null;
    _southwest = json['southwest'] != null
        ? new Northeast.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._northeast != null) {
      data['northeast'] = this._northeast.toJson();
    }
    if (this._southwest != null) {
      data['southwest'] = this._southwest.toJson();
    }
    return data;
  }
}

class Northeast {
  double _lat;
  double _lng;

  Northeast({double lat, double lng}) {
    this._lat = lat;
    this._lng = lng;
  }

  double get lat => _lat;
  set lat(double lat) => _lat = lat;
  double get lng => _lng;
  set lng(double lng) => _lng = lng;

  Northeast.fromJson(Map<String, dynamic> json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this._lat;
    data['lng'] = this._lng;
    return data;
  }
}

class Legs {
  Distance _distance;
  Distance _duration;
  String _endAddress;
  Northeast _endLocation;
  String _startAddress;
  Northeast _startLocation;
  List<Steps> _steps;

  Legs(
      {Distance distance,
        Distance duration,
        String endAddress,
        Northeast endLocation,
        String startAddress,
        Northeast startLocation,
        List<Steps> steps,
        List<Null> trafficSpeedEntry,
        List<Null> viaWaypoint}) {
    this._distance = distance;
    this._duration = duration;
    this._endAddress = endAddress;
    this._endLocation = endLocation;
    this._startAddress = startAddress;
    this._startLocation = startLocation;
    this._steps = steps;
  }

  Distance get distance => _distance;
  set distance(Distance distance) => _distance = distance;
  Distance get duration => _duration;
  set duration(Distance duration) => _duration = duration;
  String get endAddress => _endAddress;
  set endAddress(String endAddress) => _endAddress = endAddress;
  Northeast get endLocation => _endLocation;
  set endLocation(Northeast endLocation) => _endLocation = endLocation;
  String get startAddress => _startAddress;
  set startAddress(String startAddress) => _startAddress = startAddress;
  Northeast get startLocation => _startLocation;
  set startLocation(Northeast startLocation) => _startLocation = startLocation;
  List<Steps> get steps => _steps;

  Legs.fromJson(Map<String, dynamic> json) {
    _distance = json['distance'] != null
        ? new Distance.fromJson(json['distance'])
        : null;
    _duration = json['duration'] != null
        ? new Distance.fromJson(json['duration'])
        : null;
    _endAddress = json['end_address'];
    _endLocation = json['end_location'] != null
        ? new Northeast.fromJson(json['end_location'])
        : null;
    _startAddress = json['start_address'];
    _startLocation = json['start_location'] != null
        ? new Northeast.fromJson(json['start_location'])
        : null;
    if (json['steps'] != null) {
      _steps = new List<Steps>();
      json['steps'].forEach((v) {
        _steps.add(new Steps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._distance != null) {
      data['distance'] = this._distance.toJson();
    }
    if (this._duration != null) {
      data['duration'] = this._duration.toJson();
    }
    data['end_address'] = this._endAddress;
    if (this._endLocation != null) {
      data['end_location'] = this._endLocation.toJson();
    }
    data['start_address'] = this._startAddress;
    if (this._startLocation != null) {
      data['start_location'] = this._startLocation.toJson();
    }
    if (this._steps != null) {
      data['steps'] = this._steps.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Distance {
  String _text;
  int _value;

  Distance({String text, int value}) {
    this._text = text;
    this._value = value;
  }

  String get text => _text;
  set text(String text) => _text = text;
  int get value => _value;
  set value(int value) => _value = value;

  Distance.fromJson(Map<String, dynamic> json) {
    _text = json['text'];
    _value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this._text;
    data['value'] = this._value;
    return data;
  }
}

class Steps {
  Distance _distance;
  Distance _duration;
  Northeast _endLocation;
  String _htmlInstructions;
  Polyline _polyline;
  Northeast _startLocation;
  String _travelMode;
  String _maneuver;

  Steps(
      {Distance distance,
        Distance duration,
        Northeast endLocation,
        String htmlInstructions,
        Polyline polyline,
        Northeast startLocation,
        String travelMode,
        String maneuver}) {
    this._distance = distance;
    this._duration = duration;
    this._endLocation = endLocation;
    this._htmlInstructions = htmlInstructions;
    this._polyline = polyline;
    this._startLocation = startLocation;
    this._travelMode = travelMode;
    this._maneuver = maneuver;
  }

  Distance get distance => _distance;
  set distance(Distance distance) => _distance = distance;
  Distance get duration => _duration;
  set duration(Distance duration) => _duration = duration;
  Northeast get endLocation => _endLocation;
  set endLocation(Northeast endLocation) => _endLocation = endLocation;
  String get htmlInstructions => _htmlInstructions;
  set htmlInstructions(String htmlInstructions) =>
      _htmlInstructions = htmlInstructions;
  Polyline get polyline => _polyline;
  set polyline(Polyline polyline) => _polyline = polyline;
  Northeast get startLocation => _startLocation;
  set startLocation(Northeast startLocation) => _startLocation = startLocation;
  String get travelMode => _travelMode;
  set travelMode(String travelMode) => _travelMode = travelMode;
  String get maneuver => _maneuver;
  set maneuver(String maneuver) => _maneuver = maneuver;

  Steps.fromJson(Map<String, dynamic> json) {
    _distance = json['distance'] != null
        ? new Distance.fromJson(json['distance'])
        : null;
    _duration = json['duration'] != null
        ? new Distance.fromJson(json['duration'])
        : null;
    _endLocation = json['end_location'] != null
        ? new Northeast.fromJson(json['end_location'])
        : null;
    _htmlInstructions = json['html_instructions'];
    _polyline = json['polyline'] != null
        ? new Polyline.fromJson(json['polyline'])
        : null;
    _startLocation = json['start_location'] != null
        ? new Northeast.fromJson(json['start_location'])
        : null;
    _travelMode = json['travel_mode'];
    _maneuver = json['maneuver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._distance != null) {
      data['distance'] = this._distance.toJson();
    }
    if (this._duration != null) {
      data['duration'] = this._duration.toJson();
    }
    if (this._endLocation != null) {
      data['end_location'] = this._endLocation.toJson();
    }
    data['html_instructions'] = this._htmlInstructions;
    if (this._polyline != null) {
      data['polyline'] = this._polyline.toJson();
    }
    if (this._startLocation != null) {
      data['start_location'] = this._startLocation.toJson();
    }
    data['travel_mode'] = this._travelMode;
    data['maneuver'] = this._maneuver;
    return data;
  }
}

class Polyline {
  String _points;

  Polyline({String points}) {
    this._points = points;
  }

  String get points => _points;
  set points(String points) => _points = points;

  Polyline.fromJson(Map<String, dynamic> json) {
    _points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this._points;
    return data;
  }
}