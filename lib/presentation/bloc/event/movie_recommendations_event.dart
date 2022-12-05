part of 'package:ditonton/presentation/bloc/movie_recommendations_bloc.dart';

abstract class MovieRecommendationsEvent {
  const MovieRecommendationsEvent();
}

class OnFetchMovieRecommendatios extends MovieRecommendationsEvent {
  final int id;

  OnFetchMovieRecommendatios(this.id);
}
