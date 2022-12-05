part of 'package:ditonton/presentation/bloc/search_tv_shows_bloc.dart';

abstract class SearchTvShowsEvent extends Equatable {
  const SearchTvShowsEvent();

  @override
  List<Object> get props => [];
}

class OnQuerySearchTvShows extends SearchTvShowsEvent {
  final String query;

  OnQuerySearchTvShows(this.query);

  @override
  List<Object> get props => [query];
}
