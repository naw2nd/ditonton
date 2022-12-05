part of 'package:ditonton/presentation/bloc/movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnGetMovieWatchlistStatus extends MovieWatchlistEvent {
  final int id;

  OnGetMovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnSaveMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  OnSaveMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRemoveMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  OnRemoveMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
