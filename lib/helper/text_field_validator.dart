mixin Validator{
  validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value.isNotEmpty) {
      if (regex.hasMatch(value)) {
        return null;
      }
      else {
        return "Enter a valid email address";
      }
    }
    else{
      return "Please Enter Email";
  }
  }
  validatePassword(String value)  {

  }
}