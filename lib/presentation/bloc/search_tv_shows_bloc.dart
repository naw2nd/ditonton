
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/search_tv_shows.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package:ditonton/presentation/bloc/state/search_tv_shows_state.dart';
part 'package:ditonton/presentation/bloc/event/search_tv_shows_event.dart';

class SearchTvShowsBloc extends Bloc<SearchTvShowsEvent, SearchTvShowsState> {
  final SearchTvShows searchTvShows;

  SearchTvShowsBloc(this.searchTvShows) : super(SearchTvShowsEmpty()) {
    on<OnQuerySearch>((event, emit) async {
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
