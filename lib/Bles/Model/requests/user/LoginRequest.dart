class LoginRequest {
  final String phone;
  final String password;

  LoginRequest(this.phone, this.password);

  LoginRequest.fromJson(Map<String, dynamic> json)
      : phone = json['phone'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'password': password
  };
}
