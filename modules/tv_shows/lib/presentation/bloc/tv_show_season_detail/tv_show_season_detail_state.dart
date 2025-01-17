part of 'tv_show_season_detail_bloc.dart';


abstract class TvShowSeasonDetailState extends Equatable {
  const TvShowSeasonDetailState();
  @override
  List<Object> get props => [];
}

class TvShowSeasonDetailEmpty extends TvShowSeasonDetailState {}

class TvShowSeasonDetailLoading extends TvShowSeasonDetailState {}

class TvShowSeasonDetailError extends TvShowSeasonDetailState {
  final String message;

  const TvShowSeasonDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowSeasonDetailHasData extends TvShowSeasonDetailState {
  final TvShowSeasonDetail result;

  const TvShowSeasonDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
