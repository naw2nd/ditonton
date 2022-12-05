part of 'package:ditonton/presentation/bloc/top_rated_tv_shows_bloc.dart';

abstract class TopRatedTvShowsEvent {
  const TopRatedTvShowsEvent();

}

class OnFetchTopRatedTvShows extends TopRatedTvShowsEvent {}
