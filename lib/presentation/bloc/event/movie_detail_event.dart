part of 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';

abstract class MovieDetailEvent {
  const MovieDetailEvent();
}

class OnFetchMovieDetail extends MovieDetailEvent {
  final int id;

  OnFetchMovieDetail(this.id);
}
