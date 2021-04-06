import 'package:dio/dio.dart';
import 'package:rxdart/subjects.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacyLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacyProductsResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacyReviewResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacySingleResponse.dart';
import 'package:phinex/Bles/Repository/medical/PharmacyRepository.dart';
import 'package:phinex/utils/base/BaseBloc.dart';
import 'package:phinex/utils/base/BaseRequest.dart';

import '../../ApiRoutes.dart';

class PharmacyBloc extends BaseBloc {
  final PharmacyRepository _repository = PharmacyRepository();

  BehaviorSubject<PharmacyLandingResponse> _landing =
      BehaviorSubject<PharmacyLandingResponse>();
  BehaviorSubject<PharmacyLandingResponse> _pharmacies =
      BehaviorSubject<PharmacyLandingResponse>();
  BehaviorSubject<PharmacySingleResponse> _single =
      BehaviorSubject<PharmacySingleResponse>();
  BehaviorSubject<PharmacyProductsResponse> _products =
      BehaviorSubject<PharmacyProductsResponse>();
  BehaviorSubject<PharmacyReviewsResponse> _reviews =
      BehaviorSubject<PharmacyReviewsResponse>();
  BehaviorSubject<Response> _create = BehaviorSubject<Response>();

  getLanding(BaseRequestSkipTake request) async {
    loading.value = true;
    PharmacyLandingResponse response =
        await _repository.getPharmacyLanding(request);

    _landing.value = response;
    print("PharmacyBloc request landing -->> " + request.toString());
    loading.value = false;
  }

  getPharmacies(BaseRequestSkipTake request) async {
    loading.value = true;

    PharmacyLandingResponse response = await _repository.getPharmacies(request);

    _landing.value = response;

    loading.value = false;
  }

  getSingle(int id) async {
    loading.value = true;

    PharmacySingleResponse response = await _repository.getPharmacySingle(id);

    _single.value = response;
    loading.value = false;
  }

  getMoreReviews(BaseRequestSkipTake request) async {
    loading.value = true;

    PharmacyReviewsResponse response =
        await _repository.getPharmacyReviews(request);

    _reviews.value = response;

    loading.value = false;
  }

  getMoreProducts(BaseRequestSkipTake request) async {
    loading.value = true;

    PharmacyProductsResponse response =
        await _repository.getPharmacyProducts(request);

    _products.value = response;

    loading.value = false;
  }

  createPharmacist(BaseRequest request) async {
    loading.value = true;

    print(request.toJson());

    Response response =
        await _repository.post(ApiRoutes.pharmacyCreate, request.toJson());
    print(response.toString());
    _create.value = response;

    loading.value = false;
  }

  dispose() {
    _landing.close();
    _pharmacies.close();
    _single.close();
    _products.close();
    _reviews.close();
    _create.close();
  }

  clear() {
    _landing = BehaviorSubject<PharmacyLandingResponse>();
    _pharmacies = BehaviorSubject<PharmacyLandingResponse>();
    _single = BehaviorSubject<PharmacySingleResponse>();
    _products = BehaviorSubject<PharmacyProductsResponse>();
    _reviews = BehaviorSubject<PharmacyReviewsResponse>();
    _create = BehaviorSubject<Response>();
  }

  BehaviorSubject<PharmacyLandingResponse> get landing => _landing;

  BehaviorSubject<PharmacyLandingResponse> get pharmacies => _pharmacies;

  BehaviorSubject<PharmacySingleResponse> get single => _single;

  BehaviorSubject<PharmacyProductsResponse> get products => _products;

  BehaviorSubject<PharmacyReviewsResponse> get reviews => _reviews;

  BehaviorSubject<Response<dynamic>> get create => _create;
}

final pharmacyBloc = PharmacyBloc();
