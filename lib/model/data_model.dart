import 'package:flutter/cupertino.dart';

class DataModel {
  String id;
  String name;
  String email;
  String phone;

  DataModel({@required this.name, @required this.email, @required this.id, @required this.phone});
  factory DataModel.fromMap(Map<String, dynamic> recvData) {
    return DataModel(name: recvData['name'], email: recvData['email'], id: recvData['id'], phone: recvData['phone']);
  }
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'phone': phone};
  }
}
