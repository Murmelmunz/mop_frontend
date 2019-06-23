class User {
  int id;
  String name;
  String password;
  Map<String, String> categories;

  User(this.id, this.name, this.password);

  Map<String, dynamic> toJson() => <String, dynamic>{
//    'id': this.id,
    'name': this.name,
    'password': this.password,
    'roomPassword': "test",
  };

  factory User.fromJson(Map<String, dynamic> json) => new User(
    json['id'],
    json['name'],
    json['password'],
  );
}