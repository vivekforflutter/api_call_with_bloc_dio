class RegisterRequestModel{
  String name;
  String email;
  String password;

  RegisterRequestModel(this.name, this.email, this.password);
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name'  : name.trim(),
      'email' : email.trim(),
      'password' : password.trim()
    };
    return map;
  }
}