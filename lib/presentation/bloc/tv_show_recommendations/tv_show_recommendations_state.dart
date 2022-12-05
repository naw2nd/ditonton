part of 'tv_show_recommendations_bloc.dart';

abstract class TvShowRecommendationsState extends Equatable {
  const TvShowRecommendationsState();
  @override
  List<Object> get props => [];
}

class TvShowRecommendationsEmpty extends TvShowRecommendationsState {}

class TvShowRecommendationsLoading extends TvShowRecommendationsState {}

class TvShowRecommendationsError extends TvShowRecommendationsState {
  final String message;

  TvShowRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowRecommendationsHasData extends TvShowRecommendationsState {
  final List<TvShow> result;

  TvShowRecommendationsHasData(this.result);

  @override
  List<Object> get props => [result];
}
