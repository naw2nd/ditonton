part of 'package:ditonton/presentation/bloc/top_rated_tv_shows_bloc.dart';

abstract class TopRatedTvShowsState extends Equatable {
  const TopRatedTvShowsState();
  @override
  List<Object> get props => [];
}

class TopRatedTvShowsEmpty extends TopRatedTvShowsState {}

class TopRatedTvShowsLoading extends TopRatedTvShowsState {}

class TopRatedTvShowsError extends TopRatedTvShowsState {
  final String message;

  TopRatedTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvShowsHasData extends TopRatedTvShowsState {
  final List<TvShow> result;

  TopRatedTvShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}
