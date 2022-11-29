import 'package:ditonton/domain/entities/tv_show_episode.dart';
import 'package:equatable/equatable.dart';

class TvShowSeasonDetail extends Equatable {
  TvShowSeasonDetail({
    required this.id,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final int id;
  final List<TvShowEpisode> episodes;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  @override
  List<Object?> get props => [
        id,
        episodes,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
