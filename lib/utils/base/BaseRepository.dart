import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:phinex/Bles/Model/requests/rate/MakeRateRequest.dart';
import 'package:phinex/Bles/Model/responses/rating/make_rate/make_rate_response.dart';
import 'package:phinex/Bles/api_provider/BaseApiProvider.dart';

import 'BaseRequest.dart';

class BaseRepository {
  BaseApiProvider _apiProvider = BaseApiProvider();

  Future<Response> get(String urlExtention) async {
    Response response = await _apiProvider.generalGet(urlExtention);
    return response;
  }

  Future<Response> get2(String urlExtention) async {
    Response response = await _apiProvider.generalGet2(urlExtention);
    return response;
  }

  Future<Response> get3(String urlExtention) async {
    Response response = await _apiProvider.generalGet3(urlExtention);
    return response;
  }

  Future<Response> delete(String urlExtention) async {
    Response response = await _apiProvider.generalDelete(urlExtention);
    return response;
  }

  Future<Response> post(String urlExtention, Map<dynamic, dynamic> request) async {
    debugPrint("BaseRepository post request ---->>>>>>   ");
    debugPrint(request.toString());

    Response response = await _apiProvider.generalPost(urlExtention, request);

    debugPrint("BaseRepository post response ---->>>>>>   ");
    debugPrint(response.toString());

    return response;
  }

  Future<Response> post2(
      String urlExtention, Map<dynamic, dynamic> request) async {
    debugPrint("BaseRepository post request ---->>>>>>   ");
    debugPrint(request.toString());

    Response response = await _apiProvider.generalPost(urlExtention, request);

    debugPrint("BaseRepository post response ---->>>>>>   ");
    debugPrint(response.toString());

    return response;
  }

  Future<Response> put(
      String urlExtention, Map<dynamic, dynamic> request) async {
    debugPrint("BaseRepository post request ---->>>>>>   ");
    debugPrint(request.toString());

    Response response = await _apiProvider.generalPut(urlExtention, request);

    debugPrint("BaseRepository post response ---->>>>>>   ");
    debugPrint(response.toString());

    return response;
  }

  Future<Response> patch(
      String urlExtention, Map<dynamic, dynamic> request) async {
    debugPrint("BaseRepository patch request ---->>>>>>   ");
    debugPrint(request.toString());

    Response response = await _apiProvider.generalPatch(urlExtention, request);

    debugPrint("BaseRepository patch response ---->>>>>>   ");
    debugPrint(response.toString());

    return response;
  }

  Future<Response> postObject(String urlExtention, BaseRequest request) async {
    debugPrint("BaseRepository post request ---->>>>>>   ");
    debugPrint(request.toString());

    Response response = await _apiProvider.generalPostObject(urlExtention, request);

    debugPrint("BaseRepository post response ---->>>>>>   ");
    debugPrint(response.toString());

    return response;
  }

  Future<MakeRateResponse> makeRate(MakeRateRequest request) {
    return _apiProvider.makeProductRate(request);
  }

  Future<Response> postUpload(String urlExtention, FormData request) async {
    debugPrint("BaseRepository post request ---->>>>>>   ");
    debugPrint(request.toString());

    Response response =
        await _apiProvider.generalPostUpload(urlExtention, request);

    debugPrint("BaseRepository post response ---->>>>>>   ");
    debugPrint(response.toString());

    return response;
  }
}
