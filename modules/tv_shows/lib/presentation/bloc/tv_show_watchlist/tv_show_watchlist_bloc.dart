import 'package:tv_shows/domain/entities/tv_show_detail.dart';
import 'package:tv_shows/domain/usecases/get_tv_show_watchlist_status.dart';
import 'package:tv_shows/domain/usecases/remove_tv_show_watchlist.dart';
import 'package:tv_shows/domain/usecases/save_tv_show_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_show_watchlist_state.dart';
part 'tv_show_watchlist_event.dart';

class TvShowWatchlistBloc
    extends Bloc<TvShowWatchlistEvent, TvShowWatchlistState> {
  final GetTvShowWatchListStatus getTvShowWatchlistStatus;
  final SaveTvShowWatchlist saveTvShowWatchlist;
  final RemoveTvShowWatchlist removeTvShowWatchlist;

  TvShowWatchlistBloc({
    required this.saveTvShowWatchlist,
    required this.removeTvShowWatchlist,
    required this.getTvShowWatchlistStatus,
  }) : super(TvShowWatchlistEmpty()) {
    on<OnGetTvShowWatchlistStatus>((event, emit) async {
      emit(TvShowWatchlistLoading());

      final result = await getTvShowWatchlistStatus.execute(event.id);
      emit(TvShowWatchlistHasData(result, ''));
    });

    on<OnSaveTvShowWatchlist>((event, emit) async {
      emit(TvShowWatchlistLoading());

      final result = await saveTvShowWatchlist.execute(event.tvShowDetail);

      result.fold(
        (failure) {
          emit(TvShowWatchlistError(failure.message));
        },
        (result) {
          emit(TvShowWatchlistHasData(true, result));
        },
      );
    });

    on<OnRemoveTvShowWatchlist>((event, emit) async {
      emit(TvShowWatchlistLoading());

      final result = await removeTvShowWatchlist.execute(event.tvShowDetail);

      result.fold(
        (failure) {
          emit(TvShowWatchlistError(failure.message));
        },
        (result) {
          emit(TvShowWatchlistHasData(false, result));
        },
      );
    });
  }
}
