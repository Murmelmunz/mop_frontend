class Value {
  String name;

  Value(this.name);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': this.name,
  };

  factory Value.fromJson(Map<String, dynamic> json) => new Value(
    json['name'],
  );
}