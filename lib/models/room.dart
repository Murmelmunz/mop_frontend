class Room {
  int roomId;
  String topic;
  String meetingPoint;
  String date;
  String time;
  String password;
  List<List<String>> categories;

  Room(this.roomId, this.topic, this.meetingPoint, this.date, this.time) {
    this.categories ??= List<List<String>>();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
//    'roomId': this.roomId,
    'topic': this.topic,
    'meetingPoint': this.meetingPoint,
    'date': this.date,
    'time': this.time,
    'password': this.password,
    'categories': this.categories,
  };

  factory Room.fromJson(Map<String, dynamic> json) => new Room(
    json['roomId'],
    json['topic'],
    json['meetingPoint'],
    json['date'],
    json['time'],
    // TODO: parse categories
  );

//  @override
//  String toString() {
//    return '{token: $token, id: $id}';
//  }
}