import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
