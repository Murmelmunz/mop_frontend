import 'category.dart';

class EvaluatedContribution {
  int id;
  String type;
  String name;
  int userId;
  int roomId;
  int time;
  String timeStart;
  String timeStop;
  List<Category> categories;

  EvaluatedContribution(this.id, this.type, this.name, this.userId, this.roomId,
      this.time, this.timeStart, this.timeStop, this.categories) {
    time ??= 0;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': this.id,
    'type': this.type,
    'name': this.name,
    'userId': this.userId,
    'roomId': this.roomId,
    'time': this.time,
    'timeStart': this.timeStart,
    'timeStop': this.timeStop,
    'categories': this.categories,
  };

  factory EvaluatedContribution.fromJson(Map<String, dynamic> json) => EvaluatedContribution(
    json['contributionId'],
    json['art'],
    json['name'],
    json['userId'],
    json['roomId'],
    json['time'],
    json['timeStart'],
    json['timeStop'],
    (json['categories'] as List)?.map((m) => Category.fromJson(m))?.toList(),
  );
}