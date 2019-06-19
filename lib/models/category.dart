import 'package:speechlist/models/value.dart';

class Category {
  String name;
  List<Value> values;

  Category(this.name, this.values) {
    this.values ??= List<Value>();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': this.name,
    'values': this.values,
  };

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    json['name'],
    (json['values'] as List)?.map((i) {
      return Value("${ i['value'] }");
    })?.toList(),
  );
}