import 'package:speechlist/models/user.dart';
import 'package:speechlist/models/value.dart';

import 'category.dart';
import 'contribution.dart';

class Room {
  int roomId;
  String topic;
  String meetingPoint;
  String date;
  String time;
  String password;
  List<Category> categories;
  List<Contribution> contributions;
  List<User> participants;

  Room(this.roomId, this.topic, this.meetingPoint, this.date, this.time, this.categories, this.password, {this.contributions}) {
    this.topic ??= "";
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

  factory Room.fromJson(Map<String, dynamic> json) {
//    var allContributions = List<Contribution>();
//    (json['user'] as List)?.map((i) {
//      if (i['contribution'] != null && i['contribution']['contribution'] != null) {
//        List<Contribution> contributions = (i['contribution']['contribution'] as List)?.map(
//                (item) => Contribution(item['contributionId'], item['art'], item['name'], i['userId'])
//        )?.toList();
//
//        allContributions.addAll(contributions);
//      }
//
//      return null;
//    })?.toList();


    var allContributions = (json['contributionsAll'] as List)
        ?.map((m) => Contribution.fromJson(m))
        ?.toList();

    allContributions ??= List<Contribution>();

    return Room(
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
        json['password'],
        contributions: allContributions,
    )..participants = (json['user'] as List)?.map((i) {
      var userCategories = (i['categories'] as List)?.map((i) {

        List<Value> values = (i['values'] as List)?.map(
                (item) => Value("${ item['value'] }")
        )?.toList();

        return Category("${ i['name'] }", values);
      })?.toList();

      return User(i['userId'], i['name'], i['password'])..categories = userCategories;
    })?.toList();
  }

//  @override
//  String toString() {
//    return '{token: $token, id: $id}';
//  }
}