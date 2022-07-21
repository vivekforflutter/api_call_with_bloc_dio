class UserDetailsResponseModel {
  String? id;
  int? page;
  int? perPage;
  int? totalrecord;
  int? totalPages;
  List<Data>? data;

  UserDetailsResponseModel(
      {this.id,
        this.page,
        this.perPage,
        this.totalrecord,
        this.totalPages,
        this.data});



  UserDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    page = json['page'];
    perPage = json['per_page'];
    totalrecord = json['totalrecord'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$id'] = id;
    data['page'] = page;
    data['per_page'] = perPage;
    data['totalrecord'] = totalrecord;
    data['total_pages'] = totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  int? iD;
  String? name;
  String? email;
  String? profilepicture;
  String? location;
  String? createdat;

  Data(
      {this.id,
        this.iD,
        this.name,
        this.email,
        this.profilepicture,
        this.location,
        this.createdat});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profilepicture = json['profilepicture'];
    location = json['location'];
    createdat = json['createdat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$id'] = id;
    data['id'] = iD;
    data['name'] = name;
    data['email'] = email;
    data['profilepicture'] = profilepicture;
    data['location'] = location;
    data['createdat'] = createdat;
    return data;
  }
}
