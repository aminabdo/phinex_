class Mapper {
  String title;
  String categoryName;
  int id;
  int categoryId;

  Mapper(this.title, this.categoryName, this.id, this.categoryId);

  Mapper.min(this.title, this.id);
}


class SearchLiteResponse {
  Data data;
  dynamic message;
  int code;

  SearchLiteResponse({
    this.data,
    this.message,
    this.code,
  });

  SearchLiteResponse.fromJson(dynamic json) {
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    message = json["message"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      map["data"] = data.toJson();
    }
    map["message"] = message;
    map["code"] = code;
    return map;
  }
}

class Data {
  Total total;
  List<Products> products;
  List<BuyAndSell> buyAndSell;
  List<Realestate> realestate;
  List<Vendors> vendors;
  List<Doctors> doctors;
  List<Technicians> technicians;
  List<Catalogues> catalogues;
  List<Auctions> auctions;
  List<Lots> lots;
  List<Users> users;

  List<Mapper> mapper = [];

  Data({
    this.total,
    this.products,
    this.buyAndSell,
    this.realestate,
    this.vendors,
    this.doctors,
    this.technicians,
    this.catalogues,
    this.auctions,
    this.lots,
    this.users,
  });

  Data.fromJson(dynamic json) {
    total = json["total"] != null ? Total.fromJson(json["total"]) : null;
    if (json["products"] != null) {
      products = [];
      json["products"].forEach((v) {
        products.add(Products.fromJson(v));
      });
    }
    if (json["buyAndSell"] != null) {
      buyAndSell = [];
      json["buyAndSell"].forEach((v) {
        buyAndSell.add(BuyAndSell.fromJson(v));
      });
    }
    if (json["realestate"] != null) {
      realestate = [];
      json["realestate"].forEach((v) {
        realestate.add(Realestate.fromJson(v));
      });
    }
    if (json["vendors"] != null) {
      vendors = [];
      json["vendors"].forEach((v) {
        vendors.add(Vendors.fromJson(v));
      });
    }
    if (json["doctors"] != null) {
      doctors = [];
      json["doctors"].forEach((v) {
        doctors.add(Doctors.fromJson(v));
      });
    }
    if (json["technicians"] != null) {
      technicians = [];
      json["technicians"].forEach((v) {
        technicians.add(Technicians.fromJson(v));
      });
    }
    if (json["catalogues"] != null) {
      catalogues = [];
      json["catalogues"].forEach((v) {
        catalogues.add(Catalogues.fromJson(v));
      });
    }
    if (json["auctions"] != null) {
      auctions = [];
      json["auctions"].forEach((v) {
        auctions.add(Auctions.fromJson(v));
      });
    }
    if (json["lots"] != null) {
      lots = [];
      json["lots"].forEach((v) {
        lots.add(Lots.fromJson(v));
      });
    }
    if (json["users"] != null) {
      users = [];
      json["users"].forEach((v) {
        users.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (total != null) {
      map["total"] = total.toJson();
    }
    if (products != null) {
      map["products"] = products.map((v) => v.toJson()).toList();
    }
    if (buyAndSell != null) {
      map["buyAndSell"] = buyAndSell.map((v) => v.toJson()).toList();
    }
    if (realestate != null) {
      map["realestate"] = realestate.map((v) => v.toJson()).toList();
    }
    if (vendors != null) {
      map["vendors"] = vendors.map((v) => v.toJson()).toList();
    }
    if (doctors != null) {
      map["doctors"] = doctors.map((v) => v.toJson()).toList();
    }
    if (technicians != null) {
      map["technicians"] = technicians.map((v) => v.toJson()).toList();
    }
    if (catalogues != null) {
      map["catalogues"] = catalogues.map((v) => v.toJson()).toList();
    }
    if (auctions != null) {
      map["auctions"] = auctions.map((v) => v.toJson()).toList();
    }
    if (lots != null) {
      map["lots"] = lots.map((v) => v.toJson()).toList();
    }
    if (users != null) {
      map["users"] = users.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Users {
  int id;
  String username;

  Users({this.id, this.username});

  Users.fromJson(dynamic json) {
    id = json["id"];
    username = json["username"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["username"] = username;
    return map;
  }
}

class Lots {
  int id;
  String name;

  Lots({this.id, this.name});

  Lots.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }
}

class Auctions {
  int id;
  String name;

  Auctions({this.id, this.name});

  Auctions.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }
}

class Catalogues {
  int id;
  String name;

  Catalogues({this.id, this.name});

  Catalogues.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }
}

class Technicians {
  int id;
  String name;

  Technicians({this.id, this.name});

  Technicians.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }
}

class Doctors {
  int id;
  String name;

  Doctors({this.id, this.name});

  Doctors.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }
}

class Vendors {
  int id;
  String name;

  Vendors({this.id, this.name});

  Vendors.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }
}

class Realestate {
  int id;
  String name;

  Realestate({this.id, this.name});

  Realestate.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }
}

class BuyAndSell {
  int id;
  String name;

  BuyAndSell({this.id, this.name});

  BuyAndSell.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }
}

class Products {
  int id;
  String name;

  Products({this.id, this.name});

  Products.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }
}

class Total {
  int products;
  int buyAndSell;
  int realestate;
  int vendors;
  int doctors;
  int technicians;
  int catalogues;
  int auctions;
  int lots;
  int users;
  int all;

  int myTotal = 0;

  Total({
    this.products,
    this.buyAndSell,
    this.realestate,
    this.vendors,
    this.doctors,
    this.technicians,
    this.catalogues,
    this.auctions,
    this.lots,
    this.users,
    this.all,
    this.myTotal,
  });

  Total.fromJson(dynamic json) {
    if (json["products"] != null) {
      products = json["products"];
      myTotal++;
    }
    if (json["realestate"] != null) {
      realestate = json["realestate"];
      myTotal++;
    }
    if (json["buyAndSell"] != null) {
      buyAndSell = json["buyAndSell"];
      myTotal++;
    }
    if (json["vendors"] != null) {
      vendors = json["vendors"];
      myTotal++;
    }
    if (json["doctors"] != null) {
      doctors = json["doctors"];
      myTotal++;
    }
    if (json["technicians"] != null) {
      technicians = json["technicians"];
      myTotal++;
    }
    if (json["catalogues"] != null) {
      catalogues = json["catalogues"];
      myTotal++;
    }
    if (json["auctions"] != null) {
      auctions = json["auctions"];
      myTotal++;
    }
    if (json["lots"] != null) {
      lots = json["lots"];
      myTotal++;
    }
    if (json["users"] != null) {
      users = json["users"];
      myTotal++;
    }

    all = json["all"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["products"] = products;
    map["buyAndSell"] = buyAndSell;
    map["realestate"] = realestate;
    map["vendors"] = vendors;
    map["doctors"] = doctors;
    map["technicians"] = technicians;
    map["catalogues"] = catalogues;
    map["auctions"] = auctions;
    map["lots"] = lots;
    map["users"] = users;
    map["all"] = all;
    return map;
  }
}
