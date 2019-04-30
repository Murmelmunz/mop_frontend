class Room {
  final String id;

  String topic;
  String meetingPoint;

  Room(this.id, this.topic, this.meetingPoint);

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'id': this.id,
    'topic': this.topic,
    'meetingPoint': this.meetingPoint
  };

  factory Room.fromJSON(Map<String, dynamic> json) => new Room(
    json['id'],
    json['topic'],
    json['meetingPoint'],
  );

//  @override
//  String toString() {
//    return '{token: $token, id: $id}';
//  }
}