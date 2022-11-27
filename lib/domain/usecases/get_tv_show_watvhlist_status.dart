import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetTvShowWatchListStatus {
  final TvShowRepository repository;

  GetTvShowWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToTvShowWatchlist(id);
  }
}
