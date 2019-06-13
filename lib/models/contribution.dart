enum Type {
  contribution, question, answer
}

class Contribution {
  int id;
  Type type;
  int userId;

  Contribution(this.type);

  Map<String, dynamic> toJson() => <String, dynamic>{
//    'id': this.id,
//    'name': this.name,
    'type': this.type,
  };

  factory Contribution.fromJson(Map<String, dynamic> json) => new Contribution(
//    json['id'],
//    json['name'],
    json['type'],
  );
}