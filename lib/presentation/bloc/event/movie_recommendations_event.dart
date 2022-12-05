part of 'package:ditonton/presentation/bloc/movie_recommendations_bloc.dart';

abstract class MovieRecommendationsEvent extends Equatable {
  const MovieRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieRecommendatios extends MovieRecommendationsEvent {
  final int id;

  OnFetchMovieRecommendatios(this.id);

  @override
  List<Object> get props => [id];
}
