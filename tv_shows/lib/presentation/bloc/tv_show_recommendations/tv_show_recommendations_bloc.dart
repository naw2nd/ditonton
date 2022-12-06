import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/get_tv_show_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_show_recommendations_state.dart';
part 'tv_show_recommendations_event.dart';

class TvShowRecommendationsBloc extends Bloc<TvShowRecommendationsEvent, TvShowRecommendationsState> {
  final GetTvShowRecommendations getTvShowRecommendations;

  TvShowRecommendationsBloc({required this.getTvShowRecommendations}) : super(TvShowRecommendationsEmpty()) {
    on<OnFetchTvShowRecommendatios>((event, emit) async {
      emit(TvShowRecommendationsLoading());

      final result = await getTvShowRecommendations.execute(event.id);

      result.fold(
        (failure) {
          emit(TvShowRecommendationsError(failure.message));
        },
        (result) {
          emit(TvShowRecommendationsHasData(result));
        },
      );
    });
  }
}
