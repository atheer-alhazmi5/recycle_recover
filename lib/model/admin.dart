class Admin {
  String? email;
  String? id;
  String? password;
  String? username;
  String? image;

  Admin({this.email, this.id, this.password, this.username, this.image});

  Admin.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    password = json['password'];
    username = json['username'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['id'] = this.id;
    data['password'] = this.password;
    data['username'] = this.username;
    data['image'] = this.image;
    return data;
  }
}
