import 'package:app_podemon/services/pokemon/pokemon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'PokeDex'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pokemon> pokemons = [];
  List<Pokemon> filteredPokemons = [];

  @override
  void initState() {
    super.initState();
    _connectAPI();
  }

  void _connectAPI() async {
    final dio = Dio();
    try {
      var _response = await dio.get('https://pokeapi.co/api/v2/pokemon');
      List results = _response.data['results'];

      print(results);
      List<Pokemon> lista = [];
      for (var item in results) {
        var onePokemon = await dio.get(item['url']);
        lista.add(Pokemon.fromJson(onePokemon.data));
      }

      setState(() {
        pokemons = lista;
        filteredPokemons = List.from(pokemons);
      });
      print(lista);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
              onChanged: (value) => {
                if (value.isEmpty)
                  {
                    setState(() {
                      filteredPokemons = List.from(pokemons);
                    }),
                  }
                else
                  {
                    setState(() {
                      filteredPokemons = pokemons
                          .where(
                            (pokemon) => pokemon.name!.toLowerCase().contains(
                              value.toLowerCase().trim(),
                            ),
                          )
                          .toList();
                    }),
                  },
              },
            ),
          ),

          Expanded(
            child: filteredPokemons.isEmpty
                ? Center(child: Text('Nenhum pokémon foi encontrado.'))
                : ListView.builder(
                    itemCount: filteredPokemons.length,
                    itemBuilder: (context, index) {
                      final pokemon = filteredPokemons[index];
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
