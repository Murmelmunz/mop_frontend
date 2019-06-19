import 'package:speechlist/models/value.dart';

import 'category.dart';

class Room {
  int roomId;
  String topic;
  String meetingPoint;
  String date;
  String time;
  String password;
  List<Category> categories;

  Room(this.roomId, this.topic, this.meetingPoint, this.date, this.time, this.categories) {
    this.topic ??= "";
    this.password ??= "";
    this.categories ??= List<Category>();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
//    'roomId': this.roomId,
    'name': this.topic,
    'meetingPoint': this.meetingPoint,
    'date': this.date,
    'time': this.time,
    'password': this.password,
    'categories': this.categories,
  };

  factory Room.fromJson(Map<String, dynamic> json) => new Room(
    json['roomId'],
    json['name'], // topic
    json['meetingPoint'],
    json['date'],
    json['time'],
    (json['categories'] as List)?.map((i) {

      List<Value> values = (i['values'] as List)?.map(
        (item) => Value("${ item['value'] }")
      )?.toList();

      return Category("${ i['name'] }", values);
    })?.toList(),
  );

//  @override
//  String toString() {
//    return '{token: $token, id: $id}';
//  }
}