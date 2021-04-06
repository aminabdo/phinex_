import 'package:dio/dio.dart';

class BasePostResponse extends Response{
  int sent ;
  int total ;

  BasePostResponse({this.sent, this.total});
}