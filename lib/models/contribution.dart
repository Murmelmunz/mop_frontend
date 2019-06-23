class Contribution {
  int id;
  String type;
  String name;

  Contribution(this.id, this.type, this.name);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': this.id,
    'type': this.type,
    'userId': this.name,
  };

  factory Contribution.fromJson(Map<String, dynamic> json) => new Contribution(
    json['id'],
    json['type'],
    json['userId'],
  );
}