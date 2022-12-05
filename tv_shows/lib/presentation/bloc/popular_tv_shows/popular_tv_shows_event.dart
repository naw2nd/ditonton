part of 'popular_tv_shows_bloc.dart';

abstract class PopularTvShowsEvent {
  const PopularTvShowsEvent();
}

class OnFetchPopularTvShows extends PopularTvShowsEvent {}
