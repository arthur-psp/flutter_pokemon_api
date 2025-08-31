class Pokemon {
  int? id;
  String? name;
  int? height;
  int? baseExperience;
  String? imageFrontDefault;
  int? weight;

  Pokemon({  this.id, this.name, this.height, this.baseExperience, this.imageFrontDefault, this.weight });

  static Pokemon fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: (json['forms'] as List).isNotEmpty ? json['forms'][0]['name'] : json['name'],
      height: json['height'],
      baseExperience: json['base_experience'],
      imageFrontDefault: json['sprites']['front_default'],
      weight: json['weight']
    );
  }

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name, height: $height, baseExperience: $baseExperience, weight: $weight, image: $imageFrontDefault)';
  }
}

