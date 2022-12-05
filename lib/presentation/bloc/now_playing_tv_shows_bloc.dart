import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_shows.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package:ditonton/presentation/bloc/state/now_playing_tv_shows_state.dart';
part 'package:ditonton/presentation/bloc/event/now_playing_tv_shows_event.dart';

class NowPlayingTvShowsBloc extends Bloc<NowPlayingTvShowsEvent, NowPlayingTvShowsState> {
  final GetNowPlayingTvShows getNowPlayingTvShows;

  NowPlayingTvShowsBloc({required this.getNowPlayingTvShows}) : super(NowPlayingTvShowsEmpty()) {
    on<OnFetchNowPlayingTvShows>((event, emit) async {
      emit(NowPlayingTvShowsLoading());

      final result = await getNowPlayingTvShows.execute();

      result.fold(
        (failure) {
          emit(NowPlayingTvShowsError(failure.message));
        },
        (result) {
          emit(NowPlayingTvShowsHasData(result));
        },
      );
    });
  }
}
