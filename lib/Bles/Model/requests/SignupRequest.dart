class SignupRequest {
  final String first_name;
  final String last_name;
  final String phone;
  final String password;
  final String type;
  final String chanel;

  SignupRequest(this.first_name, this.last_name, this.phone, this.password,
      this.type, this.chanel);

  SignupRequest.fromJson(Map<String, dynamic> json)
      : first_name = json['first_name'],
        last_name = json['last_name'],
        phone = json['phone'],
        password = json['password'],
        type = json['type'],
        chanel = json['chanel'];

  Map<String, dynamic> toJson() => {
        'first_name': first_name,
        'last_name': last_name,
        'phone': phone,
        'password': password,
        'type': type,
        'chanel': chanel,
      };
}
