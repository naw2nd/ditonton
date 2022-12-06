part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent {
  const MovieWatchlistEvent();
}

class OnGetMovieWatchlistStatus extends MovieWatchlistEvent {
  final int id;

  OnGetMovieWatchlistStatus(this.id);
}

class OnSaveMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  OnSaveMovieWatchlist(this.movieDetail);
}

class OnRemoveMovieWatchlist extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  OnRemoveMovieWatchlist(this.movieDetail);
}
