import 'package:app_podemon/pokemon/controller/pokemon_controller.dart';
import 'package:app_podemon/pokemon/core/domain/usecase/filtrar_pokemons_usecase.dart';
import 'package:app_podemon/pokemon/core/domain/usecase/listar_pokemons_usecase.dart';
import 'package:app_podemon/pokemon/data/repository/listar_pokemons_repository.dart';
import 'package:app_podemon/pokemon/infra/api_pokemons.dart';

class ControllerPokemonDi {
  static PokemonController? pokemonController;
  static PokemonController getInstance({ required Function setState }) {
    final ApiPokemons apiPokemons = ApiPokemons();
    final ListarPokemonsRepository listarPokemonsRepository = ListarPokemonsRepository(apiPokemons: apiPokemons);
    final ListarPokemonsUsecase listarPokemonsUsecase = ListarPokemonsUsecase(listarPokemonsRepository: listarPokemonsRepository);
    final FilteredPokemonsUseCase filteredPokemonsUseCase = FilteredPokemonsUseCase();

    pokemonController = PokemonController(listarPokemonsUsecase: listarPokemonsUsecase, filteredPokemonsUseCase: filteredPokemonsUseCase, setState: setState);

    pokemonController ??= PokemonController(
      listarPokemonsUsecase: listarPokemonsUsecase, 
      filteredPokemonsUseCase: filteredPokemonsUseCase,
      setState: setState
    );

    return pokemonController!;
  }
}