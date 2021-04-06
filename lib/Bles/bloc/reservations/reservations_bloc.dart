import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/responses/reservations/tech_reservations_model.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

import '../../ApiRoutes.dart';

class ReservationBloc extends BaseBloc {
  BehaviorSubject<TechReservationsModel> _techReservation = BehaviorSubject<TechReservationsModel>();

  getTechReservations(dynamic userId) async {
    _techReservation.value = TechReservationsModel();
    TechReservationsModel response;
    response = TechReservationsModel.fromJson(
      await (await repository.get(ApiRoutes.techReservations(userId))).data,
    );

    _techReservation.value = response;
    _techReservation.value = _techReservation.value;
  }

  BehaviorSubject<TechReservationsModel> get techReservation => _techReservation;
}

final reservationBloc = ReservationBloc();
