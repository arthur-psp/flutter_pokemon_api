import 'package:app_podemon/pokemon/controller/pokemon_controller.dart';
import 'package:app_podemon/pokemon/di/controller_pokemon_di.dart';
import 'package:flutter/material.dart';

class PokemonView extends StatefulWidget {
  const PokemonView({super.key});

  @override
  State<PokemonView> createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView> {
  late PokemonController pokemonController;

  @override
  initState() {
    super.initState();
    pokemonController = ControllerPokemonDi.getInstance(setState: setState);
    pokemonController.listarPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Pokemons'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Pesquisar Pokémon:',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: pokemonController.filterPokemons,
            ),
          ),

          Expanded(
            child: pokemonController.loading
                ? Center(child: Text('Nenhum pokémon foi encontrado.'))
                : ListView.builder(
                    itemCount: pokemonController.filteredPokemons.length,
                    itemBuilder: (context, index) {
                      final pokemon = pokemonController.filteredPokemons[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${pokemon.id!} - ${pokemon.name![0].toUpperCase()}${pokemon.name!.substring(1)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Image.network(
                                  pokemon.imageFrontDefault!,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  height: 150,
                                ),
                                Text('Experiência: ${pokemon.baseExperience!}'),
                                Text(
                                  'Altura: ${pokemon.height!} - Peso: ${pokemon.weight!}',
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
