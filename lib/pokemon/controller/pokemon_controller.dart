import 'package:app_podemon/pokemon/core/domain/model/pokemon.dart';
import 'package:app_podemon/pokemon/core/domain/usecase/filtrar_pokemons_usecase.dart';
import 'package:app_podemon/pokemon/core/domain/usecase/listar_pokemons_usecase.dart';

class PokemonController {
  final ListarPokemonsUsecase listarPokemonsUsecase;
  final FilteredPokemonsUseCase filteredPokemonsUseCase;
  bool loading = false;
  List<Pokemon> pokemons = [];
  List<Pokemon> filteredPokemons = [];

  Function setState;

  PokemonController({ required this.listarPokemonsUsecase, required this.filteredPokemonsUseCase, required this.setState });

  Future listarPokemons() async {
    loading = true;
    setState(() {});
    pokemons = await listarPokemonsUsecase();
    filteredPokemons = List.from(pokemons);
    loading = false;
    setState(() {});
  }

  void filterPokemons(String value) async {
    filteredPokemons = filteredPokemonsUseCase(pokemons, value);
    setState(() {});
  }
}