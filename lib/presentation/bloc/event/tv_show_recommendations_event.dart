part of 'package:ditonton/presentation/bloc/tv_show_recommendations_bloc.dart';

abstract class TvShowRecommendationsEvent {
  const TvShowRecommendationsEvent();
}

class OnFetchTvShowRecommendatios extends TvShowRecommendationsEvent {
  final int id;

  OnFetchTvShowRecommendatios(this.id);
}
