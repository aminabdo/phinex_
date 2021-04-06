
class BookNowRequest {
  String datetime;
  String doctorId;
  String notes;
  String userId;
  String clinicId;

  BookNowRequest({this.datetime, this.doctorId, this.notes, this.userId, this.clinicId});

  static BookNowRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookNowRequest bookNowRequestBean = BookNowRequest();
    bookNowRequestBean.datetime = map['datetime'];
    bookNowRequestBean.doctorId = map['doctor_id'];
    bookNowRequestBean.notes = map['notes'];
    bookNowRequestBean.userId = map['user_id'];
    bookNowRequestBean.clinicId = map['clinic_id'];
    return bookNowRequestBean;
  }

  Map toJson() => {
    "datetime": datetime,
    "doctor_id": doctorId,
    "notes": notes,
    "user_id": userId,
    "clinic_id": clinicId,
  };
}