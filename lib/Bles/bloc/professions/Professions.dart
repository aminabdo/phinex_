import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/proffession/professionBookNowRequest.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionCreateDetailsResponse.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsByCatResponse.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsByUserResponse.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsSearchResponse.dart';
import 'package:phinex/Bles/Repository/ProfessionsRepository.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/base/BaseBloc.dart';
import 'package:phinex/utils/base/BaseRequest.dart';

import '../../ApiRoutes.dart';

class ProfessionsBloc extends BaseBloc {
  final ProfessionsRepository _repository = ProfessionsRepository();

  BehaviorSubject<ProfessionsLandingResponse> _landing =
      BehaviorSubject<ProfessionsLandingResponse>();
  BehaviorSubject<ProfessionsByCatResponse> _getByCat =
      BehaviorSubject<ProfessionsByCatResponse>();
  BehaviorSubject<ProfessionsByUserResponse> _single =
      BehaviorSubject<ProfessionsByUserResponse>();
  BehaviorSubject<ProfessionsSearchResponse> _search =
      BehaviorSubject<ProfessionsSearchResponse>();
  BehaviorSubject<ProfessionCreateDetailsResponse> _professionCreateDetails =
      BehaviorSubject<ProfessionCreateDetailsResponse>();

  getLanding() async {
    loading.value = true;
    ProfessionsLandingResponse response =
        await _repository.getProfessionsLanding();
    _landing.value = response;
    loading.value = false;
  }

  getByCatID(BaseRequestSkipTake request) async {
    loading.value = true;

    ProfessionsByCatResponse response =
        await _repository.getProfessionsByCat(request);

    _getByCat.value = response;
    loading.value = false;
  }

  getSingle(int id) async {
    loading.value = true;

    ProfessionsByUserResponse response =
        await _repository.getProfessionsSingle(id);

    _single.value = response;
    loading.value = false;
  }

  getSearch(String search) async {
    loading.value = true;

    ProfessionsSearchResponse response =
        await _repository.getProfessionsSearch(search);

    _search.value = response;
    loading.value = false;
  }

  createProfession(BaseRequest request) async {
    loading.value = true;
    create.value =
        await _repository.post(ApiRoutes.professionsCreate, request.toJson());
    loading.value = false;
  }

  getCreateDetails() async {
    loading.value = true;
    get.value = await _repository.get(ApiRoutes.professionsCreateDetails);
    _professionCreateDetails.value =
        ProfessionCreateDetailsResponse.fromMap(get.value.data);
    loading.value = false;
  }

  Future<Response> bookNow(ProfessionBookNowRequest request) async {
    return await Dio().post(
      'https://technicians.appointments.phinex.net/v1/tech-appointments',
      data: request.toMap(),
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
        headers: {
          'Authorization': AppUtils.userData?.token?.trim() ?? '',
          'content-type': 'application/x-www-form-urlencoded'
        },
      ),
    );
  }

  dispose() {
    super.dispose();
    _professionCreateDetails.close();
    _landing.close();
    _getByCat.close();
    _single.close();
    _search.close();
  }

  clear() {
    super.clear();
    _professionCreateDetails =
        BehaviorSubject<ProfessionCreateDetailsResponse>();
    _landing = BehaviorSubject<ProfessionsLandingResponse>();
    _getByCat = BehaviorSubject<ProfessionsByCatResponse>();
    _single = BehaviorSubject<ProfessionsByUserResponse>();
    _search = BehaviorSubject<ProfessionsSearchResponse>();
  }

  BehaviorSubject<ProfessionsLandingResponse> get landing => _landing;

  BehaviorSubject<ProfessionsByCatResponse> get getByCat => _getByCat;

  BehaviorSubject<ProfessionsByUserResponse> get single => _single;

  BehaviorSubject<ProfessionsSearchResponse> get search => _search;

  BehaviorSubject<ProfessionCreateDetailsResponse>
      get professionCreateDetails => _professionCreateDetails;
}

// amin
final professionsBloc = ProfessionsBloc();
