import 'package:tv_shows/data/models/tv_show_episode_model.dart';
import 'package:tv_shows/domain/entities/tv_show_season_detail.dart';
import 'package:equatable/equatable.dart';

class TvShowSeasonDetailResponse extends Equatable {
  const TvShowSeasonDetailResponse({
    required this.id,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final int id;
  final List<TvShowEpisodeModel> episodes;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  factory TvShowSeasonDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvShowSeasonDetailResponse(
        id: json["id"],
        episodes: List<TvShowEpisodeModel>.from(
            json["episodes"].map((x) => TvShowEpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  TvShowSeasonDetail toEntity() => TvShowSeasonDetail(
        id: id,
        episodes: episodes.map((episode) => episode.toEntity()).toList(),
        name: name,
        overview: overview,
        posterPath: posterPath,
        seasonNumber: seasonNumber,
      );

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
