part of 'package:ditonton/presentation/bloc/watchlist_tv_shows_bloc.dart';

abstract class WatchlistTvShowsState extends Equatable {
  const WatchlistTvShowsState();
  @override
  List<Object> get props => [];
}

class WatchlistTvShowsEmpty extends WatchlistTvShowsState {}

class WatchlistTvShowsLoading extends WatchlistTvShowsState {}

class WatchlistTvShowsError extends WatchlistTvShowsState {
  final String message;

  WatchlistTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvShowsHasData extends WatchlistTvShowsState {
  final List<TvShow> result;

  WatchlistTvShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}
