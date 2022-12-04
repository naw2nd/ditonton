part of 'package:ditonton/presentation/bloc/watchlist_tv_shows_bloc.dart';

abstract class WatchlistTvShowsEvent extends Equatable {
  const WatchlistTvShowsEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvShows extends WatchlistTvShowsEvent {}
