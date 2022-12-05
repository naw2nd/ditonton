part of 'package:ditonton/presentation/bloc/tv_show_watchlist_bloc.dart';

abstract class TvShowWatchlistEvent extends Equatable {
  const TvShowWatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnGetTvShowWatchlistStatus extends TvShowWatchlistEvent {
  final int id;

  OnGetTvShowWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnSaveTvShowWatchlist extends TvShowWatchlistEvent {
  final TvShowDetail tvShowDetail;

  OnSaveTvShowWatchlist(this.tvShowDetail);

  @override
  List<Object> get props => [tvShowDetail];
}

class OnRemoveTvShowWatchlist extends TvShowWatchlistEvent {
  final TvShowDetail tvShowDetail;

  OnRemoveTvShowWatchlist(this.tvShowDetail);

  @override
  List<Object> get props => [tvShowDetail];
}
