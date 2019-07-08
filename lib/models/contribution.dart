class Contribution {
  int id;
  String type;
  String name;
  int userId;

  Contribution(this.id, this.type, this.name, this.userId);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': this.id,
    'type': this.type,
    'name': this.name,
    'userId': this.userId,
  };

  factory Contribution.fromJson(Map<String, dynamic> json) => new Contribution(
    json['contributionId'],
    json['art'],
    json['name'],
    json['userId'],
  );
}