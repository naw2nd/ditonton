import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_shows.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package:ditonton/presentation/bloc/state/popular_tv_shows_state.dart';
part 'package:ditonton/presentation/bloc/event/popular_tv_shows_event.dart';

class PopularTvShowsBloc extends Bloc<PopularTvShowsEvent, PopularTvShowsState> {
  final GetPopularTvShows getPopularTvShows;

  PopularTvShowsBloc(this.getPopularTvShows) : super(PopularTvShowsEmpty()) {
    on<OnFetchTvShows>((event, emit) async {
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
