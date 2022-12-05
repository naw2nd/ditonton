part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();
  @override
  List<Object> get props => [];
}

class MovieWatchlistEmpty extends MovieWatchlistState {}

class MovieWatchlistLoading extends MovieWatchlistState {}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  const MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistHasData extends MovieWatchlistState {
  final bool result;
  final String message;

  const MovieWatchlistHasData(this.result, this.message);

  @override
  List<Object> get props => [result, message];
}

// class MovieWatchlistStatusEmpty extends MovieWatchlistState {}

// class MovieWatchlistStatusLoading extends MovieWatchlistState {}

// class MovieWatchlistStatusError extends MovieWatchlistState {
//   final String message;

//   MovieWatchlistStatusError(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class MovieWatchlistStatusHasData extends MovieWatchlistState {
//   final bool result;

//   MovieWatchlistStatusHasData(this.result);

//   @override
//   List<Object> get props => [result];
// }
