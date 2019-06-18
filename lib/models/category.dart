class Category {
  String name;

  Category(this.name);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': this.name,
  };

  factory Category.fromJson(Map<String, dynamic> json) => new Category(
    json['name'],
  );
}