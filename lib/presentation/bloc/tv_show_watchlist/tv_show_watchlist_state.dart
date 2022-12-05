part of 'tv_show_watchlist_bloc.dart';

abstract class TvShowWatchlistState extends Equatable {
  const TvShowWatchlistState();
  @override
  List<Object> get props => [];
}

class TvShowWatchlistEmpty extends TvShowWatchlistState {}

class TvShowWatchlistLoading extends TvShowWatchlistState {}

class TvShowWatchlistError extends TvShowWatchlistState {
  final String message;

  TvShowWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowWatchlistHasData extends TvShowWatchlistState {
  final bool result;
  final String message;

  TvShowWatchlistHasData(this.result, this.message);

  @override
  List<Object> get props => [result, message];
}
