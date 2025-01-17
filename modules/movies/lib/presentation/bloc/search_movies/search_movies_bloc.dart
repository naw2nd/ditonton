
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_movies_state.dart';
part 'search_movies_event.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;

  SearchMoviesBloc({required this.searchMovies}) : super(SearchMoviesEmpty()) {
    on<OnQuerySearchMovies>((event, emit) async {
      emit(SearchMoviesLoading());

      final result = await searchMovies.execute(event.query);

      result.fold(
        (failure) {
          emit(SearchMoviesError(failure.message));
        },
        (result) {
          emit(SearchMoviesHasData(result));
        },
      );
    });
  }
}
