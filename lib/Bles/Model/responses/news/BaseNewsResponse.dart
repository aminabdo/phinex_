class BaseNewsResponse {
  String status;
  List<SourcesBean> sources;

  static BaseNewsResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BaseNewsResponse baseNewsResponseBean = BaseNewsResponse();
    baseNewsResponseBean.status = map['status'];
    baseNewsResponseBean.sources = List()..addAll(
      (map['sources'] as List ?? []).map((o) => SourcesBean.fromMap(o))
    );
    return baseNewsResponseBean;
  }

  Map toJson() => {
    "status": status,
    "sources": sources,
  };
}

class SourcesBean {
  String id;
  String name;
  String description;
  String url;
  String category;
  String language;
  String country;

  static SourcesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SourcesBean sourcesBean = SourcesBean();
    sourcesBean.id = map['id'];
    sourcesBean.name = map['name'];
    sourcesBean.description = map['description'];
    sourcesBean.url = map['url'];
    sourcesBean.category = map['category'];
    sourcesBean.language = map['language'];
    sourcesBean.country = map['country'];
    return sourcesBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "url": url,
    "category": category,
    "language": language,
    "country": country,
  };
}