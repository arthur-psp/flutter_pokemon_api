class Pokemon {
  int? id;
  String? name;
  int? height;
  int? baseExperience;
  String? imageFrontDefault;
  int? weight;

  Pokemon({
    required this.id,
    required this.name,
    required this.weight,
    this.height,
    this.baseExperience,
    this.imageFrontDefault,
  });
}