import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/get_popular_tv_shows.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tv_shows_state.dart';
part 'popular_tv_shows_event.dart';

class PopularTvShowsBloc extends Bloc<PopularTvShowsEvent, PopularTvShowsState> {
  final GetPopularTvShows getPopularTvShows;

  PopularTvShowsBloc({required this.getPopularTvShows}) : super(PopularTvShowsEmpty()) {
    on<OnFetchPopularTvShows>((event, emit) async {
      emit(PopularTvShowsLoading());

      final result = await getPopularTvShows.execute();

      result.fold(
        (failure) {
          emit(PopularTvShowsError(failure.message));
        },
        (result) {
          emit(PopularTvShowsHasData(result));
        },
      );
    });
  }
}
