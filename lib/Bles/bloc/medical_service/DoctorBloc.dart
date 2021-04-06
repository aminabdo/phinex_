import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/froms/DoctorFormRequest.dart';
import 'package:phinex/Bles/Model/requests/medical/BookNowRequest.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorBookNowResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorBySpecialityResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorDetailsCreateResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorLanding.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorReviewsResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorSingleResponse.dart';
import 'package:phinex/Bles/Repository/medical/DoctorRepository.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

import '../../ApiRoutes.dart';

class DoctorBloc extends BaseBloc {
  final DoctorRepository _repository = DoctorRepository();

  BehaviorSubject<DoctorLanding> _landing = BehaviorSubject<DoctorLanding>();
  BehaviorSubject<DoctorBySpecialityResponse> _getByCat =
      BehaviorSubject<DoctorBySpecialityResponse>();
  BehaviorSubject<DoctorSingleResponse> _single =
      BehaviorSubject<DoctorSingleResponse>();
  BehaviorSubject<DoctorBookNowResponse> _book =
      BehaviorSubject<DoctorBookNowResponse>();
  BehaviorSubject<DoctorReviewsResponse> _reviews =
      BehaviorSubject<DoctorReviewsResponse>();
  BehaviorSubject<DoctorDetailsCreateResponse> _doctorCreateDetails =
      BehaviorSubject<DoctorDetailsCreateResponse>();
  BehaviorSubject<Response> _create = BehaviorSubject<Response>();

  getLanding() async {
    loading.value = true;
    DoctorLanding response = await _repository.getDoctorLanding();

    _landing.value = response;
    loading.value = false;
  }

  getByCatID(BaseRequestSkipTake request) async {
    loading.value = true;

    DoctorBySpecialityResponse response =
        await _repository.getDoctorByCat(request);

    _getByCat.value = response;
    loading.value = false;
  }

  getSingle(int id) async {
    loading.value = true;

    DoctorSingleResponse response = await _repository.getDoctorSingle(id);

    _single.value = response;
    loading.value = false;
  }

  Future<void> bookNow(BookNowRequest request) async {
    DoctorBookNowResponse response = await _repository.bookNow(request);

    _book.value = response;
  }

  getMoreReviews(BaseRequestSkipTake request) async {
    loading.value = true;

    DoctorReviewsResponse response =
        await _repository.getDoctorReviews(request);

    _reviews.value = response;

    loading.value = false;
  }

  getCreateDetails() async {
    loading.value = true;
    get.value = await _repository.get(ApiRoutes.doctorCreateDetails);
    _doctorCreateDetails.value =
        DoctorDetailsCreateResponse.fromMap(get.value.data);
    loading.value = false;
  }

  createDoctor(DoctorFormRequest request) async {
    loading.value = true;

    debugPrint("DoctorBloc post request ---->>>>>>   ");
    debugPrint(request.toString());

    create.value =
        await _repository.post(ApiRoutes.doctorCreate, request.toJson());

    loading.value = false;
  }

  dispose() {
    super.dispose();
    _landing.close();
    _getByCat.close();
    _single.close();
    _book.close();
    _reviews.close();
    _doctorCreateDetails.close();
    _create.close();
  }

  clear() {
    super.clear();
    _landing = BehaviorSubject<DoctorLanding>();
    _getByCat = BehaviorSubject<DoctorBySpecialityResponse>();
    _single = BehaviorSubject<DoctorSingleResponse>();
    _book = BehaviorSubject<DoctorBookNowResponse>();
    _reviews = BehaviorSubject<DoctorReviewsResponse>();
    _create = BehaviorSubject<Response>();
    _doctorCreateDetails = BehaviorSubject<DoctorDetailsCreateResponse>();
  }

  BehaviorSubject<DoctorLanding> get landing => _landing;

  BehaviorSubject<DoctorBySpecialityResponse> get getByCat => _getByCat;

  BehaviorSubject<DoctorSingleResponse> get single => _single;

  BehaviorSubject<DoctorBookNowResponse> get book => _book;

  BehaviorSubject<DoctorReviewsResponse> get reviews => _reviews;

  get create => _create;

  BehaviorSubject<DoctorDetailsCreateResponse> get doctorCreateDetails =>
      _doctorCreateDetails;
}

final doctorBloc = DoctorBloc();
