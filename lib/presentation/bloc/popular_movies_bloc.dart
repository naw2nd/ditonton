import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package:ditonton/presentation/bloc/state/popular_movies_state.dart';
part 'package:ditonton/presentation/bloc/event/popular_movies_event.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({required this.getPopularMovies}) : super(PopularMoviesEmpty()) {
    on<OnFetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());

      final result = await getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(PopularMoviesError(failure.message));
        },
        (result) {
          emit(PopularMoviesHasData(result));
        },
      );
    });
  }
}
