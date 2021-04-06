
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phinex/ui/views/home/home_contents.dart';

class PageProvider with ChangeNotifier{

  int _currentPageIndex = 0;
  Widget _page = HomeContents();

  void setPage(int pageIndex, Widget page, {int backIndex, Widget backPage}) {
    _currentPageIndex = backIndex ?? pageIndex;
    _page = backPage ?? page;
    notifyListeners();
  }

  int get pageIndex => _currentPageIndex;
  Widget get page => _page;
}