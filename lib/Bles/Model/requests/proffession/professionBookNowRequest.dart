import 'package:flutter/cupertino.dart';

class ProfessionBookNowRequest {
  int userId;
  int technicianId;
  int workshopId;
  String datetime;
  int queue_number;
  String notes;

  ProfessionBookNowRequest({
    @required this.userId,
    @required this.technicianId,
    @required this.workshopId,
    @required this.datetime,
    this.queue_number = 55,
    this.notes = '',
  });

  Map<String, dynamic> toMap() {
    return {
      "queue_number": this.queue_number,
      "notes": this.notes,
      "workshop_id": this.workshopId,
      "technician_id": this.technicianId,
      "user_id": this.userId,
      "datetime": this.datetime,
    };
  }
}
