import 'package:movies/domain/repositories/movie_repository.dart';

class GetMovieWatchListStatus {
  final MovieRepository repository;

  GetMovieWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToMovieWatchlist(id);
  }
}
