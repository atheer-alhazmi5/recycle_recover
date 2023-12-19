class User {
  String? address;
  String? email;
  String? id;
  String? password;
  String? phone;
  String? username;
  String? image;

  User(
      {this.address,
      this.email,
      this.id,
      this.password,
      this.phone,
      this.username,
      this.image});

  User.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    email = json['email'];
    id = json['id'];
    password = json['password'];
    phone = json['phone'];
    username = json['username'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['email'] = this.email;
    data['id'] = this.id;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['username'] = this.username;
    data['image'] = this.image;
    return data;
  }
}
