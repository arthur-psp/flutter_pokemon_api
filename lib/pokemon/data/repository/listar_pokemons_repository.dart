import 'package:app_podemon/pokemon/data/model/pokemon_model.dart';
import 'package:app_podemon/pokemon/infra/api_pokemons.dart';

class ListarPokemonsRepository {
  final ApiPokemons apiPokemons;

  ListarPokemonsRepository({ required this.apiPokemons });

  Future<List<PokemonModel>> call() async {
    await Future.delayed(Duration(seconds: 1));
    return apiPokemons.listPokemons();
  }
}