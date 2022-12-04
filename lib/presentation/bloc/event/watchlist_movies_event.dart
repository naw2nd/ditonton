part of 'package:ditonton/presentation/bloc/watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovies extends WatchlistMoviesEvent {}
