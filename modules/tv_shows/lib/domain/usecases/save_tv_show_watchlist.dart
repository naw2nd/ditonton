import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv_shows/domain/entities/tv_show_detail.dart';
import 'package:tv_shows/domain/repositories/tv_show_repository.dart';

class SaveTvShowWatchlist {
  final TvShowRepository repository;

  SaveTvShowWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail movie) {
    return repository.saveTvShowWatchlist(movie);
  }
}