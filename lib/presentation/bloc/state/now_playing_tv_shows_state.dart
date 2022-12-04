part of 'package:ditonton/presentation/bloc/now_playing_tv_shows_bloc.dart';

abstract class NowPlayingTvShowsState extends Equatable {
  const NowPlayingTvShowsState();
  @override
  List<Object> get props => [];
}

class NowPlayingTvShowsEmpty extends NowPlayingTvShowsState {}

class NowPlayingTvShowsLoading extends NowPlayingTvShowsState {}

class NowPlayingTvShowsError extends NowPlayingTvShowsState {
  final String message;

  NowPlayingTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvShowsHasData extends NowPlayingTvShowsState {
  final List<TvShow> result;

  NowPlayingTvShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}
