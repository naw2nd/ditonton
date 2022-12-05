import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/save_movie_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_watchlist_state.dart';
part 'movie_watchlist_event.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetMovieWatchListStatus getMovieWatchlistStatus;
  final SaveMovieWatchlist saveMovieWatchlist;
  final RemoveMovieWatchlist removeMovieWatchlist;

  MovieWatchlistBloc({
    required this.saveMovieWatchlist,
    required this.removeMovieWatchlist,
    required this.getMovieWatchlistStatus,
  }) : super(MovieWatchlistEmpty()) {
    on<OnGetMovieWatchlistStatus>((event, emit) async {
      emit(MovieWatchlistLoading());

      final result = await getMovieWatchlistStatus.execute(event.id);
      emit(MovieWatchlistHasData(result, ''));
    });

    on<OnSaveMovieWatchlist>((event, emit) async {
      emit(MovieWatchlistLoading());

      final result = await saveMovieWatchlist.execute(event.movieDetail);

      result.fold(
        (failure) {
          emit(MovieWatchlistError(failure.message));
        },
        (result) {
          emit(MovieWatchlistHasData(true, result));
        },
      );
    });

    on<OnRemoveMovieWatchlist>((event, emit) async {
      emit(MovieWatchlistLoading());

      final result = await removeMovieWatchlist.execute(event.movieDetail);

      result.fold(
        (failure) {
          emit(MovieWatchlistError(failure.message));
        },
        (result) {
          emit(MovieWatchlistHasData(false, result));
        },
      );
    });
  }
}
