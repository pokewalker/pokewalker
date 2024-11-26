import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/pokemon.dart';
import '../provider/generic_crud_provider.dart';

class ManageBloc extends Bloc<ManageEvent, ManageState> {
  final GenericCrudProvider genericCrudProvider;

  ManageBloc({
    required ManageState initialState,
    required this.genericCrudProvider,
  }) : super(initialState) {
    GenericCrudProvider.helper.stream.listen((pokemonId) {
      add(GetPokemonListEvent());
    });

    on<DeleteEvent>((event, emit) {
      GenericCrudProvider.helper.deletePokemon(event.pokemonId);
    });

    on<UpdateRequest>(
      (event, emit) {
        emit(
          UpdateState(
            pokemonId: event.pokemonId,
            pokemons: state.pokemons,
          ),
        );
      },
    );

    on<UpdateCancel>(
      (event, emit) {
        emit(InsertState(
          pokemons: state.pokemons,
        ));
      },
    );

    on<SubmitEvent>(
      (event, emit) {
        if (state is UpdateState) {
          GenericCrudProvider.helper
              .updatePokemon((state as UpdateState).pokemonId, event.pokemon);

          emit(InsertState(pokemons: state.pokemons));
        } else if (state is InsertState) {
          GenericCrudProvider.helper.insertPokemon(event.pokemon);
        }
      },
    );

    on<GetPokemonListEvent>((event, emit) async {
      List<Pokemon> pokemons =
          await GenericCrudProvider.helper.getPokemonList();

      if (state is UpdateState) {
        emit(UpdateState(
          pokemonId: (state as UpdateState).pokemonId,
          pokemons: pokemons,
        ));
      } else if (state is InsertState) {
        emit(InsertState(
          pokemons: pokemons,
        ));
      }
    });
  }
}

/*
 Eventos
*/
abstract class ManageEvent {}

class SubmitEvent extends ManageEvent {
  Pokemon pokemon;
  SubmitEvent({required this.pokemon});
}

class DeleteEvent extends ManageEvent {
  int pokemonId;
  DeleteEvent({required this.pokemonId});
}

class GetPokemonListEvent extends ManageEvent {}

class UpdateRequest extends ManageEvent {
  int pokemonId;
  UpdateRequest({required this.pokemonId});
}

class UpdateCancel extends ManageEvent {}

/*
 Estados
*/
abstract class ManageState {
  List<Pokemon> pokemons;
  ManageState({required this.pokemons});
}

class InsertState extends ManageState {
  InsertState({required super.pokemons});
}

class UpdateState extends ManageState {
  int pokemonId;

  UpdateState({
    required this.pokemonId,
    required super.pokemons,
  });
}
