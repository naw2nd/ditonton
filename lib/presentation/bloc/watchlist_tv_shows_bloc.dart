import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_shows.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package:ditonton/presentation/bloc/state/watchlist_tv_shows_state.dart';
part 'package:ditonton/presentation/bloc/event/watchlist_tv_shows_event.dart';

class WatchlistTvShowsBloc extends Bloc<WatchlistTvShowsEvent, WatchlistTvShowsState> {
  final GetWatchlistTvShows getWatchlistTvShows;

  WatchlistTvShowsBloc({required this.getWatchlistTvShows}) : super(WatchlistTvShowsEmpty()) {
    on<OnFetchWatchlistTvShows>((event, emit) async {
      emit(WatchlistTvShowsLoading());

      final result = await getWatchlistTvShows.execute();

      result.fold(
        (failure) {
          emit(WatchlistTvShowsError(failure.message));
        },
        (result) {
          emit(WatchlistTvShowsHasData(result));
        },
      );
    });
  }
}
