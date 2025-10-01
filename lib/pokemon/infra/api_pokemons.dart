import 'package:app_podemon/pokemon/data/model/pokemon_model.dart';
import 'package:dio/dio.dart';

class ApiPokemons {
  final String baseUrl = 'https://pokeapi.co/api/v2/pokemon';
  
  final dio = Dio();

  Future<List<PokemonModel>> listPokemons() async {
    try {
      var _response = await dio.get('$baseUrl');

      if (_response.statusCode == 200 || _response.statusCode == 201) {
        print('conectou com a api');
      } else {
        throw Exception('Erro ao buscar pokemon: $_response.statusCode');
      }
      
      List results = _response.data['results'];

      List<PokemonModel> lista = [];

      for (var item in results) {
        var onePokemon = await dio.get(item['url']);
        lista.add(PokemonModel.fromJson(onePokemon.data));
      }

      return lista;
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }
}