class User {
  int id;
  String name;
  Map<String, String> categories;

  User(this.id, this.name);

  Map<String, dynamic> toJson() => <String, dynamic>{
//    'id': this.id,
    'name': this.name,
  };

  factory User.fromJson(Map<String, dynamic> json) => new User(
    json['id'],
    json['name'],
  );
}