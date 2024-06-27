class Country {
  final String? name;
  final String? code;

  const Country({
    this.name,
    this.code,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        code: json["code"],
      );
}
