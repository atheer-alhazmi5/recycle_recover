import 'package:recycle_recover/model/user.dart';

class Order {
  int? amount;
  String? namefactor;
  String? iduser;
  bool? apply;
  bool? applyfactor;
  List<String>? material;
  String? userPhone;
  User? user;
  String? id;

  Order(
      {this.amount,
      this.namefactor,
      this.iduser,
      this.apply,
      this.applyfactor,
      this.material,
      this.userPhone,
      this.user,
      this.id});

  Order.fromJson(Map<String, dynamic> json, String id) {
    amount = json['amount'];
    namefactor = json['namefactor'];
    iduser = json['iduser'];
    apply = json['apply'];
    applyfactor = json['applyfactor'];
    material = json['material'].cast<String>();
    userPhone = json['userPhone'];
    this.id = id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['namefactor'] = this.namefactor;
    data['iduser'] = this.iduser;
    data['apply'] = this.apply;
    data['applyfactor'] = this.applyfactor;
    data['material'] = this.material;

    return data;
  }
}
