import 'dart:async';

import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../model/pokemon.dart';

String backendUrl =
    'https://2038e686-3f67-4c0d-beb1-49ce018f7d84-00-37x6uqubfbnx3.spock.replit.dev'; //TODO move to a constants file

class GenericCrudProvider {
  static GenericCrudProvider helper = GenericCrudProvider._createInstance();
  Dio _dio = Dio();

  GenericCrudProvider._createInstance() {}

  Future<Pokemon> getPokemon(int pokemonId) async {
    Response response = await _dio.get('$backendUrl/pokemons/$pokemonId');

    return Pokemon.fromMap(response.data);
  }

  Future<int> insertPokemon(Pokemon pokemon) async {
    _dio.post('$backendUrl/pokemons',
        data: pokemon
            .toMap()); //TODO make the replit return the created pokemon register

    //_controller.sink.add("1");
    return 1;
  }

  Future<int> updatePokemon(int pokemonId, Pokemon pokemon) async {
    _dio.put('$backendUrl/pokemons/$pokemonId', data: pokemon.toMap());

    //_controller.sink.add(pokemonId);
    return pokemonId;
  }

  Future<int> deletePokemon(int pokemonId) async {
    _dio.delete('$backendUrl/pokemons/$pokemonId');

    //_controller.sink.add(pokemonId);
    return pokemonId;
  }

  Future<List<Pokemon>> getPokemonList() async {
    Response response = await _dio.get('$backendUrl/pokemons');

    List<Pokemon> pokemons = [];

    response.data.forEach((value) {
      Pokemon pokemon = Pokemon.fromMap(value);
      pokemons.add(pokemon);
    });

    // response.data.forEach((key, value) {
    //   Pokemon pokemon = Pokemon.fromMap(value);
    //   pokemons.add(pokemon);
    // });

    return pokemons;
  }

  StreamController? _controller;

  Stream get stream {
    if (_controller == null) {
      _controller = StreamController();

      Socket socket =
          io(backendUrl, OptionBuilder().setTransports(['websocket']).build());

      socket.on('server_information', (data) {
        _controller!.sink.add(data);
      });
    }

    return _controller!.stream;
  }
}
