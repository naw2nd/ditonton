import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_tv_shows_state.dart';
part 'top_rated_tv_shows_event.dart';

class TopRatedTvShowsBloc
    extends Bloc<TopRatedTvShowsEvent, TopRatedTvShowsState> {
  final GetTopRatedTvShows getTopRatedTvShows;

  TopRatedTvShowsBloc({required this.getTopRatedTvShows}) : super(TopRatedTvShowsEmpty()) {
    on<OnFetchTopRatedTvShows>((event, emit) async {
      emit(TopRatedTvShowsLoading());

      final result = await getTopRatedTvShows.execute();

      result.fold(
        (failure) {
          emit(TopRatedTvShowsError(failure.message));
        },
        (result) {
          emit(TopRatedTvShowsHasData(result));
        },
      );
    });
  }
}
