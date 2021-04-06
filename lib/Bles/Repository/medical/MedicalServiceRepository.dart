
import 'package:phinex/Bles/Model/responses/medical_service/medical_service/MedicalServiceLanding.dart';
import 'package:phinex/Bles/api_provider/medical_services/MedicalServicesApiProvider.dart';

class MedicalServiceRepository {
  MedicalServicesApiProvider _apiProvider = MedicalServicesApiProvider();

  Future<MedicalServiceLanding> getLanding() {
    return _apiProvider.getMedicalServiceLanding();
  }
}
