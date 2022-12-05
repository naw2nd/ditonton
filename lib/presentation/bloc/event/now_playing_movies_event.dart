part of 'package:ditonton/presentation/bloc/now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesEvent {
  const NowPlayingMoviesEvent();
}

class OnFetchNowPlayingMovies extends NowPlayingMoviesEvent {}
