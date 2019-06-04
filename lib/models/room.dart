class Room {
  int roomId;
  String topic;
  String meetingPoint;
  String date;
  String time;

  Room(this.roomId, this.topic, this.meetingPoint, this.date, this.time);

  Map<String, dynamic> toJson() => <String, dynamic>{
//    'roomId': this.roomId,
    'topic': this.topic,
    'meetingPoint': this.meetingPoint,
    'date': this.date,
    'time': this.time,
  };

  factory Room.fromJson(Map<String, dynamic> json) => new Room(
    json['roomId'],
    json['topic'],
    json['meetingPoint'],
    json['date'],
    json['time'],
  );

//  @override
//  String toString() {
//    return '{token: $token, id: $id}';
//  }
}