import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package:ditonton/presentation/bloc/state/watchlist_movies_state.dart';
part 'package:ditonton/presentation/bloc/event/watchlist_movies_event.dart';

class WatchlistMoviesBloc extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMoviesBloc(this.getWatchlistMovies) : super(WatchlistMoviesEmpty()) {
    on<OnFetchMovies>((event, emit) async {
      emit(WatchlistMoviesLoading());

      final result = await getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(WatchlistMoviesError(failure.message));
        },
        (result) {
          emit(WatchlistMoviesHasData(result));
        },
      );
    });
  }
}
