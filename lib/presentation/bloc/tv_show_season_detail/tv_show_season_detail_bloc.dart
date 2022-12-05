import 'package:ditonton/domain/entities/tv_show_season_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_season_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_show_season_detail_state.dart';
part 'tv_show_season_detail_event.dart';

class TvShowSeasonDetailBloc
    extends Bloc<TvShowSeasonDetailEvent, TvShowSeasonDetailState> {
  final GetTvShowSeasonDetail getTvShowSeasonDetail;

  TvShowSeasonDetailBloc({required this.getTvShowSeasonDetail})
      : super(TvShowSeasonDetailEmpty()) {
    on<OnFetchTvShowSeasonDetail>((event, emit) async {
      emit(TvShowSeasonDetailLoading());

      final result =
          await getTvShowSeasonDetail.execute(event.id, event.seasonNumber);

      result.fold(
        (failure) {
          emit(TvShowSeasonDetailError(failure.message));
        },
        (result) {
          emit(TvShowSeasonDetailHasData(result));
        },
      );
    });
  }
}
