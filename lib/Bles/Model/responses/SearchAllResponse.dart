class SearchAllResponse {
  Data _data;
  dynamic _message;
  int _code;

  Data get data => _data;

  dynamic get message => _message;

  int get code => _code;

  SearchAllResponse({Data data, dynamic message, int code}) {
    _data = data;
    _message = message;
    _code = code;
  }

  SearchAllResponse.fromJson(dynamic json) {
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    _message = json["message"];
    _code = json["code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    map["message"] = _message;
    map["code"] = _code;
    return map;
  }
}

class Data {
  List<Products> _products;
  List<BuyAndSell> _buyAndSell;
  List<Realestate> _realestate;
  List<Vendors> _vendors;
  Medical_services _medical_services;
  List<Technicians> _technicians;
  List<Catalogues> _catalogues;
  List<Auctions> _auctions;
  List<Users> _users;

  List<Products> get products => _products;

  List<BuyAndSell> get buyAndSell => _buyAndSell;

  List<Realestate> get realestate => _realestate;

  List<Vendors> get vendors => _vendors;

  Medical_services get medical_services => _medical_services;

  List<Technicians> get technicians => _technicians;

  List<Catalogues> get catalogues => _catalogues;

  List<Auctions> get auctions => _auctions;

  List<Users> get users => _users;

  Data(
      {List<Products> products,
      List<BuyAndSell> buyAndSell,
      List<Realestate> realestate,
      List<Vendors> vendors,
      Medical_services medical_services,
      List<Technicians> technicians,
      List<Catalogues> catalogues,
      List<Auctions> auctions,
      List<Users> users}) {
    _products = products;
    _buyAndSell = buyAndSell;
    _realestate = realestate;
    _vendors = vendors;
    _medical_services = medical_services;
    _technicians = technicians;
    _catalogues = catalogues;
    _auctions = auctions;
    _users = users;
  }

  Data.fromJson(dynamic json) {
    if (json["buyAndSell"] != null) {
      _buyAndSell = [];
      json["buyAndSell"].forEach((v) {
        _buyAndSell.add(BuyAndSell.fromJson(v));
      });
    }
    if (json["realestate"] != null) {
      _realestate = [];
      json["realestate"].forEach((v) {
        _realestate.add(Realestate.fromJson(v));
      });
    }
    if (json["vendors"] != null) {
      _vendors = [];
      json["vendors"].forEach((v) {
        _vendors.add(Vendors.fromJson(v));
      });
    }
    _medical_services = json["medical_services"] != null
        ? Medical_services.fromJson(json["medical_services"])
        : null;
    if (json["technicians"] != null) {
      _technicians = [];
      json["technicians"].forEach((v) {
        _technicians.add(Technicians.fromJson(v));
      });
    }
    if (json["catalogues"] != null) {
      _catalogues = [];
      json["catalogues"].forEach((v) {
        _catalogues.add(Catalogues.fromJson(v));
      });
    }
    if (json["auctions"] != null) {
      _auctions = [];
      json["auctions"].forEach((v) {
        _auctions.add(Auctions.fromJson(v));
      });
    }
    if (json["users"] != null) {
      _users = [];
      json["users"].forEach((v) {
        _users.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_products != null) {
      map["products"] = _products.map((v) => v.toJson()).toList();
    }
    if (_buyAndSell != null) {
      map["buyAndSell"] = _buyAndSell.map((v) => v.toJson()).toList();
    }
    if (_realestate != null) {
      map["realestate"] = _realestate.map((v) => v.toJson()).toList();
    }
    if (_vendors != null) {
      map["vendors"] = _vendors.map((v) => v.toJson()).toList();
    }
    if (_medical_services != null) {
      map["medical_services"] = _medical_services.toJson();
    }
    if (_technicians != null) {
      map["technicians"] = _technicians.map((v) => v.toJson()).toList();
    }
    if (_catalogues != null) {
      map["catalogues"] = _catalogues.map((v) => v.toJson()).toList();
    }
    if (_auctions != null) {
      map["auctions"] = _auctions.map((v) => v.toJson()).toList();
    }
    if (_users != null) {
      map["users"] = _users.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Users {
  int _id;
  String _username;
  String _imageUrl;

  int get id => _id;

  String get username => _username;

  String get imageUrl => _imageUrl;

  Users({int id, String username, String imageUrl}) {
    _id = id;
    _username = username;
    _imageUrl = imageUrl;
  }

  Users.fromJson(dynamic json) {
    _id = json["id"];
    _username = json["username"];
    _imageUrl = json["image_url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["username"] = _username;
    map["image_url"] = _imageUrl;
    return map;
  }
}

class Auctions {
  int _id;
  String _name;
  int _categoryId;
  String _categoryName;

  int get id => _id;

  String get name => _name;

  int get categoryId => _categoryId;

  String get categoryName => _categoryName;

  Auctions({int id, String name, int categoryId, String categoryName}) {
    _id = id;
    _name = name;
    _categoryId = categoryId;
    _categoryName = categoryName;
  }

  Auctions.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _categoryId = json["categoryId"];
    _categoryName = json["categoryName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["categoryId"] = _categoryId;
    map["categoryName"] = _categoryName;
    return map;
  }
}

class Catalogues {
  int _id;
  String _name;
  int _categoryId;
  String _categoryName;

  int get id => _id;

  String get name => _name;

  int get categoryId => _categoryId;

  String get categoryName => _categoryName;

  Catalogues({int id, String name, int categoryId, String categoryName}) {
    _id = id;
    _name = name;
    _categoryId = categoryId;
    _categoryName = categoryName;
  }

  Catalogues.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _categoryId = json["categoryId"];
    _categoryName = json["categoryName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["categoryId"] = _categoryId;
    map["categoryName"] = _categoryName;
    return map;
  }
}

class Technicians {
  int _id;
  String _name;
  int _categoryId;
  String _categoryName;

  int get id => _id;

  String get name => _name;

  int get categoryId => _categoryId;

  String get categoryName => _categoryName;

  Technicians({int id, String name, int categoryId, String categoryName}) {
    _id = id;
    _name = name;
    _categoryId = categoryId;
    _categoryName = categoryName;
  }

  Technicians.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _categoryId = json["categoryId"];
    _categoryName = json["categoryName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["categoryId"] = _categoryId;
    map["categoryName"] = _categoryName;
    return map;
  }
}

class Medical_services {
  List<Doctors> _doctors;
  List<Clinics> _clinics;
  List<Pharmacies> _pharmacies;

  List<Doctors> get doctors => _doctors;

  List<Clinics> get clinics => _clinics;

  List<Pharmacies> get pharmacies => _pharmacies;

  Medical_services(
      {List<Doctors> doctors,
      List<Clinics> clinics,
      List<Pharmacies> pharmacies}) {
    _doctors = doctors;
    _clinics = clinics;
    _pharmacies = pharmacies;
  }

  Medical_services.fromJson(dynamic json) {
    if (json["doctors"] != null) {
      _doctors = [];
      json["doctors"].forEach((v) {
        _doctors.add(Doctors.fromJson(v));
      });
    }
    if (json["clinics"] != null) {
      _clinics = [];
      json["clinics"].forEach((v) {
        _clinics.add(Clinics.fromJson(v));
      });
    }
    if (json["pharmacies"] != null) {
      _pharmacies = [];
      json["pharmacies"].forEach((v) {
        _pharmacies.add(Pharmacies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_doctors != null) {
      map["doctors"] = _doctors.map((v) => v.toJson()).toList();
    }
    if (_clinics != null) {
      map["clinics"] = _clinics.map((v) => v.toJson()).toList();
    }
    if (_pharmacies != null) {
      map["pharmacies"] = _pharmacies.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Pharmacies {
  int _id;
  String _name;

  int get id => _id;

  String get name => _name;

  Pharmacies({int id, String name}) {
    _id = id;
    _name = name;
  }

  Pharmacies.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }
}

class Clinics {
  int _id;
  String _name;
  int _categoryId;
  String _categoryName;

  int get id => _id;

  String get name => _name;

  int get categoryId => _categoryId;

  String get categoryName => _categoryName;

  Clinics({int id, String name, int categoryId, String categoryName}) {
    _id = id;
    _name = name;
    _categoryId = categoryId;
    _categoryName = categoryName;
  }

  Clinics.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _categoryId = json["categoryId"];
    _categoryName = json["categoryName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["categoryId"] = _categoryId;
    map["categoryName"] = _categoryName;
    return map;
  }
}

class Doctors {
  int _id;
  String _name;
  int _categoryId;
  String _categoryName;

  int get id => _id;

  String get name => _name;

  int get categoryId => _categoryId;

  String get categoryName => _categoryName;

  Doctors({int id, String name, int categoryId, String categoryName}) {
    _id = id;
    _name = name;
    _categoryId = categoryId;
    _categoryName = categoryName;
  }

  Doctors.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _categoryId = json["categoryId"];
    _categoryName = json["categoryName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["categoryId"] = _categoryId;
    map["categoryName"] = _categoryName;
    return map;
  }
}

class Vendors {
  int _id;
  String _name;
  int _categoryId;
  String _categoryName;

  int get id => _id;

  String get name => _name;

  int get categoryId => _categoryId;

  String get categoryName => _categoryName;

  Vendors({int id, String name, int categoryId, String categoryName}) {
    _id = id;
    _name = name;
    _categoryId = categoryId;
    _categoryName = categoryName;
  }

  Vendors.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _categoryId = json["categoryId"];
    _categoryName = json["categoryName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["categoryId"] = _categoryId;
    map["categoryName"] = _categoryName;
    return map;
  }
}

class Realestate {
  int _id;
  String _name;
  int _categoryId;
  String _categoryName;

  int get id => _id;

  String get name => _name;

  int get categoryId => _categoryId;

  String get categoryName => _categoryName;

  Realestate({int id, String name, int categoryId, String categoryName}) {
    _id = id;
    _name = name;
    _categoryId = categoryId;
    _categoryName = categoryName;
  }

  Realestate.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _categoryId = json["categoryId"];
    _categoryName = json["categoryName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["categoryId"] = _categoryId;
    map["categoryName"] = _categoryName;
    return map;
  }
}

class BuyAndSell {
  int _id;
  String _name;
  int _categoryId;
  String _categoryName;

  int get id => _id;

  String get name => _name;

  int get categoryId => _categoryId;

  String get categoryName => _categoryName;

  BuyAndSell({int id, String name, int categoryId, String categoryName}) {
    _id = id;
    _name = name;
    _categoryId = categoryId;
    _categoryName = categoryName;
  }

  BuyAndSell.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _categoryId = json["categoryId"];
    _categoryName = json["categoryName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["categoryId"] = _categoryId;
    map["categoryName"] = _categoryName;
    return map;
  }
}

class Products {
  int _id;
  String _name;
  String _categoryId;
  String _categoryName;

  int get id => _id;

  String get name => _name;

  String get categoryId => _categoryId;

  String get categoryName => _categoryName;

  Products({int id, String name, String categoryId, String categoryName}) {
    _id = id;
    _name = name;
    _categoryId = categoryId;
    _categoryName = categoryName;
  }

  Products.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _categoryId = json["category_id"];
    _categoryName = json["category_name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["category_id"] = _categoryId;
    map["category_name"] = _categoryName;
    return map;
  }
}
