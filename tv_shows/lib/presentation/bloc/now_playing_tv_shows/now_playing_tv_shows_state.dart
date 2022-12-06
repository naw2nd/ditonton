part of 'now_playing_tv_shows_bloc.dart';

abstract class NowPlayingTvShowsState extends Equatable {
  const NowPlayingTvShowsState();
  @override
  List<Object> get props => [];
}

class NowPlayingTvShowsEmpty extends NowPlayingTvShowsState {}

class NowPlayingTvShowsLoading extends NowPlayingTvShowsState {}

class NowPlayingTvShowsError extends NowPlayingTvShowsState {
  final String message;

  const NowPlayingTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvShowsHasData extends NowPlayingTvShowsState {
  final List<TvShow> result;

  const NowPlayingTvShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}
