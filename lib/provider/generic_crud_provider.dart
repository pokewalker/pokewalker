import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokewalker/bloc/auth_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../model/pokemon.dart';

String backendUrl =
    'https://2038e686-3f67-4c0d-beb1-49ce018f7d84-00-37x6uqubfbnx3.spock.replit.dev'; //TODO move to a constants file

class GenericCrudProvider {
  BuildContext? context;
  static GenericCrudProvider helper = GenericCrudProvider._createInstance();
  Dio _dio = Dio();

  GenericCrudProvider._createInstance() {}

  Future<Pokemon> getPokemon(int pokemonId) async {
    Response response = await _dio.get('$backendUrl/pokemons/$pokemonId');

    return Pokemon.fromMap(response.data);
  }

  Future<int> insertPokemon(Pokemon pokemon) async {
    // Recupera o AuthBloc usando o contexto
    final authState = BlocProvider.of<AuthBloc>(context!).state;

    // Verifica se o estado atual é Authenticated
    if (authState is Authenticated) {
      final userId = authState.id;

      try {
        Response response = await _dio
            .post('$backendUrl/pokemons?userId=$userId', data: pokemon.toMap());

        print(response.data);
        return 1; // Indica sucesso
      } catch (e) {
        print('Erro ao inserir Pokémon: $e');
        return -1; // Indica erro
      }
    } else {
      throw Exception("Usuário não está autenticado.");
    }
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
    // Recupera o AuthBloc usando o contexto
    final authState = BlocProvider.of<AuthBloc>(context!).state;

    // Verifica se o estado atual é Authenticated
    if (authState is Authenticated) {
      final userId = authState.id;

      Response response = await _dio.get('$backendUrl/pokemons?userId=$userId');

      List<Pokemon> pokemons = [];
      response.data.forEach((value) {
        Pokemon pokemon = Pokemon.fromMap(value);
        pokemons.add(pokemon);
      });

      return pokemons;
    } else {
      throw Exception("Usuário não está autenticado.");
    }
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
