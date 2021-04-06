import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/responses/medical_service/medical_service/MedicalServiceLanding.dart';
import 'package:phinex/Bles/Repository/medical/MedicalServiceRepository.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

class MedicalBloc extends BaseBloc {
  final MedicalServiceRepository _repository = MedicalServiceRepository();

  BehaviorSubject<MedicalServiceLanding> _landing =
      BehaviorSubject<MedicalServiceLanding>();

  getLanding() async {
    loading.value = true;
    MedicalServiceLanding response = await _repository.getLanding();

    _landing.value = response;
    loading.value = false;
  }

  dispose() {
    _landing.close();
  }

  clear() {
    _landing = BehaviorSubject<MedicalServiceLanding>();
  }

  BehaviorSubject<MedicalServiceLanding> get landing => _landing;
}

final medicalBloc = MedicalBloc();
