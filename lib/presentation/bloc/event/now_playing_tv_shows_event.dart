part of 'package:ditonton/presentation/bloc/now_playing_tv_shows_bloc.dart';

abstract class NowPlayingTvShowsEvent {
  const NowPlayingTvShowsEvent();
}

class OnFetchNowPlayingTvShows extends NowPlayingTvShowsEvent {}
