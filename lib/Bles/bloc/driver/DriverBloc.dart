import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/driver/DriverCreateRequest.dart';
import 'package:phinex/Bles/Model/responses/driver/DriverCreateDetailsResponse.dart';
import 'package:phinex/utils/base/BaseBloc.dart';
import '../../ApiRoutes.dart';

class DriverBloc extends BaseBloc {
  BehaviorSubject<DriverCreateDetailsResponse> _getCreateDetails =
      BehaviorSubject<DriverCreateDetailsResponse>();

  Future<Response> createDriver(DriverCreateRequest request) async {
    return await repository.post(ApiRoutes.driverCreate, request.toJson());
  }

  getDriverCreateDetails() async {
    loading.value = true;
    get.value = await repository.get(ApiRoutes.driverCreateDetails);
    _getCreateDetails.value =
        DriverCreateDetailsResponse.fromMap(get.value.data);
    loading.value = false;
  }

  @override
  dispose() {
    super.dispose();
    _getCreateDetails.close();
  }

  @override
  clear() {
    super.clear();
    _getCreateDetails = BehaviorSubject<DriverCreateDetailsResponse>();
  }

  BehaviorSubject<DriverCreateDetailsResponse> get getCreateDetails =>
      _getCreateDetails;
}

final driverBloc = DriverBloc();
