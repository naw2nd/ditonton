part of 'package:ditonton/presentation/bloc/top_rated_movies_bloc.dart';

abstract class TopRatedMoviesEvent  {
  const TopRatedMoviesEvent();

}

class OnFetchTopRatedMovies extends TopRatedMoviesEvent {}
