part of 'package:ditonton/presentation/bloc/now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovies extends NowPlayingMoviesEvent {}
