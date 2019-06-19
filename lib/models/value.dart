class Value {
  String value;

  Value(this.value);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'value': this.value,
  };

  factory Value.fromJson(Map<String, dynamic> json) => new Value(
    json['value'],
  );
}