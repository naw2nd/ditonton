part of 'package:ditonton/presentation/bloc/now_playing_tv_shows_bloc.dart';

abstract class NowPlayingTvShowsEvent extends Equatable {
  const NowPlayingTvShowsEvent();

  @override
  List<Object> get props => [];
}

class OnFetchNowPlayingTvShows extends NowPlayingTvShowsEvent {}
