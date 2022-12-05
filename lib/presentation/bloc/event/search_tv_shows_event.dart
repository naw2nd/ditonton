part of 'package:ditonton/presentation/bloc/search_tv_shows_bloc.dart';

abstract class SearchTvShowsEvent{
  const SearchTvShowsEvent();

}

class OnQuerySearchTvShows extends SearchTvShowsEvent {
  final String query;

  OnQuerySearchTvShows(this.query);

}
