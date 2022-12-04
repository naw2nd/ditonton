import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package:ditonton/presentation/bloc/state/now_playing_movies_state.dart';
part 'package:ditonton/presentation/bloc/event/now_playing_movies_event.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc(this.getNowPlayingMovies) : super(NowPlayingMoviesEmpty()) {
    on<OnFetchMovies>((event, emit) async {
      emit(NowPlayingMoviesLoading());

      final result = await getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(NowPlayingMoviesError(failure.message));
        },
        (result) {
          emit(NowPlayingMoviesHasData(result));
        },
      );
    });
  }
}
