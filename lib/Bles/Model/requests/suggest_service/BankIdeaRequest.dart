class SuggestServiceRequest {
  String title;
  String full_name;
  String description;
  String phone;
  String email;

  SuggestServiceRequest({
    this.title,
    this.full_name,
    this.description,
    this.phone,
    this.email,
  });

  Map toJson() => {
        "phone": this.phone,
        "email": this.email,
        "description": this.description,
        "title": this.title,
        "full_name": this.full_name,
      };
}
