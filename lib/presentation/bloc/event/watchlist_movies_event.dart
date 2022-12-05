part of 'package:ditonton/presentation/bloc/watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent {
  const WatchlistMoviesEvent();

}

class OnFetchWatchlistMovies extends WatchlistMoviesEvent {}
