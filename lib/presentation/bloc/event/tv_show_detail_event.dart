part of 'package:ditonton/presentation/bloc/tv_show_detail_bloc.dart';

abstract class TvShowDetailEvent extends Equatable {
  const TvShowDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvShowDetail extends TvShowDetailEvent {
  final int id;

  OnFetchTvShowDetail(this.id);

  @override
  List<Object> get props => [id];
}
