part of 'package:ditonton/presentation/bloc/top_rated_tv_shows_bloc.dart';

abstract class TopRatedTvShowsEvent extends Equatable {
  const TopRatedTvShowsEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvShows extends TopRatedTvShowsEvent {}
