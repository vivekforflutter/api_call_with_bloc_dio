class UserModalRequest{
  String id;

  UserModalRequest(this.id);
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id'  : id.trim(),

    };
    return map;
  }
}