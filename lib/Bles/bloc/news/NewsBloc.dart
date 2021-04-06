import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/responses/news/BaseNewsResponse.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

import '../../ApiRoutes.dart';

class NewsBloc extends BaseBloc {
  BehaviorSubject<BaseNewsResponse> _news = BehaviorSubject<BaseNewsResponse>();

  @override
  dispose() {
    super.dispose();
    _news.close();
  }

  getNews(String language, String country, String category) async {
    loading.value = true;
    BaseNewsResponse response = BaseNewsResponse.fromMap((await repository.get3(ApiRoutes.news(language, country, category))).data);
    _news.value = response;
    _news.value = _news.value;
    loading.value = false;
    loading.value = loading.value;
  }

  @override
  clear() {
    super.clear();
    _news = BehaviorSubject<BaseNewsResponse>();
  }

  BehaviorSubject<BaseNewsResponse> get news => _news;
}

var newsBloc = NewsBloc();
