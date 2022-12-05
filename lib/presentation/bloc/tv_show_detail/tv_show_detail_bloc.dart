import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_show_detail_state.dart';
part 'tv_show_detail_event.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  final GetTvShowDetail getTvShowDetail;

  TvShowDetailBloc({required this.getTvShowDetail}) : super(TvShowDetailEmpty()) {
    on<OnFetchTvShowDetail>((event, emit) async {
      emit(TvShowDetailLoading());

      final result = await getTvShowDetail.execute(event.id);

      result.fold(
        (failure) {
          emit(TvShowDetailError(failure.message));
        },
        (result) {
          emit(TvShowDetailHasData(result));
        },
      );
    });
  }
}
