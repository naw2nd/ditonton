part of 'package:ditonton/presentation/bloc/popular_tv_shows_bloc.dart';

abstract class PopularTvShowsEvent extends Equatable {
  const PopularTvShowsEvent();

  @override
  List<Object> get props => [];
}

class OnFetchPopularTvShows extends PopularTvShowsEvent {}
