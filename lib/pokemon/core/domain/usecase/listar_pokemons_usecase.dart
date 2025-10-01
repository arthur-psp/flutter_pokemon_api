import 'package:app_podemon/pokemon/data/model/pokemon_model.dart';
import 'package:app_podemon/pokemon/data/repository/listar_pokemons_repository.dart';

class ListarPokemonsUsecase {
  final ListarPokemonsRepository listarPokemonsRepository;

  ListarPokemonsUsecase({ required this.listarPokemonsRepository });

  Future<List<PokemonModel>> call() async {
    return await listarPokemonsRepository();
  }
}