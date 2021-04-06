class MakeRateRequest {
  final String comment;
  final int object_id;
  final String object_name;
  final double rate;
  final int user_id;

  MakeRateRequest(
      this.comment, this.object_id, this.object_name, this.rate, this.user_id);

  MakeRateRequest.fromJson(Map<String, dynamic> json)
      : comment = json['comment'],
        object_id = json['object_id'],
        object_name = json['object_name'],
        rate = json['rate'],
        user_id = json['user_id'];

  Map<String, dynamic> toJson() => {
        'comment': comment,
        'object_id': object_id,
        'object_name': object_name,
        'rate': rate,
        'user_id': user_id,
      };
}
