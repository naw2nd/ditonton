import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package:ditonton/presentation/bloc/state/movie_detail_state.dart';
part 'package:ditonton/presentation/bloc/event/movie_detail_event.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc(this.getMovieDetail) : super(MovieDetailEmpty()) {
    on<OnFetchMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());

      final result = await getMovieDetail.execute(event.id);

      result.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (result) {
          emit(MovieDetailHasData(result));
        },
      );
    });
  }
}
