import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/repositories/movie_repository.dart';

class RemoveMovieWatchlist {
  final MovieRepository repository;

  RemoveMovieWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeMovieWatchlist(movie);
  }
}
