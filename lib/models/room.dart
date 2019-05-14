class Room {
  int roomId;
  String topic;
  String meetingPoint;

  Room(this.roomId, this.topic, this.meetingPoint);

  Map<String, dynamic> toJson() => <String, dynamic>{
//    'roomId': this.roomId,
    'topic': this.topic,
    'meetingPoint': this.meetingPoint
  };

  factory Room.fromJson(Map<String, dynamic> json) => new Room(
    json['roomId'],
    json['topic'],
    json['meetingPoint'],
  );

//  @override
//  String toString() {
//    return '{token: $token, id: $id}';
//  }
}