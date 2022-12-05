part of 'package:ditonton/presentation/bloc/tv_show_season_detail_bloc.dart';

abstract class TvShowSeasonDetailEvent {
  const TvShowSeasonDetailEvent();
}

class OnFetchTvShowSeasonDetail extends TvShowSeasonDetailEvent {
  final int id;
  final int seasonNumber;

  OnFetchTvShowSeasonDetail(this.id, this.seasonNumber);

}
