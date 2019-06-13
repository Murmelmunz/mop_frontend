class Contribution {
  int id;
  String type;
  int userId;

  Contribution(this.id, this.type, this.userId);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': this.id,
    'type': this.type,
    'userId': this.userId,
  };

  factory Contribution.fromJson(Map<String, dynamic> json) => new Contribution(
    json['id'],
    json['type'],
    json['userId'],
  );
}