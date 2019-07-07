import 'package:speechlist/models/value.dart';

import 'category.dart';

class User {
  int id;
  String name;
  String password;
  List<Category> categories;

  User(this.id, this.name, this.password) {
    this.categories ??= List<Category>();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
//    'id': this.id,
    'name': this.name,
    'password': this.password,
    'roomPassword': "test",
    'categories': this.categories,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['userId'],
      json['name'],
      json['password'],
    )..categories = (json['categories'] as List)?.map((i) {

      List<Value> values = (i['values'] as List)?.map(
              (item) => Value("${ item['value'] }")
      )?.toList();

      return Category("${ i['name'] }", values);
    })?.toList();
  }
}