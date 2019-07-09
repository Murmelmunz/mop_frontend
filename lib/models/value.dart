class Value {
  String value;
  int time = 0;

  Value(this.value);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'value': this.value,
  };

  factory Value.fromJson(Map<String, dynamic> json) => new Value(
    json['value'],
  );
}