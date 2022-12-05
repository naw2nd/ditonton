part of 'package:ditonton/presentation/bloc/tv_show_detail_bloc.dart';

abstract class TvShowDetailEvent {
  const TvShowDetailEvent();

}

class OnFetchTvShowDetail extends TvShowDetailEvent {
  final int id;

  OnFetchTvShowDetail(this.id);
}
