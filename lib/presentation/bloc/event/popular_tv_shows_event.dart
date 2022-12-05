part of 'package:ditonton/presentation/bloc/popular_tv_shows_bloc.dart';

abstract class PopularTvShowsEvent {
  const PopularTvShowsEvent();
}

class OnFetchPopularTvShows extends PopularTvShowsEvent {}
