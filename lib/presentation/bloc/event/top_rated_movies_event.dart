part of 'package:ditonton/presentation/bloc/top_rated_movies_bloc.dart';

abstract class TopRatedMoviesEvent extends Equatable {
  const TopRatedMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTopRatedMovies extends TopRatedMoviesEvent {}
