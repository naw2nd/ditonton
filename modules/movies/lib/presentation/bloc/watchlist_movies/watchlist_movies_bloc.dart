import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movies_state.dart';
part 'watchlist_movies_event.dart';

class WatchlistMoviesBloc extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMoviesBloc({required this.getWatchlistMovies}) : super(WatchlistMoviesEmpty()) {
    on<OnFetchWatchlistMovies>((event, emit) async {
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
