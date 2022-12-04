part of 'package:ditonton/presentation/bloc/movie_search_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnQuerySearch extends SearchMoviesEvent {
  final String query;

  OnQuerySearch(this.query);

  @override
  List<Object> get props => [query];
}
