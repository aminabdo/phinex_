class BankIdeaRequest {
  String title;
  String full_name;
  String description;
  String partner_type;
  int governorate;
  int city;
  String phone;
  String email;

  BankIdeaRequest({
    this.title,
    this.full_name,
    this.description,
    this.partner_type,
    this.governorate,
    this.city,
    this.phone,
    this.email,
  });

  Map toJson() => {
        "phone": this.phone,
        "email": this.email,
        "city": this.city,
        "governorate": this.governorate,
        "description": this.description,
        "title": this.title,
        "full_name": this.full_name,
    "partner_type": this.partner_type,
      };
}
