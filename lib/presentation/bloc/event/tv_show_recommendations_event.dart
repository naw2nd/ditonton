part of 'package:ditonton/presentation/bloc/tv_show_recommendations_bloc.dart';

abstract class TvShowRecommendationsEvent extends Equatable {
  const TvShowRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvShowRecommendatios extends TvShowRecommendationsEvent {
  final int id;

  OnFetchTvShowRecommendatios(this.id);

  @override
  List<Object> get props => [id];
}
