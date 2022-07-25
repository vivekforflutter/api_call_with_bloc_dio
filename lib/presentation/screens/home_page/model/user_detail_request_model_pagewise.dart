class UserRequestModelPagewise{
  String page;

  UserRequestModelPagewise(this.page);
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'page'  : page.trim(),

    };
    return map;
  }
}