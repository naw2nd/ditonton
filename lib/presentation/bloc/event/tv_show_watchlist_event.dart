part of 'package:ditonton/presentation/bloc/tv_show_watchlist_bloc.dart';

abstract class TvShowWatchlistEvent {
  const TvShowWatchlistEvent();
}

class OnGetTvShowWatchlistStatus extends TvShowWatchlistEvent {
  final int id;

  OnGetTvShowWatchlistStatus(this.id);
}

class OnSaveTvShowWatchlist extends TvShowWatchlistEvent {
  final TvShowDetail tvShowDetail;

  OnSaveTvShowWatchlist(this.tvShowDetail);
}

class OnRemoveTvShowWatchlist extends TvShowWatchlistEvent {
  final TvShowDetail tvShowDetail;

  OnRemoveTvShowWatchlist(this.tvShowDetail);
}
