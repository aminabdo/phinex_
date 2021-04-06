import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/responses/medical_service/medical_service/MedicalServiceLanding.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class MedicalServicesApiProvider extends BaseApiProvider {
  Future<MedicalServiceLanding> getMedicalServiceLanding() async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.medicalLanding),
          options: options);

      return MedicalServiceLanding.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
