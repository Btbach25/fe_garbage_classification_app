class Profile {
  String? name;
  int? user;
  Null? birthday;
  Null? address;
  Null? avatar;
  int? id;
  String? email;

  Profile(
      {this.name,
      this.user,
      this.birthday,
      this.address,
      this.avatar,
      this.id,
      this.email});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    user = json['user'];
    birthday = json['birthday'];
    address = json['address'];
    avatar = json['avatar'];
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user'] = this.user;
    data['birthday'] = this.birthday;
    data['address'] = this.address;
    data['avatar'] = this.avatar;
    data['id'] = this.id;
    data['email'] = this.email;
    return data;
  }
}