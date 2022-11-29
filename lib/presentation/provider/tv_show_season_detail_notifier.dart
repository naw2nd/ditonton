import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show_season_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_season_detail.dart';
import 'package:flutter/material.dart';

class TvShowSeasonDetailNotifier extends ChangeNotifier {
  final GetTvShowSeasonDetail getTvShowSeasonDetail;

  TvShowSeasonDetailNotifier({
    required this.getTvShowSeasonDetail,
  });

  late TvShowSeasonDetail _tvShowSeason;
  TvShowSeasonDetail get tvShowSeason => _tvShowSeason;

  RequestState _tvShowSeasonState = RequestState.Empty;
  RequestState get tvShowSeasonState => _tvShowSeasonState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvShowSeasonDetail(int id, int seasonNumber) async {
    _tvShowSeasonState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvShowSeasonDetail.execute(id, seasonNumber);
    detailResult.fold(
      (failure) {
        _tvShowSeasonState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowSeason) {
        _tvShowSeason = tvShowSeason;
        _tvShowSeasonState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
