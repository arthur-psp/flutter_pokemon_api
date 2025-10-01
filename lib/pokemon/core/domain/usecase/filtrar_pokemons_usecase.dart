import 'package:app_podemon/pokemon/core/domain/model/pokemon.dart';

class FilteredPokemonsUseCase {
  List<Pokemon> call(List<Pokemon> pokemons, String value) {
    if (value.isEmpty) {
      return List.from(pokemons);
    } else {
      return pokemons
          .where(
            (pokemon) => pokemon.name!.toLowerCase().contains(
              value.toLowerCase().trim(),
            ),
          )
          .toList();
    }
  }
}
