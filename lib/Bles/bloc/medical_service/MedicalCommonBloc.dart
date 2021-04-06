import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/medical/BookNowRequest.dart';
import 'package:phinex/Bles/Model/responses/medical_service/common/ClinicLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/common/CommonPaginResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/common/CommonSingleResponse.dart';
import 'package:phinex/Bles/Repository/medical/CommonRepository.dart';
import 'package:phinex/utils/base/BaseBloc.dart';
import 'package:phinex/utils/consts.dart';

class MedicalCommonBloc extends BaseBloc {
  final MedicalCommonRepository _repository = MedicalCommonRepository();

  BehaviorSubject<CommonPaginResponse> _landing =
      BehaviorSubject<CommonPaginResponse>();
  BehaviorSubject<CommonPaginResponse> _clinics =
      BehaviorSubject<CommonPaginResponse>();
  BehaviorSubject<CommonSingleResponse> _single =
      BehaviorSubject<CommonSingleResponse>();
  BehaviorSubject<ClinicLandingResponse> _clinicsLanding =
      BehaviorSubject<ClinicLandingResponse>();
  BehaviorSubject<Response> _book = BehaviorSubject<Response>();


  getClinicByCat(BaseRequestSkipTake request) async {
    loading.value = true;
    CommonPaginResponse response = await _repository.getCommonPagin(
        request, MedicalObjectName.CLINIC_SPECIALTY + request.id.toString());

    _clinics.value = response;
    print("CommonBloc request landing -->> " + request.toString());
    loading.value = false;
  }

  getLanding(BaseRequestSkipTake request, String objName) async {
    loading.value = true;
    CommonPaginResponse response =
        await _repository.getCommonPagin(request, objName);

    _landing.value = response;
    print("CommonBloc request landing -->> " + request.toString());
    loading.value = false;
  }

  getSingle(int id, String objName) async {
    loading.value = true;

    CommonSingleResponse response =
        await _repository.getCommonSingle(id, objName);

    _single.value = response;

    loading.value = false;
  }

  getClinic(String objName) async {
    loading.value = true;

    ClinicLandingResponse response =
        await _repository.getClinicLanding(objName);

    _clinicsLanding.value = response;
    loading.value = false;
  }

  bookNow(BookNowRequest request) async {
    loading.value = true;

    Response response = await _repository.bookNow(request);

    _book.value = response;
    loading.value = false;

    return response;

  }

  dispose() {
    _landing.close();
    _clinicsLanding.close();
    _single.close();
    _clinics.close();
    _book.close();
  }

  clear() {
    _landing = BehaviorSubject<CommonPaginResponse>();
    _clinics = BehaviorSubject<CommonPaginResponse>();
    _single = BehaviorSubject<CommonSingleResponse>();
    _clinicsLanding = BehaviorSubject<ClinicLandingResponse>();
    _book = BehaviorSubject<Response>();
  }

  BehaviorSubject<CommonPaginResponse> get landing => _landing;

  BehaviorSubject<CommonPaginResponse> get clinics => _clinics;

  BehaviorSubject<CommonSingleResponse> get single => _single;

  BehaviorSubject<ClinicLandingResponse> get clinicsLanding => _clinicsLanding;

  BehaviorSubject<Response> get book => _book;


}

final commonBloc = MedicalCommonBloc();
