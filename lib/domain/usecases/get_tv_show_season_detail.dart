import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show_season_detail.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetTvShowSeasonDetail {
  final TvShowRepository repository;

  GetTvShowSeasonDetail(this.repository);

  Future<Either<Failure, TvShowSeasonDetail>> execute(
      int id, int seasonNumber) {
    return repository.getTvShowSeasonDetail(id, seasonNumber);
  }
}
