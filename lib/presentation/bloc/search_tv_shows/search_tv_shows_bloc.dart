
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/search_tv_shows.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_tv_shows_state.dart';
part 'search_tv_shows_event.dart';

class SearchTvShowsBloc extends Bloc<SearchTvShowsEvent, SearchTvShowsState> {
  final SearchTvShows searchTvShows;

  SearchTvShowsBloc({required this.searchTvShows}) : super(SearchTvShowsEmpty()) {
    on<OnQuerySearchTvShows>((event, emit) async {
      emit(SearchTvShowsLoading());

      final result = await searchTvShows.execute(event.query);

      result.fold(
        (failure) {
          emit(SearchTvShowsError(failure.message));
        },
        (result) {
          emit(SearchTvShowsHasData(result));
        },
      );
    });
  }
}
