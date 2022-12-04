part of 'package:ditonton/presentation/bloc/search_tv_shows_bloc.dart';

abstract class SearchTvShowsEvent extends Equatable {
  const SearchTvShowsEvent();

  @override
  List<Object> get props => [];
}

class OnQuerySearch extends SearchTvShowsEvent {
  final String query;

  OnQuerySearch(this.query);

  @override
  List<Object> get props => [query];
}
