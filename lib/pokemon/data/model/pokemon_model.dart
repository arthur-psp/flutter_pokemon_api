import 'package:app_podemon/pokemon/core/domain/model/pokemon.dart';

class PokemonModel extends Pokemon {
  PokemonModel({
    required super.id,
    required super.name,
    required super.weight,
    super.height,
    super.baseExperience,
    super.imageFrontDefault
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
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