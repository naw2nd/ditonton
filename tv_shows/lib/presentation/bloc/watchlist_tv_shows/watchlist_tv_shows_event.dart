part of 'watchlist_tv_shows_bloc.dart';

abstract class WatchlistTvShowsEvent {
  const WatchlistTvShowsEvent();
}

class OnFetchWatchlistTvShows extends WatchlistTvShowsEvent {}
